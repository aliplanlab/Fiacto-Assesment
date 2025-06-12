// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'twoFactor_login_cubit.dart';

typedef SendOTPDataState = DataState<void>;
typedef VerifyLoginOtpDataState = DataState<void>;
typedef VerifyLoginAuthenticatorDataState = DataState<void>;
typedef BuilderUpdateDataSate = DataState<void>;


class TwoFaLoginState extends Equatable {
  final VerifyLoginOtpDataState verifyLoginOtpDataState;
  final General otp;
  final General authAppCode;
  final FormzStatus status;
  final String countryCode;
  final SendOTPDataState sendOTPState;
  final VerifyLoginAuthenticatorDataState verifyLoginAuthenticatorDataState;
  final BuilderUpdateDataSate builderUpdateDataState;

  const TwoFaLoginState({
    this.verifyLoginOtpDataState = const DataState(),
    this.authAppCode = const General.pure(),
    this.otp = const General.pure(),
    this.status = FormzStatus.pure,
    this.countryCode = '',
    this.sendOTPState = const DataState(),
    this.verifyLoginAuthenticatorDataState = const DataState(),
    this.builderUpdateDataState = const DataState(),
  });

  @override
  List<Object?> get props => [
    verifyLoginOtpDataState,
    authAppCode,
    otp,
    status,
    countryCode,
    sendOTPState,
    verifyLoginAuthenticatorDataState,
    builderUpdateDataState,
  ];

  TwoFaLoginState copyWith({
    VerifyLoginOtpDataState? verifyLoginOtpDataState,
    General? authAppCode,
    General? otp,
    FormzStatus? status,
    String? countryCode,
    SendOTPDataState? sendOTPState,
    VerifyLoginAuthenticatorDataState? verifyLoginAuthenticatorDataState,
    BuilderUpdateDataSate? builderUpdateDataState,
  }) {
    return TwoFaLoginState(
      verifyLoginOtpDataState:
          verifyLoginOtpDataState ?? this.verifyLoginOtpDataState,
      authAppCode: authAppCode ?? this.authAppCode,
      otp: otp ?? this.otp,
      status: status ?? this.status,
      countryCode: countryCode ?? this.countryCode,
      sendOTPState: sendOTPState ?? this.sendOTPState,
      verifyLoginAuthenticatorDataState:
          verifyLoginAuthenticatorDataState ??
          this.verifyLoginAuthenticatorDataState,
      builderUpdateDataState:
          builderUpdateDataState ?? this.builderUpdateDataState,
    );
  }
}
