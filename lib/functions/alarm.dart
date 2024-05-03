import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

Future<void> setAlarm(int id) async {
  await AndroidAlarmManager.initialize();
  await AndroidAlarmManager.cancel(id);

  final startTime = const TimeOfDay(hour: 0, minute: 1);
  final endTime = const TimeOfDay(hour: 10, minute: 0);
  final tic = 1;
  final nextTic = await getNextTic(startTime, endTime, tic);

  final alarm = await AndroidAlarmManager.oneShotAt(
    nextTic,
    0,
    setAlarm,
    wakeup: true,
    exact: true,
    rescheduleOnReboot: true,
  );
  final now = DateTime.now();
  print(alarm);
  print('Tic in ${now.toString()}');
  print('Next tic in ${nextTic.toString()}');
}

Future<DateTime> getNextTic(
    TimeOfDay startTime, TimeOfDay endTime, int ticMinutes) async {
  final delta = (endTime.hour * 60 +
          endTime.minute -
          (startTime.hour * 60 + startTime.minute)) %
      1440;
  final now = DateTime.now();
  var start =
      DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
  if (start.isAfter(now)) {
    start = start.subtract(const Duration(days: 1));
  }
  if (now.isAfter(start) && now.isBefore(start.add(Duration(minutes: delta)))) {
    var timeToReturn = start.copyWith();
    while (timeToReturn.isBefore(now)) {
      timeToReturn = timeToReturn.add(Duration(minutes: ticMinutes));
    }
    if (timeToReturn.isAfter(start.add(Duration(minutes: delta)))) {
      return start.add(const Duration(days: 1));
    } else {
      return timeToReturn;
    }
  } else if (now.isAfter(start)) {
    return start.add(const Duration(days: 1));
  } else if (now.isBefore(start)) {
    return start;
  } else {
    return now.add(const Duration(minutes: 1));
  }
}
