import 'package:common/common.dart';
import 'package:fiacto/constants/api_end_points.dart';
import 'package:fiacto/login/repository/repository.dart';

class LoginRepositoryImp extends LoginRepository {
  LoginRepositoryImp({required this.httpClient});

  final HttpClient httpClient;

  @override
  Future<UserEntity> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    return httpClient
        .post<JsonObject>(
          path: ApiEndpoints.login,
          body: {'email': email, 'password': password},
        )
        .then(
          (json) =>
              $mapIt(
                json,
                (e) => UserEntity.fromJson(
                  e['data']['user'] as JsonObject,
                  e['data']['token'] as String,
                ),
              )!,
        );
  }
}
