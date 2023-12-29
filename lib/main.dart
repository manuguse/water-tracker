import 'package:agua_diaria/views/goal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFDCE5F1),
        textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Color(0xFF020A0F), fontSize: 16))),
    home: const GoalScreen(),
  ));
}
