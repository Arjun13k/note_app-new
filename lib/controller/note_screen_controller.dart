import 'package:flutter/material.dart';
import 'package:noteapp/core/colorconstant/colorconstant.dart';

class NoteScreenController {
  static List notesList = [];

  static List<Color> colorConstant = [
    ColorConstants.primaryBlue,
    ColorConstants.primaryGreen,
    ColorConstants.primaryRed,
    ColorConstants.primaryGrey
  ];

  //  to add single note

  static void addNote({
    required String title,
    required String des,
    required String date,
    required int colorIndex,
  }) {
    notesList.add(
        {"title": title, "dis": des, "date": date, "colorIndex": colorIndex});
  }
}
