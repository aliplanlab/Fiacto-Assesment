import 'package:common/common.dart';

enum AppEnvironment {
  prod(
    config: HttpClientConfig(
      baseUrl: 'https://sbx-api.realwealtdy.net/',
    ),
  ),
  dev(
    config: HttpClientConfig(
      baseUrl: 'https://sbx-api.realwealtdy.net/',
      enableLogs: true,
    ),
  );

  const AppEnvironment({
    required this.config,
  });

  final HttpClientConfig config;

  bool get isProd => this == AppEnvironment.prod;
  bool get isDev => this == AppEnvironment.dev;

  static AppEnvironment _current = AppEnvironment.dev;
  static AppEnvironment get current => _current;
  static set current(AppEnvironment env) => _current = env;
}
