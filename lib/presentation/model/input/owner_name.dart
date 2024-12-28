import 'package:formz/formz.dart';

enum OwnerNameError { empty }

class OwnerName extends FormzInput<String, OwnerNameError> {
  const OwnerName.pure() : super.pure('');

  const OwnerName.dirty(super.value) : super.dirty();

  @override
  OwnerNameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return OwnerNameError.empty;
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == OwnerNameError.empty) return 'El campo es requerido';
    return null;
  }
}
