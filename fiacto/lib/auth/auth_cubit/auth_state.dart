part of 'auth_cubit.dart';

typedef GeneralDataSate = DataState<void>;
typedef UserDataSate = DataState<UserEntity>;
typedef UpdateBuilderUserDataState = DataState<void>;
typedef UpdateRoleFcmDataState = DataState<void>;

class AuthState extends Equatable {
  const AuthState({
    this.status = FormzStatus.pure,
    this.otpPhoneNumberVerifiedLogin = const General.pure(),
    this.authenticatorCodeLogin = const General.pure(),
    this.authenticatorCodeSignUp = const General.pure(),
    this.phoneNumberLoginDataSate = const DataState(),
    this.qrCodeUrl = '',
    this.secret = '',
    this.authAppCode = const General.pure(),
    this.userDataState = const DataState(),
    this.otpSignUpPhoneVerified = const General.pure(),
    this.authAppVerificationState = const DataState(),
    this.isLoading = false,
    this.otpLoginVerifiedDataState = const DataState(),
    this.magicLinkSendDataState = const DataState(),
    this.getUserDataState = const DataState(),
    this.getUserAuthenticatorDataState = const DataState(),
    this.getUserLoginDataState = const DataState(),
    this.magicLinkResendDataState = const DataState(),
    this.verificationDataState = const DataState(),
    this.countryCode = '',
    this.resendCodeSignUpDataState = const DataState(),
    this.resendCodeLoginDataState = const DataState(),
    this.userToken,
    this.userId,
    this.fcmToken,
    this.updateBuilderUserDataState = const DataState(),
    this.updateRoleFcmDataState = const DataState(),
  });

  final General otpPhoneNumberVerifiedLogin;
  final General authenticatorCodeLogin;
  final General authenticatorCodeSignUp;
  final String qrCodeUrl;
  final String secret;
  final General authAppCode;
  final FormzStatus status;
  final General otpSignUpPhoneVerified;
  final bool isLoading;
  final String? userToken;
  final String? userId;
  final String? fcmToken;

  final GeneralDataSate phoneNumberLoginDataSate;
  final GeneralDataSate authAppVerificationState;
  final UserDataSate userDataState;
  final GeneralDataSate otpLoginVerifiedDataState;
  final GeneralDataSate magicLinkSendDataState;
  final UserDataSate getUserDataState;
  final UserDataSate getUserAuthenticatorDataState;
  final UserDataSate getUserLoginDataState;
  final GeneralDataSate magicLinkResendDataState;
  final UserDataSate verificationDataState;
  final String countryCode;
  final GeneralDataSate resendCodeSignUpDataState;
  final GeneralDataSate resendCodeLoginDataState;
  final UpdateBuilderUserDataState updateBuilderUserDataState;
  final UpdateRoleFcmDataState updateRoleFcmDataState;

  AuthState copyWith({
    Email? email,
    Password? password,
    Email? signEmail,
    Password? signPassword,
    General? companyName,
    Email? forgotEmail,
    General? resetPassword,
    FormzStatus? status,
    General? otpPhoneNumberVerifiedLogin,
    General? authenticatorCodeLogin,
    General? authenticatorCodeSignUp,
    GeneralDataSate? phoneNumberLoginDataSate,
    String? qrCodeUrl,
    General? authAppCode,
    String? secret,
    General? otpSignUpPhoneVerified,
    UserDataSate? userDataState,
    GeneralDataSate? authAppVerificationState,
    bool? isLoading,
    GeneralDataSate? otpLoginVerifiedDataState,
    GeneralDataSate? magicLinkSendDataState,
    UserDataSate? getUserDataState,
    UserDataSate? getUserAuthenticatorDataState,
    UserDataSate? getUserLoginDataState,
    GeneralDataSate? forgotPasswordDataState,
    GeneralDataSate? magicLinkResendDataState,
    UserDataSate? verificationDataState,
    String? countryCode,
    GeneralDataSate? resendCodeSignUpDataState,
    GeneralDataSate? resendCodeLoginDataState,
    String? userToken,
    String? userId,
    String? fcmToken,
    UpdateRoleFcmDataState? updateRoleFcmDataState,
    UpdateBuilderUserDataState? updateBuilderUserDataState,
  }) {
    return AuthState(
      status: status ?? this.status,
      otpPhoneNumberVerifiedLogin:
          otpPhoneNumberVerifiedLogin ?? this.otpPhoneNumberVerifiedLogin,
      authenticatorCodeLogin:
          authenticatorCodeLogin ?? this.authenticatorCodeLogin,
      authenticatorCodeSignUp:
          authenticatorCodeSignUp ?? this.authenticatorCodeSignUp,
      phoneNumberLoginDataSate:
          phoneNumberLoginDataSate ?? this.phoneNumberLoginDataSate,
      userDataState: userDataState ?? this.userDataState,
      qrCodeUrl: qrCodeUrl ?? this.qrCodeUrl,
      secret: secret ?? this.secret,
      otpSignUpPhoneVerified:
          otpSignUpPhoneVerified ?? this.otpSignUpPhoneVerified,
      authAppVerificationState:
          authAppVerificationState ?? this.authAppVerificationState,
      authAppCode: authAppCode ?? this.authAppCode,
      isLoading: isLoading ?? this.isLoading,
      otpLoginVerifiedDataState:
          otpLoginVerifiedDataState ?? this.otpLoginVerifiedDataState,
      magicLinkSendDataState:
          magicLinkSendDataState ?? this.magicLinkSendDataState,
      getUserDataState: getUserDataState ?? this.getUserDataState,
      getUserAuthenticatorDataState:
          getUserAuthenticatorDataState ?? this.getUserAuthenticatorDataState,
      getUserLoginDataState:
          getUserLoginDataState ?? this.getUserLoginDataState,
      magicLinkResendDataState:
          magicLinkResendDataState ?? this.magicLinkResendDataState,
      verificationDataState:
          verificationDataState ?? this.verificationDataState,
      countryCode: countryCode ?? this.countryCode,
      resendCodeSignUpDataState:
          resendCodeSignUpDataState ?? this.resendCodeSignUpDataState,
      resendCodeLoginDataState:
          resendCodeLoginDataState ?? this.resendCodeLoginDataState,
      userToken: userToken ?? this.userToken,
      userId: userId ?? this.userId,
      updateBuilderUserDataState:
          updateBuilderUserDataState ?? this.updateBuilderUserDataState,
      updateRoleFcmDataState:
          updateRoleFcmDataState ?? this.updateRoleFcmDataState,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  @override
  List<Object?> get props => [
        countryCode,
        status,
        otpPhoneNumberVerifiedLogin,
        authenticatorCodeLogin,
        authenticatorCodeSignUp,
        phoneNumberLoginDataSate,
        qrCodeUrl,
        secret,
        userDataState,
        otpSignUpPhoneVerified,
        authAppVerificationState,
        authAppCode,
        isLoading,
        otpLoginVerifiedDataState,
        magicLinkSendDataState,
        getUserDataState,
        getUserAuthenticatorDataState,
        getUserLoginDataState,
        magicLinkResendDataState,
        verificationDataState,
        resendCodeSignUpDataState,
        resendCodeLoginDataState,
        userToken,
        userId,
        updateBuilderUserDataState,
        fcmToken,
        updateRoleFcmDataState,
      ];

  bool get emailVerified => verificationDataState.data?.isEmailVerified == true;

  FormzStatus validWith(
    PhoneNumber? otpPhoneNumberSignUp,
    Email? twoFaEmailForgot,
    General? otpPhoneNumberForgot,
    General? otpForgotEmailVerified,
    General? otpForgotAuthenticatorVerified,
    General? otpSignUpPhoneVerified,
    General? otpPhoneNumberVerifiedLogin,
    General? authAppCode,
    Password? newPassword,
    Password? reEnterPassword,
  ) {
    return Formz.validate([
      General.dirty(
        otpSignUpPhoneVerified?.value ?? this.otpSignUpPhoneVerified.value,
      ),
      General.dirty(
        otpPhoneNumberVerifiedLogin?.value ??
            this.otpPhoneNumberVerifiedLogin.value,
      ),
      General.dirty(
        authAppCode?.value ?? this.authAppCode.value,
      ),
      // Email.dirty(
      //   twoFaEmailForgot?.value ?? this.twoFaEmailForgot.value,
      // ),
      // General.dirty(
      //   otpPhoneNumberForgot?.value ?? this.otpPhoneNumberForgot.value,
      // ),
      // General.dirty(
      //   otpForgotEmailVerified?.value ?? this.otpForgotEmailVerified.value,
      // ),
      // General.dirty(
      //   otpForgotAuthenticatorVerified?.value ??
      //       this.otpForgotAuthenticatorVerified.value,
      // ),
      // Password.dirty(
      //   newPassword?.value ?? this.newPassword.value,
      // ),
      // Password.dirty(
      //   reEnterPassword?.value ?? this.reEnterPassword.value,
      // ),
    ]);
  }
}
