import 'package:common/common.dart';

class AuthenticatorModel {
  const AuthenticatorModel({
    required this.qrCodeUrl,
    required this.secret,
  });

  factory AuthenticatorModel.fromJson(
    Map<String, dynamic> json,
    String? secret,
  ) {
    return AuthenticatorModel(
      qrCodeUrl: $cast(json['qr_code']),
      secret: secret,
    );
  }
  final String? qrCodeUrl;
  final String? secret;

  Map<String, dynamic> toJson() {
    return {
      'qr_code': qrCodeUrl,
      'data': secret,
    };
  }
}
