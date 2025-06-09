import 'package:common/auth/api/entity/entity.dart';

abstract class TwoFactorSignRepository {
  Future<UserEntity> getUser({required String token, required String id});

  Future<void> updateUser({
    required String token,
    required String fcmToken,
    required String builderId,
  });
}
