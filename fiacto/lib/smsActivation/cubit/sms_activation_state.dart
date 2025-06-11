// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sms_activation_cubit.dart';

typedef SendOTPDataState = DataState<void>;
typedef VerifyOTPDataState = DataState<void>;

class SmsActivationState extends Equatable {
  final Country selectedCountry;
  final PhoneNumber phoneNumber;
  final General otp;
  final FormzStatus status;
  final String countryCode;
  final SendOTPDataState sendOTPState;
  final VerifyOTPDataState verifyOTPState;

  const SmsActivationState({
    required this.selectedCountry,
    this.phoneNumber = const PhoneNumber.pure(),
    this.otp = const General.pure(),
    this.status = FormzStatus.pure,
    this.countryCode = '',
    this.sendOTPState = const DataState(),
    this.verifyOTPState = const DataState(),
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
    selectedCountry,
    phoneNumber,
    otp,
    status,
    countryCode,
    sendOTPState,
    verifyOTPState,
  ];

  SmsActivationState copyWith({
    Country? selectedCountry,
    PhoneNumber? phoneNumber,
    General? otp,
    FormzStatus? status,
    String? countryCode,
    SendOTPDataState? sendOTPState,
    VerifyOTPDataState? verifyOTPState,
  }) {
    return SmsActivationState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      status: status ?? this.status,
      countryCode: countryCode ?? this.countryCode,
      sendOTPState: sendOTPState ?? this.sendOTPState,
      verifyOTPState: verifyOTPState ?? this.verifyOTPState,
    );
  }

  String get phone => '+${selectedCountry.phoneCode}${phoneNumber.value}';
}
