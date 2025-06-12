import 'package:bloc/bloc.dart';
import 'package:common/http/data_state.dart';
import 'package:common/http/http_exception.dart';
import 'package:common/validators/general.dart';
import 'package:equatable/equatable.dart';
import 'package:fiacto/accountVerification/repository/two_factor_login_repo.dart';
import 'package:fiacto/auth/auth_cubit/auth_cubit.dart';
import 'package:formz/formz.dart';

part 'twoFactor_login_state.dart';

class TwoFaLoginCubit extends Cubit<TwoFaLoginState> {
  TwoFaLoginCubit({required this.repository, required this.auth})
    : super(TwoFaLoginState());

  final TwoFactorLoginRepo repository;
  final AuthCubit auth;

  void updateAuthenticatorCode(String code) {
    final updatedCode = General.dirty(code);
    emit(
      state.copyWith(otp: updatedCode, status: Formz.validate([updatedCode])),
    );
  }

  Future<void> sendOTP({bool isResend = false}) async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(sendOTPState: state.sendOTPState.toLoading()));

    try {
      await repository.sendOTP(auth.state.userDataState.data?.phoneNo ?? '');

      emit(state.copyWith(sendOTPState: state.sendOTPState.toLoaded()));
    } catch (error) {
      emit(
        state.copyWith(
          sendOTPState: state.sendOTPState.toFailure(error: error),
        ),
      );
    }
  }

  Future<void> verifyAuthenticatorAppCode() async {
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(
        verifyLoginAuthenticatorDataState:
            state.verifyLoginAuthenticatorDataState.toLoading(),
      ),
    );

    try {
      await repository.verifyLoginAuthenticatorCode(
        tokenCode: state.authAppCode.value,
        token: auth.state.userDataState.data?.token ?? '',
      );
      emit(
        state.copyWith(
          verifyLoginAuthenticatorDataState:
              state.verifyLoginAuthenticatorDataState.toLoaded(),
        ),
      );
    } on BadRequestException catch (_) {
      emit(
        state.copyWith(
          verifyLoginAuthenticatorDataState: state
              .verifyLoginAuthenticatorDataState
              .toFailure(error: 'Invalid Code'),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          verifyLoginAuthenticatorDataState: state
              .verifyLoginAuthenticatorDataState
              .toFailure(error: error),
        ),
      );
    }
  }

  Future<void> verifyPhoneOtp() async {
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
        verifyLoginOtpDataState: state.verifyLoginOtpDataState.toLoading(),
      ),
    );
    try {
      await repository.verifyLoginOtp(
        token: auth.state.userDataState.data?.token ?? 'No Token',
        phoneNumber:
            auth.state.userDataState.data?.phoneNo ?? 'No Phone Number',
        otp: state.otp.value,
      );
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          verifyLoginOtpDataState: state.verifyLoginOtpDataState.toLoaded(),
        ),
      );
    } on BadRequestException catch (_) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          verifyLoginOtpDataState: state.verifyLoginOtpDataState.toFailure(
            error: 'Invalid OTP',
          ),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          verifyLoginOtpDataState: state.verifyLoginOtpDataState.toFailure(
            error: error,
          ),
        ),
      );
    }
  }
}
