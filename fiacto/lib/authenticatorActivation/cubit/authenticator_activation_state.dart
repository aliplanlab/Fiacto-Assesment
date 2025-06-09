// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authenticator_activation_cubit.dart';

typedef AuthenticatorDataSate = DataState<AuthenticatorModel>;
typedef AuthenticatorActivationDataState = DataState<QrModel>;
typedef BuilderUpdateDataSate = DataState<void>;

class AuthenticatorActivationState extends Equatable {
  final General code;
  final FormzStatus status;
  final AuthenticatorActivationDataState activationDataState;
  final AuthenticatorDataSate qrImageState;
  final AuthenticatorDataSate secretKeyState;
  final BuilderUpdateDataSate builderUpdateDataState;

  const AuthenticatorActivationState({
    this.code = const General.pure(),
    this.status = FormzStatus.pure,
    this.activationDataState = const DataState(),
    this.qrImageState = const DataState(),
    this.secretKeyState = const DataState(),
    this.builderUpdateDataState = const DataState(),
  });

  @override
  List<Object?> get props => [
    code,
    status,
    activationDataState,
    qrImageState,
    secretKeyState,
    builderUpdateDataState,
  ];

  AuthenticatorActivationState copyWith({
    General? code,
    FormzStatus? status,
    AuthenticatorActivationDataState? activationDataState,
    AuthenticatorDataSate? qrImageState,
    AuthenticatorDataSate? secretKeyState,
    BuilderUpdateDataSate? builderUpdateDataState,
  }) {
    return AuthenticatorActivationState(
      code: code ?? this.code,
      status: status ?? this.status,
      qrImageState: qrImageState ?? this.qrImageState,
      secretKeyState: secretKeyState ?? this.secretKeyState,
      activationDataState: activationDataState ?? this.activationDataState,
      builderUpdateDataState:
          builderUpdateDataState ?? this.builderUpdateDataState,
    );
  }
}
