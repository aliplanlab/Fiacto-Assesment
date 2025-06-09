import 'package:common/common.dart';
import 'package:fiacto/auth/two_factor_sign_up/repository/repository.dart';
import 'package:fiacto/constants/api_end_points.dart';

class TwoFactorSignRepositoryImp extends TwoFactorSignRepository {
  TwoFactorSignRepositoryImp({required this.httpClient});

  final HttpClient httpClient;

 

  @override
  Future<UserEntity> getUser({required String token, required String id}) {
    return httpClient
        .get<JsonObject>(
          headers:
              token.isEmpty
                  ? null
                  : {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer $token',
                  },
          path: '${ApiEndpoints.getBuilderUser}/$id',
        )
        .then(
          (json) =>
              $mapIt(
                json,
                (it) => UserEntity.fromJson(it['data'] as JsonObject, token),
              )!,
        );
  }

  @override
  Future<UserEntity> updateUser({
    required String token,
    required String fcmToken,
    required String builderId,
  }) {
    return httpClient
        .patch<JsonObject>(path: '${ApiEndpoints.builderUserUpdate}/$builderId')
        .then(
          (json) =>
              $mapIt(
                json,
                (it) => UserEntity.fromJson(it['data'] as JsonObject, token),
              )!,
        );
  }
}
