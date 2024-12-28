import 'package:formz/formz.dart';

enum AliasError { empty }

class Alias extends FormzInput<String, AliasError> {

  const Alias.pure() : super.pure('');

  const Alias.dirty(super.value) : super.dirty();

  @override
  AliasError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return AliasError.empty;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == AliasError.empty) return 'El campo es requerido';
    return null;
  }
}
