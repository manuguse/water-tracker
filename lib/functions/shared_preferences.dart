import 'package:agua_diaria/models/settings_items.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setTimeOfDay(TimeOfDay timeOfDay, String prefix) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('${prefix}Hour', timeOfDay.hour);
  await prefs.setInt('${prefix}Minutes', timeOfDay.minute);
}

Future<void> setSharedPrefsBool(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value);
}

Future<void> setSharedPrefsInt(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}

Future<SettingsItems> getSettingsItems() async {
  final prefs = await SharedPreferences.getInstance();
  final wakingTimeHour = prefs.getInt('wakingHour') ?? 6;
  final wakingTimeMinutes = prefs.getInt('wakingMinutes') ?? 0;
  final sleepingTimeHour = prefs.getInt('sleepingHour') ?? 22;
  final sleepingMinutes = prefs.getInt('sleepingMinutes') ?? 0;

  final wakingTime = TimeOfDay(hour: wakingTimeHour, minute: wakingTimeMinutes);
  final sleepingTime =
      TimeOfDay(hour: sleepingTimeHour, minute: sleepingMinutes);
  final bool darkMode = prefs.getBool('darkmode') ?? false;
  final bool reminders = prefs.getBool('reminders') ?? true;
  final int goalAmount = prefs.getInt('goalAmount')!;

  return SettingsItems(
      wakingTime: wakingTime,
      sleepingTime: sleepingTime,
      darkMode: darkMode,
      reminders: reminders,
      goalAmount: goalAmount);
}
