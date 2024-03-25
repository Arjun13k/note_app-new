import 'package:flutter/material.dart';
import 'package:noteapp/view/home_screen/home_screen.dart';
import 'package:noteapp/view/splash_screen/splash_screen.dart';

void main() {
  runApp(NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
