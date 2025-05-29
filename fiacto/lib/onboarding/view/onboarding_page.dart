part of 'view.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  static String route() => '/onboarding';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: const OnBoardingView(),
    );
  }
}
