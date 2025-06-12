import 'package:common/http/http_client.dart';
import 'package:common/utils/utils.dart';
import 'package:fiacto/accountVerification/repository/two_factor_login_repo.dart';
import 'package:fiacto/constants/api_end_points.dart';

class TwoFactorLoginRepoImpl implements TwoFactorLoginRepo {
  final HttpClient httpClient;

  TwoFactorLoginRepoImpl({required this.httpClient});

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
  Future<void> verifyLoginAuthenticatorCode({
    required String tokenCode,
    required String token,
  }) async {
    await httpClient.post<JsonObject>(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      path: ApiEndpoints.authenticatorCodeVerify,
      body: {'user_type': 'builder', 'token': tokenCode},
    );
  }

  @override
  Future<void> verifyLoginOtp({
    required String phoneNumber,
    required String otp,
    required String token,
  }) {
    return httpClient.post<JsonObject>(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      path: ApiEndpoints.verifyPhoneOtp,
      body: {'phone_no': phoneNumber, 'otp': otp},
    );
  }
}
