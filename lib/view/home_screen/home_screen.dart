import 'package:flutter/material.dart';
import 'package:noteapp/controller/note_screen_controller.dart';
import 'package:noteapp/core/colorconstant/colorconstant.dart';
import 'package:noteapp/view/home_screen/listview_continer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TextEditingController titleEditingController = TextEditingController();
TextEditingController desEditingController = TextEditingController();
TextEditingController dateEditingController = TextEditingController();
int selectedColorIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBlack,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryBlack,
        centerTitle: true,
        title: Text(
          "PENPAD",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: ColorConstants.primaryWhite),
        ),
      ),
      body: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => ListViewScreen(
                    title: NoteScreenController.notesList[index]["title"],
                    desc: NoteScreenController.notesList[index]["dis"],
                    date: NoteScreenController.notesList[index]["date"],
                    colorindex: NoteScreenController.notesList[index]
                        ["colorIndex"],
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: NoteScreenController.notesList.length)
          // Container(
          //   child: Column(
          //     children: [],
          //   ),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: ColorConstants.primaryGrey.withOpacity(.8),
            isScrollControlled: true,
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, dsetState) => Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleEditingController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          hintText: "Title",
                          fillColor: ColorConstants.primaryGrey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: desEditingController,
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          hintText: "Description",
                          fillColor: ColorConstants.primaryGrey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: dateEditingController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          hintText: "Date",
                          fillColor: ColorConstants.primaryGrey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          4,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: ColorConstants.primaryRed),
                                  color:
                                      NoteScreenController.colorConstant[index],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {});
                            // textEditingController.text.toString();
                            // print(textEditingController.text.toString());
                            NoteScreenController.addNote(
                                title: titleEditingController.text,
                                date: dateEditingController.text,
                                des: desEditingController.text,
                                colorIndex: selectedColorIndex);
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Add",
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: ColorConstants.primaryWhite,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 40,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Cancel",
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: ColorConstants.primaryWhite,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
