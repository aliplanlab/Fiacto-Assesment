import 'package:common/http/http_client.dart';
import 'package:common/utils/utils.dart';
import 'package:fiacto/authenticatorActivation/repository/Model/authenticator_model.dart';
import 'package:fiacto/authenticatorActivation/repository/authenticator_repo.dart';
import 'package:fiacto/constants/api_end_points.dart';

class AuthenticatorRepoImpl implements AuthenticatorRepository {
  final HttpClient httpClient;

  AuthenticatorRepoImpl({required this.httpClient});

  @override
  Future<AuthenticatorModel> authenticatorQRImage({String? token}) {
    return httpClient
        .post<JsonObject>(
          path: ApiEndpoints.authenticatorQrImageGenerate,
          body: {'user_type': 'builder'},
        )
        .then(
          (result) =>
              $mapIt(
                result,
                (e) => AuthenticatorModel.fromJson(e['data'] as JsonObject, ''),
              )!,
        );
  }

  @override
  Future<AuthenticatorModel> authenticatorSecretKey({String? token}) {
    return httpClient
        .post<JsonObject>(
          path: ApiEndpoints.authenticatorQrSecretGenerate,
          body: {'user_type': 'builder'},
        )
        .then(
          (result) =>
              $mapIt(
                result,
                (it) => AuthenticatorModel.fromJson(
                  it as JsonObject,
                  result['data'] as String,
                ),
              )!,
        );
  }

  @override
  Future<QrModel> verifyAuthCode(String tokenCode) {
    return httpClient
        .post<JsonObject>(
          path: ApiEndpoints.authenticatorCodeVerify,
          body: {'user_type': 'builder', 'token': tokenCode},
        )
        .then(
          (json) => $mapIt(json, (it) => QrModel.fromJson(it as JsonObject))!,
        );
  }

  @override
  Future<void> updateBuilder(String id) {
    return httpClient.patch(
      path: '${ApiEndpoints.builderUserUpdate}/$id',
      body: {'auth_app_2fa': true},
    );
  }
}
