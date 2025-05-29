import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:fiacto/app/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (AppEnvironment.current.isDev) {
      log('Bloc Change: $change');
      log('Current State: ${change.currentState}');
      log('Next State: ${change.nextState}');
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    bloc.$debugPrint('($error, $stackTrace)', tag: 'onError');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> initializeApp(Callback<FutureOr<void>> config) async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // await Future.delayed(const Duration(seconds: 3));

  await CacheStorage.initialize();
  CachedBloc.initialize();

  await AssetImages.preloadLogoBackground();
  await config();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Bloc.observer = AppBlocObserver();

  // $debugLog('deviceToken: $deviceToken');

  await config();

  // FlutterNativeSplash.remove();

  runApp(App());
}
