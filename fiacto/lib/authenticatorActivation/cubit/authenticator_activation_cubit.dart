import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'authenticator_activation_state.dart';

class AuthenticatorActivationCubit extends Cubit<AuthenticatorActivationState> {
  AuthenticatorActivationCubit() : super(AuthenticatorActivationState());

  void isValidated() {
    emit(state.copyWith(status: FormzStatus.valid));
  }
}
