import 'package:common/common.dart';

abstract class LoginRepository {
  Future<UserEntity> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
