import 'package:common/common.dart';

class AuthenticatorModel {
  final String? qrCode;
  final String? secretKey;

  AuthenticatorModel({this.qrCode, this.secretKey});

  factory AuthenticatorModel.fromJson(JsonObject json, String? secretKey) {
    return AuthenticatorModel(qrCode: json['qr_code'], secretKey: secretKey);
  }
}

class QrModel {
  const QrModel({required this.response});

  factory QrModel.fromJson(Map<String, dynamic> json) {
    return QrModel(response: $cast(json['response']));
  }

  final String? response;
}
