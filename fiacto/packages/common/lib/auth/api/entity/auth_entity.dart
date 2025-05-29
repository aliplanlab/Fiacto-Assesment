part of 'entity.dart';

class AuthEntity {
  const AuthEntity({
    this.accessToken,
    this.expiresIn,
    this.refreshExpiresIn,
    this.refreshToken,
    this.tokenType,
    this.scope,
  });

  factory AuthEntity.fromJson(JsonObject json) => AuthEntity(
        accessToken: $cast(json['access_token']),
        expiresIn: $cast(json['expires_in']),
        refreshExpiresIn: $cast(json['refresh_expires_in']),
        refreshToken: $cast(json['refresh_token']),
        tokenType: $cast(json['token_type']),
        scope: $cast(json['scope']),
      );

  final String? accessToken;
  final int? expiresIn;
  final int? refreshExpiresIn;
  final String? refreshToken;
  final String? tokenType;
  final String? scope;

  static const empty = AuthEntity(accessToken: 'token');
}
