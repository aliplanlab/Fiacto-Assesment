part of 'router.dart';

class AppRoutes {
  AppRoutes._();

  static const initial = '/';
  static const onboarding = '/onboarding';
  // static const forget = '/forget';

  static List<RouteBase> list() => [
    GoRoute(
      name: RouteNames.splash,
      path: SplashPage.route(),
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      name: RouteNames.onboarding,
      path: OnBoardingPage.route(),
      builder: (_, __) => const OnBoardingPage(),
    ),
    GoRoute(
      path: LoginPage.route(),
      name: RouteNames.login,
      builder: (_, __) => const LoginPage(),
    ),
    GoRoute(
      path: SignUpPage.route(),
      name: RouteNames.signup,
      builder: (_, __) => const SignUpPage(),
    ),
    GoRoute(
      path: TwoFAWalletPage.route(),
      name: RouteNames.twoFA,
      builder: (_, __) => const TwoFAWalletPage(),
    ),
    GoRoute(
      path: AuthenticatorActivationPage.route(),
      name: RouteNames.authenticatorActivation,
      builder: (_, __) => const AuthenticatorActivationPage(),
    ),
    GoRoute(
      path: SmsActivationPage.route(),
      name: RouteNames.smsActivation,
      builder: (_, __) => const SmsActivationPage(),
    ),
    GoRoute(
      path: TabPage.path(),
      builder:
          (_, state) =>
              TabPage(key: state.pageKey, page: state.pathParameters['page']!),
    ),
    // GoRoute(
    //   name: RouteNames.homeDetails,
    //   path: '/home/home_details', //Never add / in front of child route path
    //   builder: (context, state) {
    //     //Sending complex object data in form of extra param
    //     final extras = state.extra as JsonObject;
    //     final id = extras['id'] ?? 'Unknown';
    //     final unitId = extras['unitId'] ?? '';
    //     final unitName = extras['unitName'] ?? 'Unkown';
    //     return HomeDetails(id: id, unitId: unitId, unitName: unitName);
    //   },
    // ),

    // StatefulShellRoute.indexedStack(
    //   builder: (context, state, navigationShell) {
    //     // Here you give the navigationShell to your TabView,
    //     // so it can navigate between tabs properly.
    //     return UpdatedTabPage(navigationShell: navigationShell);
    //   },
    //   branches: [
    //     //Bottom tab 1
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           name: RouteNames.home,
    //           path: '/home',
    //           builder: (context, state) {
    //             return const HomePage();
    //           },

    //           //Child routes
    //         ),
    //       ],
    //     ),
    //     //Bottom Tab 2{Inspections}
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: '/inspection',
    //           name: RouteNames.inspection,
    //           builder: (context, state) => const InspectionsPage(),
    //         ),
    //       ],
    //     ),

    //     //Bottom Tab 2{Training}
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: '/training',
    //           name: RouteNames.training,
    //           builder: (context, state) => const TrainingPage(),
    //         ),
    //       ],
    //     ),

    //     //Bottom Tab 2{Evaluation}
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: '/evaluation',
    //           name: RouteNames.evaluation,
    //           builder: (context, state) => const EvaluationPage(),
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
  ];

  // GoRoute(
  //   path: AddPropertyPage.route(),
  //   builder: (_, __) => const AddPropertyPage(),
  // ),
  // GoRoute(
  //   path: HomePage.route(),
  //   builder: (_, __) => const HomePage(),
  // ),

  // GoRoute(
  //   path: VerifyEmailAddressPage.route(),
  //   builder: (_, __) => const VerifyEmailAddressPage(),
  // ),
  // GoRoute(
  //   path: ProfilePage.route(),
  //   builder: (_, __) => const ProfilePage(),
  // ),
  // GoRoute(
  //   path: AccountVerificationPage.route(),
  //   builder: (_, __) => const AccountVerificationPage(),
  // ),
  // GoRoute(
  //   path: MFAOptionsPage.route(),
  //   builder: (context, state) => const MFAOptionsPage(),
  // ),
  // GoRoute(
  //   path: UserAgreementPage.route(),
  //   builder: (_, __) => const UserAgreementPage(),
  // ),
  // GoRoute(
  //   path: CompanyRegistrationPage.route(),
  //   builder: (_, __) => const CompanyRegistrationPage(),
  // ),
  // GoRoute(
  //   path: AdditionalDocumentPage.route(),
  //   builder: (_, __) => const AdditionalDocumentPage(),
  // ),
  // GoRoute(
  //   path: VerificationPage.route(),
  //   builder: (_, __) => const VerificationPage(),
  // ),
  // GoRoute(
  //   path: FocalIdentityVerificationPage.route(),
  //   builder: (_, __) => const FocalIdentityVerificationPage(),
  // ),
  // GoRoute(
  //   path: ForgetPasswordPage.route(),
  //   builder: (_, __) => const ForgetPasswordPage(),
  // ),
  // GoRoute(
  //   path: VerifyEmailAddressPage.route(),
  //   builder: (_, __) => const VerifyEmailAddressPage(),
  // ),
  // GoRoute(
  //   path: ChangeEmailPage.route(),
  //   builder: (_, __) => const ChangeEmailPage(),
  // ),
  // GoRoute(
  //   path: ChangeNumberPage.route(),
  //   builder: (_, __) => const ChangeNumberPage(),
  // ),
  // GoRoute(
  //   path: NotificationPage.route(),
  //   name: NotificationPage.route(),
  //   builder: (_, __) => const NotificationPage(),
  // ),
  // GoRoute(

  //   path: TabPage.path(),
  //   builder: (_, state) => TabPage(
  //     key: state.pageKey,
  //     page: state.pathParameters['page']!,
  //   ),
  // ),
}
