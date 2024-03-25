import 'package:flutter/material.dart';
import 'package:noteapp/controller/note_screen_controller.dart';
import 'package:noteapp/core/colorconstant/colorconstant.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen(
      {super.key,
      required this.title,
      required this.desc,
      required this.date,
      required this.colorindex});
  final String title;
  final String desc;
  final String date;
  final int colorindex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: NoteScreenController.colorConstant[colorindex],
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              Icon(Icons.edit),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.delete)
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            desc,
            style:
                TextStyle(color: ColorConstants.primaryBlack.withOpacity(.4)),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                date,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 15,
              ),
              Icon(Icons.share)
            ],
          )
        ],
      ),
    );
  }
}