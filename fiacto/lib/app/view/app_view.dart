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
