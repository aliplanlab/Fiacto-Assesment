import 'dart:math';

import 'package:common/common.dart';
import 'package:flutter/material.dart';

part 'colors.dart';
part 'text_styles.dart';

const kDefaultToolbarHeight = 71.0;

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  TargetPlatform get platform => theme.platform;

  bool get isDarkMode =>
      theme.brightness == Brightness.dark ||
      mediaQuery.platformBrightness == Brightness.dark;

  bool get isIOS => platform == TargetPlatform.iOS;

  bool get isAndroid => platform == TargetPlatform.android;
}

extension BrightnessX on Brightness {
  Brightness get inverse =>
      this == Brightness.dark ? Brightness.light : Brightness.dark;
}
