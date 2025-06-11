import 'package:bloc/bloc.dart';
import 'package:common/http/data_state.dart';
import 'package:common/http/http_exception.dart';
import 'package:common/validators/general.dart';
import 'package:common/validators/phone_number.dart';
import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:fiacto/smsActivation/repository/sms_activation_repo.dart';
import 'package:formz/formz.dart';

part 'sms_activation_state.dart';

class SmsActivationCubit extends Cubit<SmsActivationState> {
  SmsActivationCubit({required this.repository})
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

  final SmsActivationRepo repository;

  void selectCountry(Country country) {
    emit(state.copyWith(selectedCountry: country));
  }

  void updateAuthenticatorCode(String code) {
    final updatedCode = General.dirty(code);
    emit(
      state.copyWith(otp: updatedCode, status: Formz.validate([updatedCode])),
    );
  }

  void changePhoneNumber(String value) {
    final phoneNumber = PhoneNumber.dirty(value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([phoneNumber]),
      ),
    );
  }

  Future<void> sendOTP({bool isResend = false}) async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(sendOTPState: state.sendOTPState.toLoading()));

    try {
      await repository.sendOTP(state.phone);

      emit(state.copyWith(sendOTPState: state.sendOTPState.toLoaded()));
    } catch (error) {
      emit(
        state.copyWith(
          sendOTPState: state.sendOTPState.toFailure(error: error),
        ),
      );
    }
  }

  Future<void> verifyOTP() async {
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
        verifyOTPState: state.verifyOTPState.toLoading(),
      ),
    );
    try {
      await repository.verifyOTP(
        phoneNumber:
            '+${state.selectedCountry.phoneCode}${state.phoneNumber.value}',
        otp: state.otp.value,
      );
      emit(state.copyWith(verifyOTPState: state.verifyOTPState.toLoaded()));
    } on UnauthorisedException catch (_) {
      emit(
        state.copyWith(
          verifyOTPState: state.verifyOTPState.toFailure(error: 'Invalid otp'),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          verifyOTPState: state.verifyOTPState.toFailure(error: error),
        ),
      );
    }
  }
}
