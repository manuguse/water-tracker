import 'package:agua_diaria/models/goal_amount.dart';
import 'package:agua_diaria/views/goal.dart';
import 'package:agua_diaria/views/recommended_amount.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFDCE5F1),
        textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Color(0xFF020A0F), fontSize: 16))),
    home: const HistoryScreen(),
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
                      ChangeNotifierProvider.value(
                          value: GoalAmount(amount: goalAmount),
                          child: const GoalScreen())));
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
