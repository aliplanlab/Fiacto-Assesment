class ApiEndpoints {
  ApiEndpoints._(); // coverage:ignore-line

  static const login = 'builder/login';
  static const signUp = 'builder/signup';
  static const getBuilderUser = 'builder-user';
  static const authenticatorQrImageGenerate = 'two-factor-auth/qr/generate';
  static const authenticatorQrSecretGenerate = 'two-factor-auth/qr/secret';
  static const authenticatorCodeVerify = 'two-factor-auth/qr/verify';
  static const builderUserUpdate = 'builder-user/update';
}
