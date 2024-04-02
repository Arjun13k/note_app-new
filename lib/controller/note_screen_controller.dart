import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/core/colorconstant/colorconstant.dart';

class NoteScreenController {
  static List notesListKey = [];

  static List<Color> colorConstant = [
    ColorConstants.primaryBlue,
    ColorConstants.primaryGreen,
    ColorConstants.primaryRed,
    ColorConstants.primaryGrey
  ];
  static getInitStateKey() {
    notesListKey = myBox.keys.toList();
  }

//  hive reference
  static var myBox = Hive.box('noteBox');
  //  to add single note

  static Future<void> addNote({
    required String title,
    required String des,
    required String date,
    required int colorIndex,
  }) async {
    await myBox.add(
        {"title": title, "dis": des, "date": date, "colorIndex": colorIndex});
    notesListKey = myBox.keys.toList();
  }

  static Future<void> delete(var key) async {
    await myBox.delete(key);
    notesListKey = myBox.keys.toList();
  }

  static Future<void> edit({
    required var key,
    required String title,
    required String des,
    required String date,
    required int colorIndex,
  }) async {
    await myBox.put(key,
        {"title": title, "dis": des, "date": date, "colorIndex": colorIndex});
  }
}
