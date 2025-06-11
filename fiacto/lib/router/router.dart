import 'dart:async';

import 'package:common/common.dart';
import 'package:fiacto/2FA/view/view.dart';
import 'package:fiacto/app/bloc/app_bloc.dart';
import 'package:fiacto/authenticatorActivation/view/authenticator_activation_page.dart';
import 'package:fiacto/login/view/view.dart';
import 'package:fiacto/onboarding/view/view.dart';
import 'package:fiacto/router/routes_name.dart';
import 'package:fiacto/signup/view/view.dart';
import 'package:fiacto/smsActivation/view/sms_activation_page.dart';
import 'package:fiacto/splash/view/view.dart';
import 'package:fiacto/tab/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.dart';

class AppRouter {
  AppRouter({
    AppBloc? appBloc,
    String? intiialRoute,
    List<RouteBase>? routes,
    GlobalKey<NavigatorState>? navigatorKey,
    List<NavigatorObserver>? observers,
  }) : router = GoRouter(
         navigatorKey: navigatorKey,
         initialLocation: intiialRoute ?? AppRoutes.initial,
         routes: routes ?? AppRoutes.list(),
         debugLogDiagnostics: true,
         observers: [...?observers],
         refreshListenable:
             appBloc != null ? AppRouterRefreshStream([appBloc.stream]) : null,
         redirect:
             appBloc != null
                 ? (context, state) async {
                   //  $debugLog(state.name, tag: 'Name');
                   //  $debugLog(state.path, tag: 'Path');
                   //  $debugLog(state.fullPath, tag: 'Full Path');
                   //  $debugLog(state.matchedLocation, tag: 'Matched Location');
                   //  $debugLog(
                   //    state.pathParameters.toString(),
                   //    tag: 'Path Params',
                   //  );
                   //  $debugLog(state.pageKey.toString(), tag: 'Page Key');
                   //  $debugLog(state.extra, tag: 'Extra');
                   //  $debugLog(state.uri, tag: 'route');
                   final appState = appBloc.state;

                   // if the user is not loaded, they must wait
                   final loaded = !appState.isLoading;
                   final loading = state.fullPath == SplashPage.route();
                   if (!loaded) {
                     return loading ? null : SplashPage.route();
                   }

                   //  // if the user is not logged in, they must login
                   final loggedIn = appState.isAuthenticated;
                   final isOnboared = await appBloc.authRepository.onboarding;
                   final loggingIn = state.matches(OnBoardingPage.route());
                   if (!loggedIn) {
                     if (loggingIn) {
                       return null;
                     }
                     if (isOnboared) {
                       final signup = state.matches(SignUpPage.route());
                       return signup ? null : LoginPage.route();
                     }
                     return OnBoardingPage.route();
                   }

                   // // - [loading] if the user is loaded but still on the splash page,
                   // redirect to the home page
                   // - [loggingIn] if the user is logged in but still on the login page,
                   // redirect to the home page
                   // - [onboarding] if the user is onboarded but still on the onboarding
                   // page, redirect to the home page
                   final user = appState.user;

                   //  if (user.isEmailVerified == false) {
                   //    return VerifyEmailAddressPage.route();
                   //  } else

                   if (!(user.isTwoFactorPhoneComplete ||
                       user.isTwoFactorAuthenticatorComplete)) {
                     final goingTo2FPage =
                         state.matches(SmsActivationPage.route()) ||
                         state.matches(AuthenticatorActivationPage.route());

                     if (!goingTo2FPage) {
                       return TwoFAWalletPage.route();
                     }
                   } else if (loading || loggingIn || loggedIn) {
                     if (state.matches('/tab')) {
                       return null;
                     }
                     return TabPage.routeWithFirstTab();
                   }
                   return null;
                 }
                 : null,
       );

  @visibleForTesting
  final GoRouter router;

  RouteInformationProvider get routeInformationProvider =>
      router.routeInformationProvider;

  RouteInformationParser<Object> get routeInformationParser =>
      router.routeInformationParser;

  RouterDelegate<Object> get routerDelegate => router.routerDelegate;
}

class AppRouterRefreshStream extends ChangeNotifier {
  AppRouterRefreshStream(List<Stream<dynamic>> streams) {
    notifyListeners();
    _subscriptions =
        streams
            .map((e) => e.asBroadcastStream().listen((_) => notifyListeners()))
            .toList();
  }

  late final List<StreamSubscription<dynamic>> _subscriptions;

  @override
  void dispose() {
    for (final e in _subscriptions) {
      e.cancel();
    }
    super.dispose();
  }
}
