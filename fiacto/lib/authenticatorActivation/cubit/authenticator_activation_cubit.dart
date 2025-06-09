import 'package:bloc/bloc.dart';
import 'package:common/http/data_state.dart';
import 'package:common/http/http_exception.dart';
import 'package:common/validators/general.dart';
import 'package:equatable/equatable.dart';
import 'package:fiacto/authenticatorActivation/repository/Model/authenticator_model.dart';
import 'package:fiacto/authenticatorActivation/repository/authenticator_repo.dart';
import 'package:formz/formz.dart';

part 'authenticator_activation_state.dart';

class AuthenticatorActivationCubit extends Cubit<AuthenticatorActivationState> {
  AuthenticatorActivationCubit({required this.repository, required this.id})
    : super(AuthenticatorActivationState());
  final AuthenticatorRepository repository;
  final String id;

  void isValidated() {
    emit(state.copyWith(status: FormzStatus.valid));
  }

  void updateAuthenticatorCode(String code) {
    final updatedCode = General.dirty(code);
    emit(
      state.copyWith(code: updatedCode, status: Formz.validate([updatedCode])),
    );
  }

  Future<void> updateMFAStatus() async {
    emit(
      state.copyWith(
        builderUpdateDataState: state.builderUpdateDataState.toLoading(),
      ),
    );
    try {
      await repository.updateBuilder(id);
      emit(
        state.copyWith(
          builderUpdateDataState: state.builderUpdateDataState.toLoaded(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          builderUpdateDataState: state.builderUpdateDataState.toFailure(
            error: e,
          ),
        ),
      );
    }
  }

  // this authenticator qr image for sign up
  Future<void> getQRCodeImage() async {
    emit(state.copyWith(qrImageState: state.qrImageState.toLoading()));
    try {
      final data = await repository.authenticatorQRImage();
      emit(
        state.copyWith(qrImageState: state.qrImageState.toLoaded(data: data)),
      );
    } catch (error) {
      emit(
        state.copyWith(
          qrImageState: state.qrImageState.toFailure(error: error),
        ),
      );
    }
  }

  Future<void> getSecretKey() async {
    emit(state.copyWith(secretKeyState: state.secretKeyState.toLoading()));
    try {
      final data = await repository.authenticatorSecretKey();

      emit(
        state.copyWith(
          secretKeyState: state.secretKeyState.toLoaded(data: data),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          secretKeyState: state.secretKeyState.toFailure(error: error),
        ),
      );
    }
  }

  Future<void> veridyAuthenticatorCode() async {
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
        activationDataState: state.activationDataState.toLoading(),
      ),
    );

    try {
      final data = await repository.verifyAuthCode(state.code.value);
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          activationDataState: state.activationDataState.toLoaded(data: data),
        ),
      );
    } on InternalServerException catch (error) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          activationDataState: state.activationDataState.toFailure(
            error: error,
          ),
        ),
      );
    } on BadRequestException catch (_) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          activationDataState: state.activationDataState.toFailure(
            error: 'Invalid Code',
          ),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          activationDataState: state.activationDataState.toFailure(
            error: error,
          ),
        ),
      );
    }
  }
}
