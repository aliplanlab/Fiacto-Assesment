part of 'theme.dart';

extension TextThemeContext on BuildContext {
  TextStyle get basicStyle => const TextStyle(color: Color(0xFF091409));

  TextStyle get sixteen500 => basicStyle.withCustomFont(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );
  TextStyle get sixteen600 => basicStyle.withCustomFont(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  TextStyle? get thiryTwo700 => basicStyle.withCustomFont(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      );

  TextStyle? get twentyFour700 => basicStyle.withCustomFont(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );

  TextStyle? get twentyFour600 => basicStyle.withCustomFont(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      );

  TextStyle? get twenty700 => basicStyle.withCustomFont(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

  TextStyle get twenty600 => basicStyle.withCustomFont(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  TextStyle get sixteen700 => basicStyle.withCustomFont(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

  TextStyle get eighteen700 => basicStyle.withCustomFont(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );
  TextStyle get eighteen600 => basicStyle.withCustomFont(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );

  TextStyle get fourteen700 => basicStyle.withCustomFont(
        fontSize: 14,
        fontWeight: FontWeight.w700,
      );

  TextStyle get sixteen400 => basicStyle.withCustomFont(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  TextStyle get fourteen400 => basicStyle.withCustomFont(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
  TextStyle get fourteen600 => basicStyle.withCustomFont(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  TextStyle get fourteen500 => basicStyle.withCustomFont(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  TextStyle get twelve400 => basicStyle.withCustomFont(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );
  TextStyle get twelve500 => basicStyle.withCustomFont(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );
  TextStyle get twelve600 => basicStyle.withCustomFont(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );
  TextStyle get thirteen600 => basicStyle.withCustomFont(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      );
}

extension TextStyleWithFont on TextStyle {
  TextStyle withCustomFont({
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return copyWith(
      fontFamily: 'Poppins',
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      height: height,
      decoration: decoration,
    );
  }
}
