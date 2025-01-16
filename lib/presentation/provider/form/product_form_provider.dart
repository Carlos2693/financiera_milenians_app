import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:financiera_milenians_app/domain/entity/card.dart';
import 'package:financiera_milenians_app/presentation/model/input/inputs.dart';

final cardFormProvider = StateNotifierProvider.autoDispose.family<CardFormNotifier, CardFormState, CardModel>(
  (ref, cardModel) {

    return CardFormNotifier(
      cardModel: cardModel,
    );
  }
);

class CardFormNotifier extends StateNotifier<CardFormState> {

  CardFormNotifier({
    required CardModel cardModel,
  }): super(
    CardFormState(
      id: '${cardModel.id}',
      alias: Alias.dirty(cardModel.alias),
      cardNumber: CardNumber.dirty(cardModel.cardNumber),
      nameBank: NameBank.dirty(cardModel.nameBank),
      ownerName: OwnerName.dirty(cardModel.ownerName),
    )
  );
}

class CardFormState {
  final bool isFormValid;
  final String? id;
  final Alias alias;
  final CardNumber cardNumber;
  final NameBank nameBank;
  final OwnerName ownerName;

  CardFormState({
    this.isFormValid = false,
    this.id,
    this.alias = const Alias.dirty(''),
    this.cardNumber = const CardNumber.dirty(''),
    this.nameBank = const NameBank.dirty(''),
    this.ownerName = const OwnerName.dirty(''),
  });

  CardFormState copyWith({
    bool? isFormValid,
    String? id,
    Alias? alias,
    CardNumber? cardNumber,
    NameBank? nameBank,
    OwnerName? ownerName,
  }) => CardFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    alias: alias ?? this.alias,
    cardNumber: cardNumber ?? this.cardNumber,
    nameBank: nameBank ?? this.nameBank,
    ownerName: ownerName ?? this.ownerName,
  );
}
