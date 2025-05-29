part of 'models.dart';

class User extends Equatable {
  const User({
    this.id = '',
    this.email,
    this.companyName,
    this.isEmailVerified,
    this.preferredLanguage,
    this.phoneNo,
    this.profileImage,
    this.isPropertyExist,
    this.coverPhoto,
    this.endUserAgreement,
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
    this.text2fa,
    this.email2fa,
    this.authApp2fa,
    this.companyNameVisibility,
    this.createdAt,
    this.updatedAt,
    this.authConnectType,
    this.isFacebookConnected,
    this.isGoogleConnected,
    this.isAppleConnected,
    this.token = '',
    this.profileSkipped,
  });

  factory User.fromEntity(
    UserEntity entity, [
    String? token,
  ]) {
    return User(
      id: entity.id ?? '',
      isPropertyExist: entity.isPropertyExist,
      email: entity.email,
      companyName: entity.companyName,
      isEmailVerified: entity.isEmailVerified,
      preferredLanguage: entity.preferredLanguage,
      phoneNo: entity.phoneNo,
      profileImage: entity.profileImage,
      coverPhoto: entity.coverPhoto,
      endUserAgreement: entity.endUserAgreement,
      userSignature: entity.userSignature,
      articleOfIncorporation: entity.articleOfIncorporation,
      builderLicence: entity.builderLicence,
      taxIdentificationNo: entity.taxIdentificationNo,
      tagline: entity.tagline,
      streetAddress: entity.streetAddress,
      city: entity.city,
      state: entity.state,
      zipCode: entity.zipCode,
      status: entity.status,
      signUpType: entity.signUpType,
      endpoint: entity.endpoint,
      qrCodeSecret: entity.qrCodeSecret,
      qrCode: entity.qrCode,
      companyNameVisibility: entity.companyNameVisibility,
      text2fa: entity.text2fa,
      email2fa: entity.email2fa,
      authApp2fa: entity.authApp2fa,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      authConnectType: entity.authConnectType,
      isFacebookConnected: entity.isFacebookConnected,
      isGoogleConnected: entity.isGoogleConnected,
      isAppleConnected: entity.isAppleConnected,
      token: entity.token?.notBlank ?? token ?? '',
      profileSkipped: entity.profileSkipped,
    );
  }

  factory User.fromJson(JsonObject json) => User.fromEntity(
        UserEntity.fromJson(
          json,
          $cast(json['token']),
        ),
      );

  final String id;
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
  final String? qrCodeSecret;
  final String? qrCode;
  final String? endpoint;
  final bool? companyNameVisibility;
  final bool? text2fa;
  final bool? email2fa;
  final bool? authApp2fa;
  final String? createdAt;
  final String? updatedAt;
  final bool? profileSkipped;
  final String? authConnectType;
  final String token;
  final bool? isFacebookConnected;
  final bool? isGoogleConnected;
  final bool? isAppleConnected;

  static const empty = User();
  static const loading = User(email: 'loading');

  UserEntity toEntity() => UserEntity(
        authConnectType: authConnectType,
        id: id,
        email: email,
        companyName: companyName,
        isPropertyExist: isPropertyExist,
        isEmailVerified: isEmailVerified,
        preferredLanguage: preferredLanguage,
        phoneNo: phoneNo,
        profileImage: profileImage,
        coverPhoto: coverPhoto,
        endUserAgreement: endUserAgreement,
        userSignature: userSignature,
        articleOfIncorporation: articleOfIncorporation,
        builderLicence: builderLicence,
        taxIdentificationNo: taxIdentificationNo,
        tagline: tagline,
        streetAddress: streetAddress,
        city: city,
        state: state,
        zipCode: zipCode,
        status: status,
        signUpType: signUpType,
        endpoint: endpoint,
        qrCodeSecret: qrCodeSecret,
        qrCode: qrCode,
        companyNameVisibility: companyNameVisibility,
        text2fa: text2fa,
        email2fa: email2fa,
        authApp2fa: authApp2fa,
        createdAt: createdAt,
        updatedAt: updatedAt,
        token: token,
        profileSkipped: profileSkipped,
        isFacebookConnected: isFacebookConnected,
        isGoogleConnected: isGoogleConnected,
        isAppleConnected: isAppleConnected,
      );

  JsonObject toJson() => toEntity().toJson();

  @override
  List<Object?> get props => [
        authConnectType,
        id,
        email,
        companyName,
        isPropertyExist,
        isEmailVerified,
        preferredLanguage,
        phoneNo,
        profileImage,
        coverPhoto,
        endUserAgreement,
        userSignature,
        articleOfIncorporation,
        builderLicence,
        taxIdentificationNo,
        tagline,
        streetAddress,
        city,
        state,
        zipCode,
        status,
        signUpType,
        endpoint,
        qrCodeSecret,
        qrCode,
        companyNameVisibility,
        text2fa,
        email2fa,
        authApp2fa,
        createdAt,
        updatedAt,
        token,
        isFacebookConnected,
        isGoogleConnected,
        isAppleConnected,
      ];

  bool get isEmpty => id.isEmpty;

  bool get isNotEmpty => !isEmpty;

  bool get isAuthenticated => isNotEmpty && token.isNotEmpty;

  bool get isNotAuthenticated => !isAuthenticated;

  bool get isLoading => this == loading;

  bool get isProfileCompleted =>
      profileImage?.notBlank != null ||
      coverPhoto?.notBlank != null ||
      profileSkipped == true;

  bool get isUserAgreementComplete => userSignature?.notBlank != null;

  bool get isUserRegistrationComplete =>
      articleOfIncorporation?.notBlank != null &&
      builderLicence?.notBlank != null &&
      taxIdentificationNo?.notBlank != null;
  bool get isDocVerified => isPropertyExist == true;

  bool get isTwoFactorPhoneComplete => phoneNo?.notBlank != null;
  bool get isTwoFactorAuthenticatorComplete => authApp2fa == true;
}
