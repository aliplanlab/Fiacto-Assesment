part of 'api.dart';

class AuthApiImpl extends AuthApi {
  AuthApiImpl()
      : httpClient = HttpClient(
          clientConfig: AppEnvironment.current.config,
        );

  final HttpClient httpClient;

  @override
  Future<AuthEntity> loginWithEmailPassword({
    required String email,
    required String password,
    required String deviceToken,
  }) {
    return httpClient.post<JsonObject>(
      path: AuthApiEndpoints.login,
      body: {
        'username': email,
        'password': password,
        'device_token': deviceToken,
      },
    ).then((result) {
      return AuthEntity.fromJson(result);
    });
  }

  @override
  Future<void> logOut(Map<String, String>? headersWithJWT) {
    return httpClient.post(
      path: AuthApiEndpoints.logout,
      headers: headersWithJWT,
    );
  }

  @override
  Future<UserEntity> getUser({required String token}) {
    return httpClient.get<JsonObject>(
      path: AuthApiEndpoints.user,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then(
      (result) => $mapIt(
        result['user-profile'],
        (it) => UserEntity.fromJson(
          it as JsonObject,
          token,
        ),
      )!,
    );
  }
}
