
import 'package:formz/formz.dart';

enum NameBankError { empty }

class NameBank extends FormzInput<String, NameBankError> {

  const NameBank.pure() : super.pure('');

  const NameBank.dirty(super.value) : super.dirty();

  @override
  NameBankError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NameBankError.empty;
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == NameBankError.empty) return 'El campo es requerido';
    return null;
  }
}
