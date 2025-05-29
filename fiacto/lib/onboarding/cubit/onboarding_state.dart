part of 'onboarding_cubit.dart';

class OnBoardingState {
  final int index;
  OnBoardingState({this.index = 0});

  OnBoardingState copyWith({required int currentIndex}) {
    return OnBoardingState(index: currentIndex);
  }
}
