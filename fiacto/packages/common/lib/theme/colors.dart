part of 'theme.dart';

const _kLightColor = Color(0xFFFFFFFF); // 0xFFFDFDFF
const _kDarkColor = Color(0xFF000000); // 0xFF232329

abstract class AppColors {
  const AppColors();

  Brightness get brightness;

  Color get primary;
  Color get onPrimary;
  Color get primaryContainer;
  Color get onPrimaryContainer;
  Color get secondary;
  Color get onSecondary;
  Color get secondaryContainer;
  Color get onSecondaryContainer;
  Color get tertiary;
  Color get onTertiary;
  Color get tertiaryContainer;
  Color get onTertiaryContainer;
  Color get error;
  Color get onError;
  Color get errorContainer;
  Color get onErrorContainer;

  Color get success;
  Color get shadow;
  Color get neutral;
  Color get inverseNeutral;

  Color get neutral_0;
  Color get neutral_10;
  Color get neutral_20;
  Color get neutral_30;
  Color get neutral_40;
  Color get neutral_60;
  Color get neutral_80;
  Color get neutral_100;

  ColorScheme get colorScheme => ColorScheme(
        brightness: brightness,
        primary: primary,
        inversePrimary: primaryContainer,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: neutral,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        // background: neutral,
        // onBackground: neutral_80,
        surface: neutral_0,
        surfaceTint: neutral_0,
        onSurface: neutral_80,
        //surfaceVariant: neutral_10,
        onSurfaceVariant: neutral_60,
        inverseSurface: inverseNeutral,
        onInverseSurface: neutral,
        outline: neutral_20,
        outlineVariant: neutral_40,
        shadow: shadow,
        scrim: inverseNeutral.withOpacity(0.8),
      );
}

class LightAppColors extends AppColors {
  const LightAppColors();

  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get primary => const Color(0xFF6A7FDB);

  @override
  Color get onPrimary => neutral;

  @override
  Color get primaryContainer => const Color(0xFFE9F1FF);

  @override
  Color get onPrimaryContainer => neutral_80;

  @override
  Color get secondary => const Color(0xFF316EE4);

  @override
  Color get onSecondary => neutral;

  @override
  Color get secondaryContainer => const Color(0xFFE4D9FF);

  @override
  Color get onSecondaryContainer => neutral_80;

  @override
  Color get tertiary => neutral_80;

  @override
  Color get onTertiary => neutral;

  @override
  Color get tertiaryContainer => neutral_30;

  @override
  Color get onTertiaryContainer => neutral_40;

  @override
  Color get error => const Color(0xFFBA1A1A);

  @override
  Color get onError => neutral;

  @override
  Color get errorContainer => const Color(0xFFFFB4AB);

  @override
  Color get onErrorContainer => neutral_80;

  @override
  Color get success => const Color(0xFF458846);

  @override
  Color get shadow => neutral_20;

  @override
  Color get neutral => const Color(0xFFFFFFFF); // 0xFFFDFDFF

  @override
  Color get inverseNeutral => neutral_100;

  @override
  Color get neutral_0 => const Color(0xFFFFFFFF); // 0xFFF2F4FC

  @override
  Color get neutral_10 => const Color(0xFFE7E8E9);

  @override
  Color get neutral_20 => const Color(0xFFDADADA);

  @override
  Color get neutral_30 => const Color(0xFFC9CACB);

  @override
  Color get neutral_40 => const Color(0xFF888888);

  @override
  Color get neutral_60 => const Color(0xFF5D5D6B);

  @override
  Color get neutral_80 => const Color(0xFF232329);

  @override
  Color get neutral_100 => const Color(0xFF000000);
}

class DarkAppColors extends AppColors {
  const DarkAppColors();

  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get primary => const Color(0xFF6A7FDB);

  @override
  Color get onPrimary => neutral_0;

  @override
  Color get primaryContainer => const Color(0xFF0F186C);

  @override
  Color get onPrimaryContainer => inverseNeutral;

  @override
  Color get secondary => const Color(0xFFE4D9FF);

  @override
  Color get onSecondary => neutral_0;

  @override
  Color get secondaryContainer => const Color(0xFF316EE4);

  @override
  Color get onSecondaryContainer => inverseNeutral;

  @override
  Color get tertiary => neutral_30;

  @override
  Color get onTertiary => neutral_20;

  @override
  Color get tertiaryContainer => neutral_0;

  @override
  Color get onTertiaryContainer => inverseNeutral;

  @override
  Color get error => const Color(0xFFFFB4AB);

  @override
  Color get onError => neutral_0;

  @override
  Color get errorContainer => const Color(0xFFBA1A1A);

  @override
  Color get onErrorContainer => inverseNeutral;

  @override
  Color get success => const Color(0xFF458846);

  @override
  Color get shadow => Colors.black;

  @override
  Color get neutral => const Color(0xFF000000);

  @override
  Color get inverseNeutral => neutral_100;

  @override
  Color get neutral_0 => const Color(0xFF000000); // 0xFF232329

  @override
  Color get neutral_10 => const Color(0xFF5D5D6B);

  @override
  Color get neutral_20 => const Color(0xFF888888);

  @override
  Color get neutral_30 => const Color(0xFFC9CACB);

  @override
  Color get neutral_40 => const Color(0xFFDADADA);

  @override
  Color get neutral_60 => const Color(0xFFE7E8E9);

  @override
  Color get neutral_80 => const Color(0xFFFFFFFF); // 0xFFF2F4FC

  @override
  Color get neutral_100 => const Color(0xFFFFFFFF); // 0xFFFDFDFF
}

//Use this colors
extension AppColorsContext on BuildContext {
  Color get primary500 => const Color(0XFF006D5A);

  Color get primary50 => const Color(0xFFEDF7EE);

  Color get success50 => const Color(0xFFECF6E6);

  Color get primary700 => const Color(0XFF004D40);

  Color get success500 => const Color(0xFF41A300);

  Color get primary100 => const Color(0xFFC8E6C9);

  Color get error500 => const Color(0xFFE00000);

  Color get error50 => const Color(0xFFFCE6E6);

  Color get warning500 => const Color(0xFFF58300);

  Color get warning50 => const Color(0xFFFEF3E6);

  Color get white => const Color(0xFFFFFFFF);

  Color get yellow => const Color(0xFFFBBC04);

  Color get grey900 => const Color(0xFF091409);

  Color get grey300 => const Color(0XFFF8F8F8);

  Color get grey500 => const Color(0XFF767676);

  Color get grey400 => const Color(0XFFD9D9D9);

  Color get grey200 => const Color(0xFFD7D9D7);

  Color get grey100 => const Color(0xFFECEDEC);

  Color get grey50 => const Color(0xFFF5F6F5);

  Color get grey20 => const Color(0xFFE9E9EA);

  Color get pink50 => const Color(0xFFFCE6E6);

  Color get transparent => const Color(0xFFFFFFFF);

  Color get onDark => _kLightColor;

  Color get onLight => _kDarkColor;

  Color get shadow => colorScheme.shadow;

  Color get outline => grey300;

  Color get hint => grey400;

//Color get grey200 => const Color(0xFFD7D9D7);

//Color get grey500 => const Color(0xFF626962);

//Color get success500 => const Color(0xFFECF6E6);
}

extension TextStyleColor on TextStyle {
  TextStyle withColor(Color? color) => withCustomFont(color: color);

  TextStyle error(BuildContext context) => withColor(context.error500);

  TextStyle hint([BuildContext? context]) =>
      withColor(context?.hint ?? color?.hint);

  TextStyle onDark(BuildContext context) => withColor(context.onDark);
}

extension ColorOpacity on Color {
  Color get highlight => withOpacity(0.7);
  Color get hint => withOpacity(0.6);
  Color get pressed => withOpacity(0.3);
  Color get outline => withOpacity(0.4);
}

extension ColorContrast on Color {
  bool get isDark => (299 * red + 587 * green + 114 * blue) / 1000 < 162;

  Color get contrast => isDark ? Colors.white : Colors.black;

  Brightness get brightness => isDark ? Brightness.light : Brightness.dark;

  Color get darker => withBlue(max(blue - 50, 0))
      .withGreen(max(green - 50, 0))
      .withRed(max(red - 50, 0));
}

extension RandomObject on Object {
  /// Returns random integer seeded with [hashCode] and less than [max]
  int random(int max) => Random(hashCode).nextInt(max);
}

extension StringColor on String {
  /// Returns random color seeded with [hashCode] of the string
  Color get color => _Colors.random(this);
}

class _Colors {
  const _Colors._();

  static const charcoal = Color(0xff252525);
  static const livid = Color(0xff395b74);
  static const lividLight = Color(0xff78909c);
  static const lividDark = Color(0xff2d495e);
  static const amber = Color(0xffffca28);
  static const orange = Color(0xffe5680f);
  static const orangeEve = Color(0xffe84d01);
  static const brown = Color(0xff795548);
  static const red = Color(0xffd50000);
  static const redLight = Color(0xffef5350);
  static const redDark = Color(0xffb40000);
  static const cherry = Color(0xffc72349);
  static const cherryDark = Color(0xffaf1e40);
  static const pink = Color(0xffad1457);
  static const pinkLight = Color(0xffec407a);
  static const pinkDark = Color(0xff790e3c);
  static const sky = Color(0xff1E88E5);
  static const skyLight = Color(0xff42a5f5);
  static const blue = Color(0xff1769aa);
  static const blueDark = Color(0xff14578c);
  static const indigoLight = Color(0xff5c6bc0);
  static const indigoDark = Color(0xff2c387e);
  static const purple = Color(0xff9c27b0);
  static const purpleDark = Color(0xff6d1b7b);
  static const purpleEve = Color(0xff723b48);
  static const violet = Color(0xff673ab7);
  static const violetDark = Color(0xff482880);
  static const plum = Color(0xff625b91);
  static const plumDark = Color(0xff514a78);
  static const teal = Color(0xff039694);
  static const tealDark = Color(0xff006974);
  static const green = Color(0xff0F9D58);
  static const greenLight = Color(0xff7cb342);
  static const greenLighter = Color(0xff66bb6a);
  static const greenDark = Color(0xff0d844a);

  static Color random(String seed) => colors[seed.random(colors.length)];

  static const colors = [
    charcoal,
    Colors.lightBlueAccent,
    livid,
    Colors.teal,
    amber,
    pinkDark,
    orange,
    Colors.indigoAccent,
    pinkLight,
    Colors.lightBlue,
    redLight,
    Colors.green,
    cherry,
    Colors.lightGreen,
    purpleEve,
    greenDark,
    Colors.blueAccent,
    violet,
    Colors.blueGrey,
    greenLighter,
    Colors.deepOrangeAccent,
    cherryDark,
    lividDark,
    Colors.blue,
    pink,
    skyLight,
    Colors.greenAccent,
    indigoDark,
    green,
    Colors.pinkAccent,
    plum,
    Colors.orange,
    indigoLight,
    Colors.pink,
    orangeEve,
    Colors.amber,
    sky,
    red,
    Colors.orangeAccent,
    purpleDark,
    greenLight,
    blue,
    Colors.deepPurple,
    redDark,
    Colors.purple,
    plumDark,
    purple,
    teal,
    Colors.indigo,
    violetDark,
    tealDark,
    Colors.purpleAccent,
    blueDark,
    lividLight,
    Colors.deepPurpleAccent,
    brown,
  ];
}
