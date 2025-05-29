import 'package:common/common.dart';
import 'package:common/utils/utils.dart';

class SignUpModel {
  const SignUpModel({
    required this.id,
    this.companyName,
    this.email,
    this.isEmailVerified,
    this.preferredLanguage,
    this.phoneNo,
    this.profileImage,
    this.coverPhoto,
    this.endUserAgreement,
    this.articleOfIncorporation,
    this.builderLicence,
    this.taxIdentificationNo,
    this.tagline,
    this.streetAddress,
    this.city,
    this.state,
    this.zipCode,
    this.status,
    this.signUpType,
    this.qrCodeSecret,
    this.qrCode,
    this.endpoint,
    this.companyNameVisibility,
    this.text2fa,
    this.email2fa,
    this.authApp2fa,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json, String? token) {
    return SignUpModel(
      id: $cast(json['id']),
      companyName: $cast(json['company_name']),
      email: $cast(json['email']),
      isEmailVerified: $cast(json['is_email_verified']),
      preferredLanguage: $cast(json['preffered_language']),
      phoneNo: $cast(json['phone_no']),
      profileImage: $cast(json['profile_image']),
      coverPhoto: $cast(json['cover_photo']),
      endUserAgreement: $cast(json['end_user_agreement']),
      articleOfIncorporation: $cast(json['article_of_incorporation']),
      builderLicence: $cast(json['builder_licence']),
      taxIdentificationNo: $cast(json['tax_identification_no']),
      tagline: $cast(json['tagline']),
      streetAddress: $cast(json['street_address']),
      city: $cast(json['city']),
      state: $cast(json['state']),
      zipCode: $cast(json['zip_code']),
      status: $cast(json['status']),
      signUpType: $cast(json['signUpType']),
      qrCodeSecret: $cast(json['qr_code_secret']),
      qrCode: $cast(json['qr_code']),
      endpoint: $cast(json['endpoint']),
      companyNameVisibility: $cast(json['company_name_visibility']),
      text2fa: $cast(json['text_2fa']),
      email2fa: $cast(json['email_2fa']),
      authApp2fa: $cast(json['auth_app_2fa']),
      createdAt: $cast(json['createdAt']),
      updatedAt: $cast(json['updatedAt']),
      token: token,
    );
  }

  static const empty = SignUpModel(id: '', token: '');
  static const loading = SignUpModel(email: 'loading', id: '', token: '');

  bool get isEmpty => id!.isEmpty;

  bool get isNotEmpty => !isEmpty;

  bool get isAuthenticated => isNotEmpty && token!.isNotEmpty;

  bool get isNotAuthenticated => !isAuthenticated;

  bool get isLoading => this == loading;

  final String? id;
  final String? companyName;
  final String? email;
  final bool? isEmailVerified;
  final String? preferredLanguage;
  final String? phoneNo;
  final String? profileImage;
  final String? coverPhoto;
  final String? endUserAgreement;
  final String? articleOfIncorporation;
  final String? builderLicence;
  final String? taxIdentificationNo;
  final String? tagline;
  final String? streetAddress;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? status;
  final String? signUpType;
  final String? qrCodeSecret;
  final String? qrCode;
  final String? endpoint;
  final bool? companyNameVisibility;
  final bool? text2fa;
  final bool? email2fa;
  final bool? authApp2fa;
  final String? createdAt;
  final String? updatedAt;
  final String? token;

  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'email': email,
      'is_email_verified': isEmailVerified,
      'preffered_language': preferredLanguage,
      'phone_no': phoneNo,
      'profile_image': profileImage,
      'cover_photo': coverPhoto,
      'end_user_agreement': endUserAgreement,
      'article_of_incorporation': articleOfIncorporation,
      'builder_licence': builderLicence,
      'tax_identification_no': taxIdentificationNo,
      'tagline': tagline,
      'street_address': streetAddress,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'status': status,
      'signUpType': signUpType,
      'qr_code_secret': qrCodeSecret,
      'qr_code': qrCode,
      'endpoint': endpoint,
      'company_name_visibility': companyNameVisibility,
      'text_2fa': text2fa,
      'email_2fa': email2fa,
      'auth_app_2fa': authApp2fa,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
