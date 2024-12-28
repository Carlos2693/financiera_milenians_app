import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:formz/formz.dart';

import 'package:financiera_milenians_app/presentation/model/input/inputs.dart';
import 'package:financiera_milenians_app/domain/repository/card_provider.dart';

final cardFormProvider =
  StateNotifierProvider.autoDispose<CardFormNotifier, CardFormState>((ref) {
    final cardFormCallback = ref.watch(cardsProvider.notifier).registerCard;
    
    return CardFormNotifier(cardFormCallback: cardFormCallback);
  });

//! Notifier class
class CardFormNotifier extends StateNotifier<CardFormState> {
  
  final Function(String, String, String, String) cardFormCallback;

  CardFormNotifier({
    required this.cardFormCallback,
  }) : super(CardFormState());

  onAliasChange(String value) {
    final newAlias = Alias.dirty(value);
    state = state.copyWith(
      alias: newAlias,
      isValid: Formz.validate(
        [newAlias, state.cardNumber, state.nameBank, state.ownerName]
      )
    );
  }
  
  onCardNumberChange(String value) {
    final newCardNumber = CardNumber.dirty(value);
    state = state.copyWith(
      cardNumber: newCardNumber,
      isValid: Formz.validate(
        [state.alias, newCardNumber, state.nameBank, state.ownerName]
      )
    );
  }

  onNameBankChange(String value) {
    final newNameBank = NameBank.dirty(value);
    state = state.copyWith(
      nameBank: newNameBank,
      isValid: Formz.validate(
        [state.alias, state.cardNumber, newNameBank, state.ownerName]
      )
    );
  }

  onOwnerNameChange(String value) {
    final newOwnerName = OwnerName.dirty(value);
    state = state.copyWith(
      ownerName: newOwnerName,
      isValid: Formz.validate(
        [state.alias, state.cardNumber, state.nameBank, newOwnerName]
      )
    );
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) {
      return;
    }

    await cardFormCallback(
      state.alias.value,
      state.ownerName.value,
      state.nameBank.value,
      state.cardNumber.value,
    );
    state = state.copyWith(
      status: CardFormStatus.saved
    );
  }

  _touchEveryField() {
    final alias = Alias.dirty(state.alias.value);
    final cardNumber = CardNumber.dirty(state.cardNumber.value);
    final nameBank = NameBank.dirty(state.nameBank.value);
    final ownerName = OwnerName.dirty(state.ownerName.value);

    state = state.copyWith(
      isFormPosted: true,
      alias: alias,
      cardNumber: cardNumber,
      nameBank: nameBank,
      ownerName: ownerName,
      isValid: Formz.validate([alias, cardNumber, nameBank, ownerName])
    );
  }
}

enum CardFormStatus { waiting, saved, error }

//! State provider
class CardFormState {
  final CardFormStatus status;
  final bool isFormPosted;
  final bool isValid;
  final Alias alias;
  final CardNumber cardNumber;
  final NameBank nameBank;
  final OwnerName ownerName;

  CardFormState({
    this.status = CardFormStatus.waiting,
    this.isFormPosted = false,
    this.isValid = false,
    this.alias = const Alias.pure(),
    this.cardNumber = const CardNumber.pure(),
    this.nameBank = const NameBank.pure(),
    this.ownerName = const OwnerName.pure(),
  });

  CardFormState copyWith({
    CardFormStatus? status,
    bool? isFormPosted,
    bool? isValid,
    Alias? alias,
    CardNumber? cardNumber,
    NameBank? nameBank,
    OwnerName? ownerName,
  }) => CardFormState(
    status: status ?? this.status,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    alias: alias ?? this.alias,
    cardNumber: cardNumber ?? this.cardNumber,
    nameBank: nameBank ?? this.nameBank,
    ownerName: ownerName ?? this.ownerName,
  );
}
