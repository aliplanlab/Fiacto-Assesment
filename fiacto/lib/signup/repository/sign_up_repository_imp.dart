import 'package:common/common.dart';
import 'package:fiacto/constants/api_end_points.dart';
import 'package:fiacto/signup/repository/repository.dart';

class SignUpRepositoryImp extends SignUpRepository {
  SignUpRepositoryImp({required this.httpClient});

  final HttpClient httpClient;

  @override
  Future<UserEntity> signUpWithEmailPassword({
    required String email,
    required String password,
    required String companyName,
  }) {
    final authUser = httpClient
        .post<JsonObject>(
          path: ApiEndpoints.signUp,
          body: {
            'email': email,
            'password': password,
            'company_name': companyName,
          },
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
    return authUser;
  }

  @override
  Future<UserEntity> getBuilderUser({
    required String token,
    required String id,
  }) {
    return httpClient
        .get<JsonObject>(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          path: '${ApiEndpoints.getBuilderUser}/$id',
        )
        .then(
          (json) =>
              $mapIt(
                json,
                (it) => UserEntity.fromJson(it['data'] as JsonObject, ''),
              )!,
        );
  }
}
