import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:common/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' hide launch;

export 'date_format.dart';
export 'date_time.dart';
export 'debouncer.dart';

void $debugLog(dynamic object, {String? tag, StackTrace? stackTrace}) {
  log(object.toString(), name: tag ?? 'debug.log', stackTrace: stackTrace);
}

extension DebugPrint on Object {
  void $debugPrint(dynamic object, {String? tag, StackTrace? stackTrace}) {
    $debugLog(
      object,
      tag: '${tag ?? runtimeType}',
      stackTrace: stackTrace,
    );
  }

  void $debugSelf({String? tag, StackTrace? stackTrace}) {
    $debugLog(
      this,
      tag: '${tag ?? runtimeType}',
      stackTrace: stackTrace,
    );
  }
}

/// Returns [T] if instance of [T], otherwise null
T? $cast<T>(dynamic value) => value == null
    ? null
    : value is T
        ? value
        : null;

/// Parse [value] to [int] if possible, otherwise null
int? $castInt(dynamic value) =>
    value == null ? null : int.tryParse(value.toString());

/// Parse [value] to [int] if possible, otherwise null
double? $castDouble(dynamic value) =>
    value == null ? null : double.tryParse(value.toString());

/// [apply] mapping with [T] as parameter and [R] as return value
R? $mapTo<T, R>(T? object, R? Function(T it) apply) =>
    object != null ? apply(object) : null;

/// [apply] mapping with dynamic parameter and [R] as return value
R? $mapIt<R>(Object? object, R? Function(dynamic it) apply) =>
    object != null ? apply(object) : null;

List<T>? $mapList<T>(dynamic list, T Function(dynamic e) apply) =>
    (list as List?)?.map<T>(apply).toList();

List<R>? $mapToList<T, R>(List<T>? list, R Function(T it) apply) =>
    list?.map<R>(apply).toList();

/// Signature for function that return updated value [T] from the
/// [previous] value of same type passed.
typedef UpdateFromPrevious<T> = T Function(T previous);

typedef MapObject = Map<dynamic, dynamic>;
typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

extension StringToJson on String {
  JsonObject? toJsonObject() {
    final dynamic value = json.decode(this);
    return value is JsonObject ? value : null;
  }

  List<dynamic>? toJsonArray() {
    final dynamic value = json.decode(this);
    return value is List<dynamic> ? value : null;
  }
}

extension JsonToString on Map<String, dynamic> {
  String toJsonString() => json.encode(this);
}

extension JsonArrayToString on List<dynamic> {
  String toJsonString() => json.encode(this);
}

extension IterableExtension<T> on Iterable<T> {
  /// The elements that do not satisfy [test].
  Iterable<T> whereNot(bool Function(T element) test) =>
      where((element) => !test(element));
}

extension FocusContext on BuildContext {
  /// Dismiss keyboard
  void unfocus() {
    FocusScope.of(this).requestFocus(FocusNode());
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

extension StringExtensions on String {
  String toSnakeCase() {
    final String lowercased = toLowerCase();
    return lowercased.replaceAll(' ', '_');
  }

  String toNormalCase() {
    return split('_')
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
              : '',
        )
        .join(' ');
  }

  String toTitleCaseFromSnakeCase() {
    return split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

extension StringNotEmpty on String {
  String? get notEmpty => isEmpty ? null : this;

  String? get notBlank => isBlank ? null : this;

  bool get isBlank => trim().isEmpty;

  bool get isNotBlank => !isBlank;

  String dropLast([int count = 1]) =>
      isBlank ? this : substring(0, length - count);
}

extension StringCapitalize on String {
  String capitalize() {
    final string = trim();
    if (string.isEmpty) return '';
    return '${this[0].toUpperCase()}'
        '${string.length < 2 ? '' : string.substring(1).toLowerCase()}';
  }

  String get capitalizeWords {
    final string = trim();
    if (string.isEmpty) return '';

    return string.split(RegExp(r'\s+')).map((e) => e.capitalize()).join(' ');
  }

  String get initials {
    final string = trim();
    if (string.isEmpty) return '';
    return string.contains(RegExp(r'\s+'))
        ? string
            .split(RegExp(r'\s+'))
            .map((e) => e.trim()[0])
            .join()
            .toUpperCase()
        : string[0].toUpperCase();
  }

  String formatToThreeDigits() {
    final double? parsedValue = double.tryParse(this);
    if (parsedValue == null) {
      return '0';
    }
    final formatter = NumberFormat('#,##0');
    return formatter.format(parsedValue);
  }

  String formatPriceThreeDigits() {
    final double? parsedValue = double.tryParse(this);
    if (parsedValue == null) {
      return '\$0';
    }
    final formatter = NumberFormat('#,##0');
    return '\$${formatter.format(parsedValue)}';
  }

  String takeInitials(int max) => initials.characters.take(max).string;

  int? toIntOrNull() => int.tryParse(this);

  /// add ellipsis to the end of the string if it exceeds [max] length
  String overflow(int max) => length > max ? '${substring(0, max)}…' : this;
}

typedef OnValue<T> = void Function(T value);

typedef OnValue2<V1, V2> = void Function(V1 v1, V2 v2);

typedef OnString = OnValue<String>;

typedef Callback<T> = T Function();

typedef StringCallback = Callback<String>;

typedef BoolCallback = Callback<bool>;

typedef FutureCallback<T> = Callback<Future<T>>;

typedef FutureOrCallback<T> = Callback<FutureOr<T>>;

typedef OnValueCallback<R, T> = R Function(T value);

typedef OnStringCallback<R> = OnValueCallback<R, String>;

typedef OnValueReturn<T> = T Function(T value);

typedef OnStringReturn = OnValueReturn<String>;

extension FirebaseToken on FirebaseMessaging {

  Future<String> getTokenOrEmpty() async {
    try {
      await getAPNSToken();
      return (await getToken()) ?? '';
    } catch (e) {
      $debugPrint(e, tag: 'getToken');
      return '';
    }
  }
}

extension SnackbarContext on BuildContext {
  ScaffoldMessengerState successSnackbar(String text) =>
      ScaffoldMessenger.of(this)
        ..hideCurrentSnackBar()
        ..showSnackBar(Snackbars.success(this, text: text));

  ScaffoldMessengerState errorSnackbar(String? text) =>
      ScaffoldMessenger.of(this)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Snackbars.error(
            this,
            text: text ?? 'Something went wrong',
          ),
        );

  ScaffoldMessengerState infoSnackbar(String text) => ScaffoldMessenger.of(this)
    ..hideCurrentSnackBar()
    ..showSnackBar(Snackbars.info(this, text: text));
}

extension RouteArguments on BuildContext {
  JsonObject get routeArguments =>
      $cast<JsonObject>(ModalRoute.of(this)?.settings.arguments) ?? {};

  T? getRouteArgument<T>(String key) => $cast<T>(routeArguments[key]);

  String get routePath => GoRouter.of(this)
      .routerDelegate
      .currentConfiguration
      .uri
      .pathSegments
      .join('/');
}

extension GoRouteeStateMatch on GoRouterState {
  bool matches(String path) => fullPath?.startsWith(path) ?? false;
}

extension LaunchUrlNullableString on String? {
  Future<void> launchURL({
    BuildContext? context,
    String error = 'Something went wrong while opening the url.',
    LaunchMode mode = LaunchMode.externalApplication,
    bool httpOnly = false,
    VoidCallback? onError,
  }) async {
    $debugLog(this);
    final vUrl = this;
    if (vUrl == null) {
      if (context != null) context.errorSnackbar(error);
      return;
    }
    final url = !httpOnly || vUrl.startsWith(RegExp('^(http|https)://'))
        ? vUrl
        : 'http://$vUrl';
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      try {
        await launchUrl(uri, mode: mode);
      } catch (e) {
        $debugLog(e, tag: this);
        if (context?.mounted == true) context?.errorSnackbar(error);

        onError?.call();
      }
    } else {
      $debugLog(error, tag: this);
      if (context?.mounted == true) context?.errorSnackbar(error);

      onError?.call();
    }
  }

  Future<void> launchInBrowser(BuildContext context) => launchURL(
        context: context,
        mode: LaunchMode.inAppBrowserView,
        httpOnly: true,
      );
}

extension LaunchUrlString on String {
  Future<void> launchMailto([BuildContext? context]) =>
      'mailto:$this'.launchURL(
        context: context,
        error: 'No mailing app installed.',
      );

  Future<void> launchTel([BuildContext? context]) => 'tel:$this'.launchURL(
        context: context,
        error: 'Unable to make a call.',
      );
}

extension IterableTakeSkip<T> on Iterable<T> {
  Iterable<T> skipLast([int count = 1]) => take(
        count < 0
            ? length
            : count <= length
                ? length - count
                : length,
      );

  Iterable<T> takeLast([int count = 1]) => skip(
        count < 0
            ? length
            : count <= length
                ? length - count
                : 0,
      );
}

extension ListRemoved<T> on List<T> {
  List<T> removed(Object? value) {
    final list = List<T>.from(this);
    list.remove(value);
    return list;
  }
}

extension MapWithoutBlanks<K> on Map<K, dynamic> {
  Map<K, dynamic> get nonBlankStringValues => isEmpty
      ? {}
      : Map.fromEntries(
          entries.expand(
            (e) => e.value != null && e.value.toString().isNotBlank
                ? [
                    MapEntry(
                      e.key,
                      e.value is Iterable ? e.value : e.value.toString(),
                    ),
                  ]
                : [],
          ),
        );

  Map<K, dynamic> get nonBlankValues => isEmpty
      ? {}
      : Map.fromEntries(
          entries
              .expand((e) => e.value?.toString().notBlank != null ? [e] : []),
        );

  Map<K, dynamic> get nonNullValues => isEmpty
      ? {}
      : Map.fromEntries(
          entries.expand((e) => e.value != null ? [e] : []),
        );
}

extension ListWithoutBlanks<T> on List<T> {
  List<V> withoutBlanks<V>() => isEmpty
      ? []
      : expand((e) => e != null && e.toString().isNotBlank ? [e as V] : <V>[])
          .toList();
}

extension MediaQueryContext on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => mediaQuery.size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;
}

extension NumMultiply on double {
  double by(double percent) => this * (percent / 100);

  double get half => by(50);

  double get fourty => by(40);

  double get third => by(33.33);

  double get quarter => by(25);

  double get fifth => by(20);
}

extension JWTDecoder on String {
  JsonObject decodeJwt() {
    final splitToken = split('.'); // Split the token by '.'
    if (splitToken.length != 3) {
      throw const FormatException('Invalid token');
    }
    try {
      final payloadBase64 = splitToken[1]; // Payload is always the index 1
      // Base64 should be multiple of 4. Normalize the payload before decode it
      final normalizedPayload = base64.normalize(payloadBase64);
      // Decode payload, the result is a String
      final payloadString = utf8.decode(base64.decode(normalizedPayload));
      // Parse the String to a Map<String, dynamic>
      final decodedPayload = jsonDecode(payloadString) as JsonObject;

      // Return the decoded payload
      return decodedPayload;
    } catch (error) {
      throw const FormatException('Invalid payload');
    }
  }
}

class RouteUri {
  const RouteUri._();

  static String path(
    String path, {
    List<dynamic> routes = const [],
    JsonObject? query,
    bool? refresh,
  }) {
    final List<String> vRoutes = routes.withoutBlanks();
    final queryParameters = {
      'refresh': refresh,
      ...?query,
    }.nonBlankStringValues;
    final uri = Uri(
      pathSegments: [...path.split('/'), ...vRoutes],
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
    return '/$uri';
  }

  static String tab(
    String path, {
    List<dynamic> routes = const [],
    JsonObject? query,
    bool? refresh,
  }) =>
      RouteUri.path(
        'tab/$path',
        routes: routes,
        query: query,
        refresh: refresh,
      );
}
