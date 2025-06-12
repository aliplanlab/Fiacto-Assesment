import 'package:common/auth/api/entity/entity.dart';
import 'package:common/common.dart';
import 'package:common/http/data_state.dart';
import 'package:common/validators/email.dart';
import 'package:common/validators/password.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

typedef LoginDataState = DataState<UserEntity>;

class LoginState extends Equatable {
  const LoginState({
    this.password = const Password.pure(),
    this.isVisible = false,
    this.email = const Email.pure(),
    this.isCheck = false,
    this.status = FormzStatus.pure,
    this.loginDataState = const LoginDataState(),
  });
  final Password password;
  final bool isVisible;
  final Email email;
  final bool isCheck;
  final FormzStatus status;
  final LoginDataState loginDataState;

  @override
  List<Object?> get props => [
    email,
    password,
    isVisible,
    isCheck,
    status,
    loginDataState,
  ];

  LoginState copyWith({
    Email? email,
    Password? password,
    bool? isVisible,
    bool? isCheck,
    FormzStatus? status,
    LoginDataState? loginDataState,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isVisible: isVisible ?? this.isVisible,
      isCheck: isCheck ?? this.isCheck,
      status: status ?? this.status,
      loginDataState: loginDataState ?? this.loginDataState,
    );
  }

  List<FormzInput<dynamic, dynamic>> get inputs => [email, password];

  bool get isLoginSuccessFull =>
      loginDataState.isLoaded &&
      loginDataState.data != null &&
      loginDataState.data!.token!.notBlank != null;

  UserEntity get user => loginDataState.data ?? UserEntity();
}
