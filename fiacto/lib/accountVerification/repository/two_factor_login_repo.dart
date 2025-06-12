abstract class TwoFactorLoginRepo {
  Future<String> sendOTP(String phoneNumber);
  Future<void> verifyLoginOtp({
    required String phoneNumber,
    required String otp,
    required String token,
  });

  Future<void> verifyLoginAuthenticatorCode({
    required String tokenCode,
    required String token,
  });
}
