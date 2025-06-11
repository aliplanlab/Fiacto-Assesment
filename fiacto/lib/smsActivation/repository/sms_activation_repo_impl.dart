import 'package:common/http/http_client.dart';
import 'package:common/utils/utils.dart';
import 'package:fiacto/constants/api_end_points.dart';
import 'package:fiacto/smsActivation/repository/sms_activation_repo.dart';

class SmsActivationRepoImpl implements SmsActivationRepo {
  final HttpClient httpClient;

  SmsActivationRepoImpl({required this.httpClient});
  @override
  Future<String> sendOTP(String phoneNumber) {
    return httpClient.post(
      path: ApiEndpoints.sendPhoneOtp,
      body: {
        'phone_no': phoneNumber,
        'user_type': 'builder',
        'type': 'sign-up',
      },
    );
  }

  @override
  Future<void> verifyOTP({required String phoneNumber, required String otp}) {
    return httpClient.post<JsonObject>(
      path: ApiEndpoints.verifyPhoneOtp,
      body: {'phone_no': phoneNumber, 'otp': otp},
    );
  }
}
