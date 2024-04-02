import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  void initState() {
    NoteScreenController.getInitStateKey();
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final currentKey = NoteScreenController.notesListKey[index];
                  final currentElement =
                      NoteScreenController.myBox.get(currentKey);
                  return ListViewScreen(
                    title: currentElement["title"],
                    desc: currentElement["dis"],
                    date: currentElement["date"],
                    colorindex: currentElement["colorIndex"],
                    onDeletePres: () {
                      NoteScreenController.delete(currentKey);
                      setState(() {});
                    },
                    oneditPres: () {
                      titleEditingController.text = currentElement["title"];
                      desEditingController.text = currentElement["dis"];
                      dateEditingController.text = currentElement["date"];
                      selectedColorIndex = currentElement["colorIndex"];

                      customBottomSheet(isEdit: true, key: currentKey);
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: NoteScreenController.notesListKey.length)
            // Container(
            //   child: Column(
            //     children: [],
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleEditingController.clear();
          desEditingController.clear();
          dateEditingController.clear();
          int selectedColorIndex = 0;
          customBottomSheet(isEdit: false);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> customBottomSheet({var key = 0, isEdit = false}) {
    return showModalBottomSheet(
      backgroundColor: ColorConstants.primaryGrey.withOpacity(.8),
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, dsetState) => Container(
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                readOnly: true,
                controller: dateEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    hintText: "Date",
                    fillColor: ColorConstants.primaryGrey,
                    suffixIcon: InkWell(
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030));
                          if (selectedDate != null) {
                            String formateDate =
                                DateFormat("dd/MM/yyyy").format(selectedDate);
                            dateEditingController.text = formateDate.toString();
                          }

                          setState(() {});
                        },
                        child: Icon(Icons.calendar_month))),
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
                        selectedColorIndex = index;
                        dsetState(() {});
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            border: selectedColorIndex == index
                                ? Border.all(
                                    width: 2, color: ColorConstants.primaryRed)
                                : null,
                            color: NoteScreenController.colorConstant[index],
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
                    onTap: () async {
                      setState(() {});
                      // textEditingController.text.toString();
                      // print(textEditingController.text.toString());

                      if (isEdit == true) {
                        await NoteScreenController.edit(
                            key: key,
                            title: titleEditingController.text,
                            date: dateEditingController.text,
                            des: desEditingController.text,
                            colorIndex: selectedColorIndex);
                      } else {
                        NoteScreenController.addNote(
                            title: titleEditingController.text,
                            date: dateEditingController.text,
                            des: desEditingController.text,
                            colorIndex: selectedColorIndex);
                      }

                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      child: Center(
                        child: Text(
                          isEdit == true ? "edit" : "Add",
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
  }
}
