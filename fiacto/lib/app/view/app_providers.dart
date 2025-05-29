part of 'view.dart';

class AppCoreProviders extends StatelessWidget {
  const AppCoreProviders({super.key, this.fcmToken = ''});

  final String fcmToken;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthApi>(create: (context) => AuthApiImpl()),
        RepositoryProvider<AuthRepository>(
          create:
              (context) => AuthRepositoryImpl(
                api: context.read<AuthApi>(),
                fcmToken: fcmToken,
              ),
        ),
        RepositoryProvider<HttpClient>(
          create:
              (context) => HttpClientImpl(
                authRepository: context.read<AuthRepository>(),
              ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) =>
                    AppBloc(authRepository: context.read<AuthRepository>()),
          ),
        ],
        child: RepositoryProvider(
          create: (context) => AppRouter(appBloc: context.read<AppBloc>()),
          child: const AppFeatureProviders(),
        ),
      ),
    );
  }
}

class AppFeatureProviders extends StatelessWidget {
  const AppFeatureProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // MultiBlocProvider(
    //   providers: const [AuthProvider()],
    // child:
    const AppView();
  }
}
