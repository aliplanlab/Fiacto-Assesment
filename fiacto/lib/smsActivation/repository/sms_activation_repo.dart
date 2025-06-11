abstract class SmsActivationRepo {
  Future<String> sendOTP(String phoneNumber);
  Future<void> verifyOTP({required String phoneNumber, required String otp});
}
