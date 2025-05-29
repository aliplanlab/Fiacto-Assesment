import 'dart:async';
import 'dart:convert';

import 'package:common/common.dart';
import 'package:flutter/foundation.dart';

export 'models/models.dart';

part 'auth_repository.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
abstract class AuthRepository {
  /// {@macro authentication_repository}
  AuthRepository({
    AsyncStorageClient? storage,
    StreamController<User>? userAuth,
  })  : _storage = storage ?? CacheStorage(),
        _userAuth = userAuth ?? StreamController<User>.broadcast() {
    _user.then((user) {
      _currentUser = user;
      _userAuth.add(user);
    });
  }

  final AsyncStorageClient _storage;
  final StreamController<User> _userAuth;
  User _currentUser = User.loading;

  /// Updates the user stream with the new [user].
  void updateUser(User user) {
    _currentUser = user;
    _userAuth.add(user);
    _storage.write(
      userCacheKey,
      value: jsonEncode(user.toJson()),
    );
  }

  void updateBuilderUser(User user) {
    _currentUser = user;
    _storage.write(
      userCacheKey,
      value: jsonEncode(user.toJson()),
    );
  }

  void updateOnboarding(bool onboarded) {
    _storage.write(
      onboardingKey,
      value: '1',
    );
  }

  Future<bool> get onboarding async {
    final onboarded = await _storage.read<String>(onboardingKey) ?? '0';
    return onboarded == '1';
  }

  Future<User> get _user async {
    final userJson = await _storage.read<String>(userCacheKey);
    return userJson == null
        ? User.empty
        : User.fromJson(jsonDecode(userJson) as JsonObject);
  }

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  @visibleForTesting
  static const onboardingKey = '__onboarding_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user => _userAuth.stream;

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser => _currentUser;

  bool get isAuthenticated => currentUser.isAuthenticated;

  /// JWT token of current user
  String get authToken => currentUser.token;

  /// Headers with [JWT] token
  Map<String, String>? get headersWithJWT => authToken.isNotEmpty
      ? {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        }
      : null;

  /// id of the current user
  String? get userId => currentUser.isNotAuthenticated ? null : currentUser.id;

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  Future<void> logOut() async {
    updateUser(User.empty);
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LoginWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> loginWithEmailPassword({
    required String email,
    required String password,
  });

  /// Signs in with the provided [phoneNumber] and [password].
  ///
  /// Throws a [LoginWithPhoneNumberPasswordFailed] if an exception occurs.
  Future<void> loginWithPhoneNumberPassword({
    required String phoneNumber,
    required String password,
  });

  /// disposes the _userAuth and _cache
  Future<dynamic> dispose() => Future.wait([
        _storage.close(),
        _userAuth.close(),
      ]);
}
