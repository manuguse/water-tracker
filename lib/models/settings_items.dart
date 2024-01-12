import 'package:flutter/material.dart';

class SettingsItems {
  final TimeOfDay wakingTime, sleepingTime;
  final bool darkMode, reminders;
  final int goalAmount;

  SettingsItems(
      {required this.wakingTime,
      required this.sleepingTime,
      required this.darkMode,
      required this.reminders,
      required this.goalAmount});
}

class SettingsItemsToEdit {
  TimeOfDay wakingTime, sleepingTime;
  bool darkMode, reminders;
  int goalAmount;

  SettingsItemsToEdit(
      {required this.wakingTime,
      required this.sleepingTime,
      required this.darkMode,
      required this.reminders,
      required this.goalAmount});

  SettingsItemsToEdit.fromSettingsItems(SettingsItems settingsItems)
      : wakingTime = settingsItems.wakingTime,
        sleepingTime = settingsItems.sleepingTime,
        darkMode = settingsItems.darkMode,
        reminders = settingsItems.reminders,
        goalAmount = settingsItems.goalAmount;
}
