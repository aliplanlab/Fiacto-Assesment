import 'package:bloc/bloc.dart';
import 'package:common/validators/phone_number.dart';
import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sms_activation_state.dart';

class SmsActivationCubit extends Cubit<SmsActivationState> {
  SmsActivationCubit()
    : super(
        SmsActivationState(
          selectedCountry: Country(
            e164Sc: 1,
            phoneCode: '1',
            countryCode: 'US',
            name: 'United States',
            geographic: true,
            level: 2,
            example: '',
            displayName: '',
            displayNameNoCountryCode: '',
            e164Key: '',
          ),
        ),
      );

  void selectCountry(Country country) {
    emit(state.copyWith(selectedCountry: country));
  }

  void phoneNumber(String value) {
    final phoneNumber = PhoneNumber.dirty(value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([phoneNumber]),
      ),
    );
  }
}
