// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authenticator_activation_cubit.dart';

class AuthenticatorActivationState extends Equatable {
  final FormzStatus status;

  const AuthenticatorActivationState({this.status = FormzStatus.pure});
  @override
  // TODO: implement props
  List<Object?> get props => [status];

  AuthenticatorActivationState copyWith({FormzStatus? status}) {
    return AuthenticatorActivationState(status: status ?? this.status);
  }
}
