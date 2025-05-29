import 'package:common/common.dart';

export 'entity/entity.dart';

part 'auth_api.dart';
part 'endpoints.dart';

abstract class AuthApi {
  Future<AuthEntity> loginWithEmailPassword({
    required String email,
    required String password,
    required String deviceToken,
  });

  Future<UserEntity> getUser({required String token});

  Future<void> logOut(Map<String, String>? headersWithJWT);
}
