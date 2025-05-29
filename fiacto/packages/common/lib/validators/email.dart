import 'package:common/common.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormsInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    final bool emailValid = RegExp(
      r'^[a-zA-Z0-9.\+\-]+@[a-zA-Z0-9.\+\-]+\.[a-zA-Z]+$',
    ).hasMatch(value.trim());
    if (value.trim().isEmpty) {
      return EmailValidationError.empty;
    } else if (!emailValid) {
      return EmailValidationError.invalid;
    } else {
      return null;
    }
  }
}
