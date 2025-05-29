import 'package:common/validators/email.dart';
import 'package:common/validators/general.dart';
import 'package:common/validators/phone_number.dart';
import 'package:fiacto/signup/cubit/signup_state.dart';
import 'package:fiacto/signup/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.repository}) : super(const SignUpState());

  final SignUpRepository repository;

  void isVisible(bool? newVisible) {
    emit(state.copyWith(passwordVisible: newVisible));
  }

  void confirmPasswordVisible(bool? newVisible) {
    emit(state.copyWith(confirmPasswordVisible: newVisible));
  }

  void fullNameChanged(String fullName) {
    final updatedFullName = General.dirty(fullName);
    emit(
      state.copyWith(
        fullName: updatedFullName,
        status: Formz.validate([
          updatedFullName,
          state.email,
          state.password,
          state.confirmPassword,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void emailChanges(String email) {
    final updatedEmail = Email.dirty(email);
    emit(
      state.copyWith(
        email: updatedEmail,
        status: Formz.validate([
          updatedEmail,
          state.fullName,
          state.password,
          state.confirmPassword,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void phoneNumber(String phoneNumber) {
    final updatedPhone = PhoneNumber.dirty(phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: updatedPhone,
        status: Formz.validate([
          updatedPhone,
          state.email,
          state.fullName,
          state.password,
          state.confirmPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String pass) {
    final updatedPass = General.dirty(pass);
    emit(
      state.copyWith(
        password: updatedPass,
        status: Formz.validate([
          updatedPass,
          state.email,
          state.fullName,
          state.confirmPassword,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void confirmPasswordChanged(String pass) {
    final updatedConfirmPass = General.dirty(pass);
    emit(
      state.copyWith(
        confirmPassword: updatedConfirmPass,
        status: Formz.validate([
          updatedConfirmPass,
          state.email,
          state.fullName,
          state.password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  Future<void> signUpWithEmail() async {
    if (!state.status.isValidated) return;

    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
        signUpDataState: state.signUpDataState.toLoading(),
      ),
    );
    try {
      final data = await repository.signUpWithEmailPassword(
        companyName: 'Builders Hub',
        email: state.email.value,
        password: state.password.value,
      );

      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          signUpDataState: state.signUpDataState.toLoaded(data: data),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          signUpDataState: state.signUpDataState.toFailure(error: error),
        ),
      );
    }
  }
}
