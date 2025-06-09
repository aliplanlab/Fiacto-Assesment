import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:fiacto/auth/two_factor_sign_up/repository/repository.dart';
import 'package:formz/formz.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    // required this.twoFactorLoginRepository,
    required this.twoFactorSignRepository,
    required this.authRepository,
  }) : super(const AuthState()) {
    _userSubscription = authRepository.user.listen((user) {
      if (user.isAuthenticated) {
        init(
          userId: user.id.notBlank,
          userToken: user.token.notBlank,
          fcmToken: '',
        );
      }
    });
  }

  // final TwoFactorLoginRepository twoFactorLoginRepository;
  final TwoFactorSignRepository twoFactorSignRepository;
  final AuthRepository authRepository;
  Timer? _timer;
  late final StreamSubscription<User> _userSubscription;

  void init({
    required String? userId,
    required String? userToken,
    required String? fcmToken,
  }) {
    emit(
      state.copyWith(userId: userId, userToken: userToken, fcmToken: fcmToken),
    );
  }

  // show Loading
  void showLoading() {
    emit(state.copyWith(isLoading: true));
  }

  // void resetForgotPasswordState() {
  //   emit(
  //     state.copyWith(
  //       forgotEmail: Email.pure(),
  //       otpForgotAuthenticatorVerified: General.pure(),
  //       otpForgotEmailVerified: General.pure(),
  //       otpPhoneNumberForgot: General.pure(),
  //       status: FormzStatus.pure,
  //     ),
  //   );
  // }

  // hide Loading
  void hideLoading() {
    emit(state.copyWith(isLoading: false));
  }

  // phone number otp verified for signUp
  void otpPhoneNumberVerified(String value) {
    final signUpOtp = General.dirty(value);
    $debugLog('opt screen $signUpOtp');
    emit(
      state.copyWith(
        otpSignUpPhoneVerified: signUpOtp,
        status: Formz.validate([signUpOtp]),
      ),
    );
  }
  // phone number otp verified for  login

  void otpPhoneNumberVerifiedLogin(String value) {
    final loginOtp = General.dirty(value);
    $debugLog(loginOtp);
    emit(
      state.copyWith(
        otpPhoneNumberVerifiedLogin: loginOtp,
        status: Formz.validate([loginOtp]),
      ),
    );
  }

  void updateUser(UserEntity data) {
    emit(
      state.copyWith(userDataState: state.userDataState.toLoaded(data: data)),
    );
  }

  // this authenticator code for login
  void authenticationCodeLogin(String value) {
    final authAppCode = General.dirty(value);
    emit(
      state.copyWith(
        authAppCode: authAppCode,
        status: Formz.validate([authAppCode]),
      ),
    );
  }

  // this api to get latest user
  Future<void> getUserBuilder() async {
    emit(state.copyWith(getUserDataState: state.getUserDataState.toLoading()));
    try {
      final data = await twoFactorSignRepository.getUser(
        id: state.userId ?? '',
        token: '',
      );

      emit(
        state.copyWith(
          getUserDataState: state.getUserDataState.toLoaded(data: data),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getUserDataState: state.getUserDataState.toFailure(error: e),
        ),
      );
    }
  }
}
