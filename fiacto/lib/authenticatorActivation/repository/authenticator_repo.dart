import 'package:fiacto/authenticatorActivation/repository/Model/authenticator_model.dart';

abstract class AuthenticatorRepository {
  Future<AuthenticatorModel> authenticatorQRImage();
  Future<AuthenticatorModel> authenticatorSecretKey();
  Future<QrModel> verifyAuthCode(String tokenCode);
  Future<void> updateBuilder(String id);
}
