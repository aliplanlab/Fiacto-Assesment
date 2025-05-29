import 'package:common/common.dart';

enum GeneralValidationError { empty }

class General extends FormsInput<String, GeneralValidationError> {
  const General.pure([super.value = '']) : super.pure();
  const General.dirty([super.value = '']) : super.dirty();

  @override
  GeneralValidationError? validator(String value) {
    return value.trim().isEmpty ? GeneralValidationError.empty : null;
  }

  bool get isEmpty => error == GeneralValidationError.empty;

  bool get isNotEmpty => !isEmpty;
}

extension GeneralFromString on String {
  General toGeneral() => General.dirty(this);

  General toOptionalGeneral() =>
      isBlank ? trim().toPureGeneral() : trim().toGeneral();

  General toPureGeneral() => General.pure(this);
}
