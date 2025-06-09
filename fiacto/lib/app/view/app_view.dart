part of 'view.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.read<AppRouter>();
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: context.white),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      builder:
          (context, child) => MediaQuery(
            data: context.mediaQuery.copyWith(textScaler: TextScaler.noScaling),
            child: child!,
          ),
    );
  }
}

class AuthProvider extends SingleChildStatelessWidget {
  const AuthProvider({super.key, this.fcmToken});
  final String? fcmToken;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BlocProvider(
      create:
          (context) => AuthCubit(
            twoFactorSignRepository: TwoFactorSignRepositoryImp(
              httpClient: context.read<HttpClient>(),
            ),
            authRepository: context.read<AuthRepository>(),
          )..init(
            userId: context.read<AuthRepository>().currentUser.id.notBlank,
            userToken:
                context.read<AuthRepository>().currentUser.token.notBlank,
            fcmToken: fcmToken,
          ),
      child: child,
    );
  }
}
