class OnboardingModel {
  final String title;
  final String description;
  final String logo;
  final String image;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.logo,
    required this.image,
  });

  static List<OnboardingModel> onboardingItems = [
    OnboardingModel(
      title: 'Discover Fiacto: Your Ultimate Crypto Wallet Solution',
      description: 'Buy, store, and convert crypto securely allin one place.',
      logo: 'assets/images/logo.png',
      image: 'assets/images/onboarding_img1.png',
    ),
    OnboardingModel(
      title: 'Instantly Convert Crypto to Fiat with Ease',
      description:
          'Withdraw your crypto in local currency anytime. Fast, easy, secure.',
      logo: 'assets/images/logo.png',
      image: 'assets/images/Group.png',
    ),
    OnboardingModel(
      title: 'Secure and KYC-Verified for Your Peace of Mind',
      description:
          "Your identity is safe with advanced encryption and compliant KYC verification.",
      logo: 'assets/images/logo.png',
      image: 'assets/images/Face_Recognition.png',
    ),
  ];
}
