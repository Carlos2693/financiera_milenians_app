import 'package:formz/formz.dart';

enum CardNumberError { empty, length }

class CardNumber extends FormzInput<String, CardNumberError> {

  const CardNumber.pure() : super.pure('');

  const CardNumber.dirty(super.value) : super.dirty();

  @override
  CardNumberError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return CardNumberError.empty;
    if (value.length != 16) return CardNumberError.length;
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == CardNumberError.empty) return 'El campo es requerido';
    if (displayError == CardNumberError.length) return 'Debes usar 16 dígitos}';
    return null;
  }
}
