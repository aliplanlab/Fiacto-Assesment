import 'package:bloc/bloc.dart';

part 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingState());

  void setPage(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
