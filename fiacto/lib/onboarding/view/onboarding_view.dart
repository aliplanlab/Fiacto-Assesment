part of 'view.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return _BodyView();
  }
}

class _BodyView extends StatelessWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context) {
    final onboardController = OnboardingModel.onboardingItems;
    final PageController pageController = PageController();
    final cubit = context.read<OnBoardingCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        builder: (context, state) {
          return PageView.builder(
            controller: pageController,
            onPageChanged: (value) => cubit.setPage(value),
            itemCount: onboardController.length,
            itemBuilder: (context, currentIndex) {
              final item = onboardController[currentIndex];
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Image.asset(item.logo, height: 100, width: 100),
                      const SizedBox(height: 40),
                      Image.asset(item.image, height: 200, fit: BoxFit.contain),
                      const SizedBox(height: 40),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: context.twentyFour600,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        textAlign: TextAlign.center,
                        style: context.sixteen400.withColor(context.grey500),
                      ),
                      const SizedBox(height: 40),
                      const BuildDots(),
                      const Spacer(),
                      NavigationButtons(
                        pageController: pageController,
                        currentIndex: currentIndex,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BuildDots extends StatelessWidget {
  const BuildDots({super.key});
  @override
  Widget build(BuildContext context) {
    final currentIndex = context.select(
      (OnBoardingCubit cubit) => cubit.state.index,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:
                currentIndex == index ? context.primary500 : context.primary100,
          ),
          height: 6,
          width: 24,
          duration: const Duration(milliseconds: 700),
        ),
      ),
    );
  }
}

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({
    super.key,
    required this.pageController,
    required this.currentIndex,
  });

  final PageController pageController;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    final onboardingItems = OnboardingModel.onboardingItems;

    return Column(
      children: [
        CustomElevatedButton.expanded(
          onPressed: () {
            if (currentIndex == onboardingItems.length - 1){
               context.read<AuthRepository>().updateOnboarding(true);
            }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
          },
          text: 'Login',
        ),
        SizedBox(height: 12),
        RichTextWidget(
          title: "New To Fiacto? ",
          colorTitle: 'Sign Up',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SignUpPage()),
            );
          },
          titleStyle: context.fourteen500.withColor(context.grey500),
          colorTitleStyle: context.fourteen500.withColor(context.primary500),
        ),
      ],
    );
  }
}
