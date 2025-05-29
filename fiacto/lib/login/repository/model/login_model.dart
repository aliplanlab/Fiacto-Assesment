import 'package:common/common.dart';

class LoginModel {
  const LoginModel({
    this.emailAddress,
    this.password,
    this.companyName,
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
    this.endpoint,
    this.qrCodeSecret,
    this.qrCode,
    this.companyNameVisibility,
    this.text2FA,
    this.email2FA,
    this.authApp2FA,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.token,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json, String? token) {
    return LoginModel(
      id: $cast(json['id']),
      emailAddress: $cast(json['email']),
      password: $cast(json['password']),
      companyName: $cast(json['company_name']),
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
      endpoint: $cast(json['endpoint']),
      qrCodeSecret: $cast(json['qr_code_secret']),
      qrCode: $cast(json['qr_code']),
      text2FA: $cast(json['text_2fa']),
      email2FA: $cast(json['email_2fa']),
      authApp2FA: $cast(json['auth_app_2fa']),
      createdAt: $cast(json['createdAt']),
      updatedAt: $cast(json['updatedAt']),
      companyNameVisibility: $cast(json['company_name_visibility']),
      token: token,
    );
  }

  static const empty = LoginModel(id: '', token: '');
  static const loading = LoginModel(emailAddress: 'loading', id: '', token: '');

  bool get isEmpty => id!.isEmpty;

  bool get isNotEmpty => !isEmpty;

  bool get isAuthenticated => isNotEmpty && token!.isNotEmpty;

  bool get isNotAuthenticated => !isAuthenticated;

  bool get isLoading => this == loading;

  final String? id;
  final String? emailAddress;
  final String? password;
  final String? companyName;
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
  final String? endpoint;
  final String? qrCodeSecret;
  final String? qrCode;
  final bool? companyNameVisibility;
  final bool? text2FA;
  final bool? email2FA;
  final bool? authApp2FA;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? token;

  Map<String, dynamic> toJson() {
    return {
      'email': emailAddress,
      'password': password,
      'company_name': companyName,
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
      'endpoint': endpoint,
      'qr_code_secret': qrCodeSecret,
      'qr_code': qrCode,
      'text_2fa': text2FA,
      'email_2fa': email2FA,
      'auth_app_2fa': authApp2FA,
      'company_name_visibility': companyNameVisibility,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'token': token,
      'id': id,
    };
  }
}
