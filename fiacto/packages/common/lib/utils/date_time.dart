import 'dart:math';

import 'package:flutter/material.dart';

extension DateTimeHelper on DateTime {
  /// Returns true if the date is today.
  bool get isToday => isSameDay(DateTime.now());

  /// Returns first date of month.
  DateTime get firstDateOfMonth => DateTime(year, month);

  /// Returns last date of month.
  DateTime get lastDateOfMonth {
    final dateTime = _addMonths(this, 1);
    return DateTime(dateTime.year, dateTime.month, 0);
  }

  /// Returns first date of week.
  DateTime get firstDateOfWeek => subtract(Duration(days: weekday - 1));

  /// Returns last date of week.
  DateTime get lastDateOfWeek => subtract(Duration(days: weekday - 7));

  /// Returns first day of week.
  int get firstDayOfWeek => firstDateOfWeek.day;

  /// Returns last day of week.
  int get lastDayOfWeek => lastDateOfWeek.day;

  /// Returns start of day.
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns end of day.
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999, 999);

  DateTime dateNow() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  bool isBeforeToday() => isBefore(dateNow());

  bool isBeforeNow() => isBefore(DateTime.now());

  /// Returns true if the date is the same day as [other].
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Returns true if the time is the same time as [other].
  bool isSameTime(DateTime other) =>
      hour == other.hour && minute == other.minute;

  DateTime addTime(TimeOfDay time) =>
      DateTime(year, month, day, time.hour, time.minute);

  DateTime withTime(DateTime time) =>
      DateTime(year, month, day, time.hour, time.minute, time.second);

  DateTime _addMonths(DateTime from, int months) {
    final r = months % 12;
    final q = (months - r) ~/ 12;
    var newYear = from.year + q;
    var newMonth = from.month + r;
    if (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }
    final newDay = min(from.day, _daysInMonth(newYear, newMonth));
    if (from.isUtc) {
      return DateTime.utc(
        newYear,
        newMonth,
        newDay,
        from.hour,
        from.minute,
        from.second,
        from.millisecond,
        from.microsecond,
      );
    } else {
      return DateTime(
        newYear,
        newMonth,
        newDay,
        from.hour,
        from.minute,
        from.second,
        from.millisecond,
        from.microsecond,
      );
    }
  }

  int _daysInMonth(int year, int month) {
    var result = _daysInMonthArray[month];
    if (month == 2 && _isLeapYear(year)) result++;
    return result;
  }

  DateTime getNearestFifteenMinutes() {
    var now = DateTime.now();
    final minutes = now.minute;
    if (minutes <= 15) {
      now = now.add(Duration(minutes: 15 - minutes));
    } else if (minutes <= 30) {
      now = now.add(Duration(minutes: 30 - minutes));
    } else if (minutes <= 45) {
      now = now.add(Duration(minutes: 45 - minutes));
    } else {
      now = now.add(Duration(minutes: 60 - minutes));
    }
    return DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }

  TimeOfDay get toTimeOfDay => TimeOfDay(hour: hour, minute: minute);

  bool _isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  static const _daysInMonthArray = [
    0,
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31,
  ];
}

extension TimeOfDayHelper on TimeOfDay {
  bool isBefore(TimeOfDay other) {
    if (hour < other.hour) return true;
    if (hour == other.hour && minute < other.minute) return true;
    return false;
  }
}

extension DateTimeOlderThan on DateTime {
  bool isOlderThan(Duration duration) =>
      DateTime.now().difference(this) > duration;

  bool isOlderThanDays(int days) => isOlderThan(Duration(hours: days * 24));
}

extension DateTimeMillisecondsSinceEpochOlderThan on int {
  bool isTimeOlderThan(Duration duration) =>
      DateTime.fromMillisecondsSinceEpoch(this).isOlderThan(duration);

  bool isTimeOlderThanDays(int days) =>
      isTimeOlderThan(Duration(hours: days * 24));
}

extension DateTimeTimeZoneOffset on DateTime {
  /// Returns a +hh:mm or -hh:mm formatted string of the time zone offset.
  String get timeZoneOffsetText {
    final offset = timeZoneOffset;
    final hours = offset.inHours.abs().toString().padLeft(2, '0');
    final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    return '${offset.isNegative ? '-' : '+'}$hours:$minutes';
  }
}
