import 'dart:io';

import 'package:agua_diaria/models/goal_amount.dart';
import 'package:agua_diaria/views/tabs/goal/recommended_amount.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/tab.dart';

void main() async {
  runApp(MaterialApp(
    theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFDCE5F1),
        appBarTheme: const AppBarTheme(color: Color(0xFF3688D3)),
        textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Color(0xFF020A0F), fontSize: 16))),
    home: const LoadScreen(),
  ));
}

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final goalAmount = prefs.getInt('goalAmount');
      if (goalAmount == null) {
        if (context.mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const RecommendedAmount(first: true)));
        }
      } else {
        if (context.mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ChangeNotifierProvider<GoalAmount>(
                          create: (_) => GoalAmount(amount: goalAmount),
                          child: const TabScreen())));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
