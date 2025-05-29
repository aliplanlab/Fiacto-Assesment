import 'package:common/common.dart';

enum NonZeroPositiveIntValidationError { nonPositive }

class NonZeroPositiveInt
    extends FormsInput<String, NonZeroPositiveIntValidationError> {
  const NonZeroPositiveInt.pure([super.value = '']) : super.pure();
  const NonZeroPositiveInt.dirty([super.value = '']) : super.dirty();

  @override
  NonZeroPositiveIntValidationError? validator(String value) {
    return (int.tryParse(value) ?? 0) <= 0
        ? NonZeroPositiveIntValidationError.nonPositive
        : null;
  }
}

class NonZeroPositiveIntOptional
    extends FormsInput<String, NonZeroPositiveIntValidationError> {
  const NonZeroPositiveIntOptional.pure([super.value = '']) : super.pure();
  const NonZeroPositiveIntOptional.dirty([super.value = '']) : super.dirty();

  @override
  NonZeroPositiveIntValidationError? validator(String value) {
    return value.isEmpty
        ? null
        : (int.tryParse(value) ?? 0) <= 0
            ? NonZeroPositiveIntValidationError.nonPositive
            : null;
  }
}

extension NonZeroPositiveIntFromString on String {
  NonZeroPositiveInt toNonZeroPositiveInt() => NonZeroPositiveInt.dirty(this);
  NonZeroPositiveInt toPureNonZeroPositiveInt() =>
      NonZeroPositiveInt.pure(this);

  NonZeroPositiveIntOptional toNonZeroPositiveIntOptional() =>
      NonZeroPositiveIntOptional.dirty(this);
  NonZeroPositiveIntOptional toPureNonZeroPositiveIntOptional() =>
      NonZeroPositiveIntOptional.pure(this);
}
