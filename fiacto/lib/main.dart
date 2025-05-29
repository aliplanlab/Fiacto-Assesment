import 'package:common/constants/app_environment.dart';
import 'package:fiacto/initialize_app.dart';

Future<void> main() async => initializeApp(() {
  AppEnvironment.current = AppEnvironment.dev;
});
