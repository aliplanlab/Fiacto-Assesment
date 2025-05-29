part of 'view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String route() => '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create:
          (context) => LoginCubit(
            loginRepository: LoginRepositoryImp(
              httpClient: context.read<HttpClient>(),
            ),
          ),
      child: const LoginView(),
    );
  }
}
