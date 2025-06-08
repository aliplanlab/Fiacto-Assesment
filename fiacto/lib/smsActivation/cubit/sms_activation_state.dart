// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sms_activation_cubit.dart';

class SmsActivationState extends Equatable {
  final Country selectedCountry;
  final PhoneNumber phoneNumber;
  final String otp;
  final FormzStatus status;

  const SmsActivationState({
    required this.selectedCountry,
    this.phoneNumber = const PhoneNumber.pure(),
    this.otp = '',
    this.status = FormzStatus.pure,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [selectedCountry, phoneNumber, otp, status];

  SmsActivationState copyWith({
    Country? selectedCountry,
    PhoneNumber? phoneNumber,
    String? otp,
    FormzStatus? status,
  }) {
    return SmsActivationState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      status: status ?? this.status,
    );
  }
}
