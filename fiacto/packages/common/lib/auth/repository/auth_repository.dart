part of 'repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required this.api,
    super.storage,
    super.userAuth,
    required this.fcmToken,
  });

  final AuthApi api;
  final String fcmToken;

  @override
  Future<void> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    // final auth = await api.loginWithEmailPassword(
    //   email: email,
    //   password: password,
    //   deviceToken: 'fcmToken',
    // );
    // final user = await api.getUser(token: auth.accessToken ?? '');
    //await Future<void>.delayed(const Duration(seconds: 2));
    final user = UserEntity();
    updateUser(
      User.fromEntity(
        user,
        //token: user.token,
      ),
    );
  }

  @override
  Future<void> logOut() async {
    //final headers = headersWithJWT;
    updateUser(User.empty);
    //await api.logOut(headers).catchError((e) {});
  }

  @override
  Future<void> loginWithPhoneNumberPassword({
    required String phoneNumber,
    required String password,
  }) {
    throw UnimplementedError();
  }
}
