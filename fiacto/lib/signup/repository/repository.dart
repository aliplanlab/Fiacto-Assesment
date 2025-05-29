import 'dart:async';

import 'package:common/auth/api/api.dart';

abstract class SignUpRepository {
  Future<UserEntity> signUpWithEmailPassword({
    required String companyName,
    required String email,
    required String password,
  });
  Future<UserEntity> getBuilderUser({
    required String token,
    required String id,
  });
}
