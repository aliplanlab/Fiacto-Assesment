part of 'entity.dart';

class UserEntity {
  UserEntity({
    this.id,
    this.email,
    this.isPropertyExist,
    this.companyName,
    this.isEmailVerified,
    this.preferredLanguage,
    this.phoneNo,
    this.profileImage,
    this.endUserAgreement,
    this.coverPhoto,
    this.userSignature,
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
    this.text2fa,
    this.email2fa,
    this.authApp2fa,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.profileSkipped,
    this.authConnectType,
    this.isFacebookConnected,
    this.isGoogleConnected,
    this.isAppleConnected,
  });

  factory UserEntity.fromJson(
    JsonObject json,
    String? token,
  ) =>
      UserEntity(
        id: $cast(json['id']),
        companyName: $cast(json['company_name']),
        isPropertyExist: $cast(json['is_property_exist']),
        email: $cast(json['email']),
        isEmailVerified: $cast(json['is_email_verified']),
        preferredLanguage: $cast(json['preffered_language']),
        phoneNo: $cast(json['phone_no']),
        profileImage: $cast(json['profile_image']),
        coverPhoto: $cast(json['cover_photo']),
        endUserAgreement: $cast(json['end_user_agreement']),
        userSignature: $cast(json['user_signature']),
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
        text2fa: $cast(json['text_otp_2fa']),
        email2fa: $cast(json['email_2fa']),
        authApp2fa: $cast(json['auth_app_2fa']),
        createdAt: $cast(json['createdAt']),
        updatedAt: $cast(json['updatedAt']),
        authConnectType: $cast(json['authConnectType']),
        token: token,
        profileSkipped: $cast(json['profile_skipped']),
        isFacebookConnected: $cast(json['is_facebook_connected']),
        isGoogleConnected: $cast(json['is_google_connected']),
        isAppleConnected: $cast(json['is_apple_connected']),
      );

  final String? id;
  final String? companyName;
  final bool? isPropertyExist;
  final String? email;
  final bool? isEmailVerified;
  final String? preferredLanguage;
  final String? phoneNo;
  final String? profileImage;
  final String? coverPhoto;
  final String? endUserAgreement;
  final String? userSignature;
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
  final String? authConnectType;
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
  final bool? profileSkipped;
  final bool? isFacebookConnected;
  final bool? isGoogleConnected;
  final bool? isAppleConnected;

  JsonObject toJson() => {
        'id': id,
        'company_name': companyName,
        'is_property_exist': isPropertyExist,
        'email': email,
        'is_email_verified': isEmailVerified,
        'preffered_language': preferredLanguage,
        'phone_no': phoneNo,
        'profile_image': profileImage,
        'cover_photo': coverPhoto,
        'end_user_agreement': endUserAgreement,
        'user_signature': userSignature,
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
        'text_otp_2fa': text2fa,
        'email_2fa': email2fa,
        'auth_app_2fa': authApp2fa,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'authConnectType': authConnectType,
        'token': token,
        'profile_skipped': profileSkipped,
        'is_google_connected': isGoogleConnected,
        'is_facebook_connected': isFacebookConnected,
        'is_apple_connected': isAppleConnected,
      };
}
