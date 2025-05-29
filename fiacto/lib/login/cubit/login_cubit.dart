import 'package:common/http/http_exception.dart';
import 'package:common/validators/email.dart';
import 'package:common/validators/password.dart';
import 'package:fiacto/login/cubit/login_state.dart';
import 'package:fiacto/login/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginRepository}) : super(const LoginState());

  final LoginRepository loginRepository;

  void isVisible(bool? newVisible) {
    emit(state.copyWith(isVisible: newVisible));
  }

  void email(String value) {
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void password(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  void isCheck(bool? newCheck) {
    emit(state.copyWith(isCheck: newCheck));
  }

  Future<void> loginWithEmailPassword() async {
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
        loginDataState: state.loginDataState.toLoading(),
      ),
    );
    try {
      final data = await loginRepository.loginWithEmailPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          loginDataState: state.loginDataState.toLoaded(data: data),
        ),
      );
    } on NoDataException catch (_) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          loginDataState: state.loginDataState.toFailure(
            error: 'User not found',
          ),
        ),
      );
    } on UnauthorisedException catch (_) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          loginDataState: state.loginDataState.toFailure(
            error: 'Invalid credentials',
          ),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          loginDataState: state.loginDataState.toFailure(error: error),
        ),
      );
    }
  }
}
