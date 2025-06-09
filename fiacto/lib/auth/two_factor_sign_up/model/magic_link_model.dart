import 'package:common/common.dart';

class MagicLinkModel {
  const MagicLinkModel({
    this.code = '',
    this.success = false,
  });

  factory MagicLinkModel.fromJson(Map<String, dynamic> json) {
    return MagicLinkModel(
      code: $cast(json['code']),
      success: $cast(json['success']),
    );
  }

  final String? code;
  final bool? success;

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'success': success,
    };
  }
}
