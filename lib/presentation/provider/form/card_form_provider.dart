import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:formz/formz.dart';

import 'package:financiera_milenians_app/domain/entity/card.dart';
import 'package:financiera_milenians_app/presentation/model/input/inputs.dart';
import 'package:financiera_milenians_app/presentation/provider/cards_provider.dart';

final cardFormProvider = StateNotifierProvider.autoDispose.family<CardFormNotifier, CardFormState, CardModel>(
  (ref, cardModel) {

    final registerCardCallback = ref.watch(cardsProvider.notifier).registerCard;

    return CardFormNotifier(
      cardModel: cardModel,
      onSubmitCallback: registerCardCallback,
    );
  }
);

class CardFormNotifier extends StateNotifier<CardFormState> {
  final Future<bool> Function(Map<String, dynamic> cardLike)? onSubmitCallback;

  CardFormNotifier({
    required CardModel cardModel,
    this.onSubmitCallback,
  }): super(
    CardFormState(
      id: '${cardModel.id}',
      alias: Alias.dirty(cardModel.alias),
      cardNumber: CardNumber.dirty(cardModel.cardNumber),
      nameBank: NameBank.dirty(cardModel.nameBank),
      ownerName: OwnerName.dirty(cardModel.ownerName),
    )
  );

  Future<void> onFormSubmit() async {
    _touchedEverything();
    if (!state.isFormValid) return;

    if (onSubmitCallback == null) return;

    final cardLike = {
      'id' : state.id == 'new' ? null : state.id,
      'alias' : state.alias.value,
      'cardNumber' : state.cardNumber.value,
      'nameBank' : state.nameBank.value,
      'ownerName' : state.ownerName.value,
    };

    try {
      await onSubmitCallback!(cardLike);
      state = state.copyWith(
        cardFormStatus: CardFormStatus.saved
      );
    } catch (ex) {
      state = state.copyWith(
        cardFormStatus: CardFormStatus.saved
      );
    }
  }

  void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Alias.dirty(state.alias.value),
        CardNumber.dirty(state.cardNumber.value),
        NameBank.dirty(state.nameBank.value),
        OwnerName.dirty(state.ownerName.value),
      ])
    );
  }

  void onAliasChanged(String value) {
    state = state.copyWith(
      alias: Alias.dirty(value),
      isFormValid: Formz.validate([
        Alias.dirty(value),
        CardNumber.dirty(state.cardNumber.value),
        NameBank.dirty(state.nameBank.value),
        OwnerName.dirty(state.ownerName.value),
      ])
    );
  }

  void onCardNumberChanged(String value) {
    state = state.copyWith(
      cardNumber: CardNumber.dirty(value),
      isFormValid: Formz.validate([
        Alias.dirty(state.alias.value),
        CardNumber.dirty(value),
        NameBank.dirty(state.nameBank.value),
        OwnerName.dirty(state.ownerName.value),
      ])
    );
  }

  void onNameBankChanged(String value) {
    state = state.copyWith(
      nameBank: NameBank.dirty(value),
      isFormValid: Formz.validate([
        Alias.dirty(state.alias.value),
        CardNumber.dirty(state.cardNumber.value),
        NameBank.dirty(value),
        OwnerName.dirty(state.ownerName.value),
      ])
    );
  }

  void onOwnerNameChanged(String value) {
    state = state.copyWith(
      ownerName: OwnerName.dirty(value),
      isFormValid: Formz.validate([
        Alias.dirty(state.alias.value),
        CardNumber.dirty(state.cardNumber.value),
        NameBank.dirty(state.nameBank.value),
        OwnerName.dirty(value),
      ])
    );
  }
}

enum CardFormStatus { waiting, saved, error }

class CardFormState {
  final CardFormStatus cardFormStatus;
  final bool isPosted;
  final bool isFormValid;
  final String? id;
  final Alias alias;
  final CardNumber cardNumber;
  final NameBank nameBank;
  final OwnerName ownerName;

  CardFormState({
    this.cardFormStatus = CardFormStatus.waiting,
    this.isPosted = false,
    this.isFormValid = false,
    this.id,
    this.alias = const Alias.dirty(''),
    this.cardNumber = const CardNumber.dirty(''),
    this.nameBank = const NameBank.dirty(''),
    this.ownerName = const OwnerName.dirty(''),
  });

  CardFormState copyWith({
    CardFormStatus? cardFormStatus,
    bool? isPosted,
    bool? isFormValid,
    String? id,
    Alias? alias,
    CardNumber? cardNumber,
    NameBank? nameBank,
    OwnerName? ownerName,
  }) => CardFormState(
    cardFormStatus: cardFormStatus ?? this.cardFormStatus,
    isPosted: isPosted ?? this.isPosted,
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    alias: alias ?? this.alias,
    cardNumber: cardNumber ?? this.cardNumber,
    nameBank: nameBank ?? this.nameBank,
    ownerName: ownerName ?? this.ownerName,
  );
}
