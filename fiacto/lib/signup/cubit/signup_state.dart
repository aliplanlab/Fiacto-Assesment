import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

typedef SignUpDataState = DataState<UserEntity>;

class SignUpState extends Equatable {
  const SignUpState({
    this.fullName = const General.pure(),
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
    this.phoneNumber = const PhoneNumber.pure(),
    this.password = const General.pure(),
    this.confirmPassword = const General.pure(),
    this.passwordVisible = false,
    this.confirmPasswordVisible = false,
    this.signUpDataState = const SignUpDataState(),
  });

  final General fullName;
  final Email email;
  final FormzStatus status;
  final PhoneNumber phoneNumber;
  final General password;
  final General confirmPassword;
  final bool passwordVisible;
  final bool confirmPasswordVisible;
  final SignUpDataState signUpDataState;

  @override
  List<Object?> get props => [
    fullName,
    email,
    status,
    phoneNumber,
    password,
    confirmPassword,
    passwordVisible,
    confirmPasswordVisible,
    signUpDataState,
  ];

  SignUpState copyWith({
    General? fullName,
    Email? email,
    FormzStatus? status,
    PhoneNumber? phoneNumber,
    General? password,
    General? confirmPassword,
    bool? passwordVisible,
    bool? confirmPasswordVisible,
    SignUpDataState? signUpDataState,
  }) {
    return SignUpState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
      signUpDataState: signUpDataState ?? this.signUpDataState,
    );
  }

  bool get isValidated {
    final passwordValid = password.value.trim().isNotEmpty;
    final confirmPasswordValid = confirmPassword.value.trim().isNotEmpty;

    final passwordsMatch = password.value == confirmPassword.value;

    return email.valid &&
        fullName.valid &&
        phoneNumber.valid &&
        passwordValid &&
        confirmPasswordValid &&
        passwordsMatch;
  }

  List<FormzInput<dynamic, dynamic>> get inputs => [
    fullName,
    email,
    phoneNumber,
    password,
    confirmPassword,
  ];
}
