// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

extension FormatDateTime on DateTime {
  /// Formats the time as `hh:mma`.
  String get formatHHma => CustomDateFormat.HHma.format(this).toLowerCase();

  /// Formats the date as `yyyy-MM-dd`.
  String get formatyyyyMMdd => CustomDateFormat.yyyyMMdd.format(this);

  /// Formats the date as `MM/dd/yyyy`.
  String get formatMMddyyyy => CustomDateFormat.MMddyyyy.format(this);

  /// Formats the date as `MM/dd`.
  String get formatMMdd => CustomDateFormat.MMdd.format(this);

  /// Formats the date as `dd-MM-yyyy`.
  String get formatddMMyyyyHiphen =>
      CustomDateFormat.ddMMyyyyHiphen.format(this);

  /// Formats the date as `dd/MM/yyyy`.
  String get formatddMMyyyy => CustomDateFormat.ddMMyyyy.format(this);

  /// Formats the date as `MMMM d, yyyy`.
  String get formatMMMMdyyyy => CustomDateFormat.MMMMdyyyy.format(this);

  /// Formats the date as `MMMM d, yyyy, hh:mma`.
  String get formatMMMMdyyyyHHma => '$formatMMMMdyyyy, $formatHHma';

  /// Formats the date as `MMM d, yyyy`.
  String get formatMMMdyyyy => CustomDateFormat.MMMdyyyy.format(this);

  /// Formats the date as `MMM d, yyyy, hh:mma`.
  String get formatMMMdyyyyHHma => '$formatMMMdyyyy, $formatHHma';

  /// Formats the date as `EEE, MMM d, yyyy`.
  String get formatEEEMMMdyyyy => CustomDateFormat.EEEMMMdyyyy.format(this);

  /// Formats the date as `EEE, MMM d, yyyy, hh:mma`.
  String get formatEEEMMMdyyyyHHma => '$formatEEEMMMdyyyy, $formatHHma';

  /// Formats the date as `EEEE, MMMM d, yyyy`.
  String get formatEEEEMMMMdyyyy => CustomDateFormat.EEEEMMMMdyyyy.format(this);

  /// Formats the date as `EEEE, MMMM d, yyyy, hh:mma`.
  String get formatEEEEMMMMdyyyyHHma => '$formatEEEEMMMMdyyyy, $formatHHma';

  /// Formats the date as `EEE`.
  String get formatEEE => CustomDateFormat.EEE.format(this);

  /// Formats the date as `MMMM, yyyy`.
  String get formatMMMMyyyy => CustomDateFormat.MMMMyyyy.format(this);

  /// Formats the date as `MMM, yyyy`.
  String get formatMMMyyyy => CustomDateFormat.MMMyyyy.format(this);

  /// Formats the date as `MMM`.
  String get formatMMM => CustomDateFormat.MMM.format(this);

  /// Formats the date as `EEEE, MMMM d`.
  String get formatEEEEMMMMd => CustomDateFormat.EEEEMMMMd.format(this);

  String get formatISO8601UTC =>
      '${toUtc().toIso8601String().replaceAll('Z', '')}Z';
}

extension ParseDateTime on String {
  /// Parse the date in `MM/dd/yyyy` format.
  DateTime get parseMMddyyyy => CustomDateFormat.MMddyyyy.parse(this);

  /// Parse the date in 'yyyy-MM-dd' format.
  DateTime get parseyyyyMMdd => CustomDateFormat.yyyyMMdd.parse(this);

  /// Parse the date in `dd-MM-yyyy` format.
  DateTime get parseddMMyyyyHiphen =>
      CustomDateFormat.ddMMyyyyHiphen.parse(this);

  /// Parse the date in `MM/dd/yyyy HH:mm:ss` format.
  DateTime get parseMMddyyyyHms => CustomDateFormat.MMddyyyyHms.parse(this);

  /// Parse the time in `hh:mm` format.
  DateTime get parseHm => CustomDateFormat.Hm.parse(this);

  /// Parse the time in `HH:mm:ss` format.
  DateTime get parseHms => CustomDateFormat.Hms.parse(this);

  /// Parse with [DateTime.tryParse]
  DateTime? get parseDateTime => DateTime.tryParse(this);
}

class CustomDateFormat {
  CustomDateFormat._();

  /// Formats the time as `HH:mm:ss`.
  static DateFormat get Hms => DateFormat.Hms();

  /// Formats the time as `hh:mma`.
  static DateFormat get HHma => DateFormat('hh:mma');

  /// Formats the time as `hh:mm`.
  static DateFormat get Hm => DateFormat.Hm();

  /// Formats the date as `MM/dd/yyyy HH:mm:ss`.
  static DateFormat get MMddyyyyHms => MMddyyyy.add(Hms);

  /// Formats the date as `yyyy-MM-dd`.
  static DateFormat get yyyyMMdd => DateFormat('yyyy-MM-dd');

  /// Formats the date as `dd-MM-yyyy`.
  static DateFormat get ddMMyyyyHiphen => DateFormat('dd-MM-yyyy');

  /// Formats the date as `MM/dd/yyyy`.
  static DateFormat get MMddyyyy => DateFormat('MM/dd/yyyy');

  /// Formats the date as `MM/dd`.
  static DateFormat get MMdd => DateFormat('MM/dd');

  /// Formats the date as `dd/MM/yyyy`.
  static DateFormat get ddMMyyyy => DateFormat('dd/MM/yyyy');

  /// Formats the date as `MMM d, yyyy`.
  static DateFormat get MMMdyyyy => DateFormat('MMM d, yyyy');

  /// Formats the date as `MMMM d, yyyy`.
  static DateFormat get MMMMdyyyy => DateFormat('MMMM d, yyyy');

  /// Formats the date as `EEE, MMM d, yyyy`.
  static DateFormat get EEEMMMdyyyy => DateFormat('EEE, MMM d, yyyy');

  /// Formats the date as `EEEE, MMMM d, yyyy`.
  static DateFormat get EEEEMMMMdyyyy => DateFormat('EEEE, MMMM d, yyyy');

  /// Formats the date as `EEE`.
  static DateFormat get EEE => DateFormat('EEE');

  /// Formats the date as `MMMM, yyyy`.
  static DateFormat get MMMMyyyy => DateFormat('MMMM, yyyy');

  /// Formats the date as `MMM, yyyy`.
  static DateFormat get MMMyyyy => DateFormat('MMM, yyyy');

  /// Formats the date as `MMM`.
  static DateFormat get MMM => DateFormat('MMM');

  /// Formats the date as `EEEE, MMMM d`.
  static DateFormat get EEEEMMMMd => DateFormat.MMMMEEEEd();
}

extension AddInDateFormat on DateFormat {
  /// Add [format] to this stance as a pattern.
  ///
  /// If there was a previous pattern, then this appends to it, separating the
  /// two by [separator].  [format] is first looked up  our list of
  /// known skeletons.  If it's found there, then use the corresponding pattern
  /// for this locale.  If it's not, then treat [format] as an explicit
  /// pattern.
  DateFormat add(DateFormat format, [String separator = ' ']) =>
      addPattern(format.pattern, separator);
}

extension DateTimeFormatAgo on DateTime {
  /// Calculate the time difference from [DateTime.now] and format it.
  String get formatTimeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 0) {
      final count = difference.inDays;
      return '$count day${_plural(count)} ago';
    } else if (difference.inHours > 0) {
      final count = difference.inHours;
      return '$count hour${_plural(count)} ago';
    } else if (difference.inMinutes > 0) {
      final count = difference.inMinutes;
      return '$count minute${_plural(count)} ago';
    } else if (difference.inSeconds > 0) {
      final count = difference.inSeconds;
      return '$count second${_plural(count)} ago';
    } else {
      return 'Just now';
    }
  }

  String _plural(int count) => count > 1 ? 's' : '';
}
