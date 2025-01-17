import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:financiera_milenians_app/domain/entity/card.dart';
import 'package:financiera_milenians_app/domain/repository/local_storage_repository.dart';
import 'package:financiera_milenians_app/presentation/provider/storage/local_storage_provider.dart';

final cardsProvider =
  StateNotifierProvider<CardStorageNotifier, List<CardModel>>((ref) {
    final localStorageRepository = ref.watch(localStorageRepositoryProvider);
    return CardStorageNotifier(localStorageRepository: localStorageRepository);
  }
);

class CardStorageNotifier extends StateNotifier<List<CardModel>> {

  final LocalStorageRepository localStorageRepository;

  CardStorageNotifier({required this.localStorageRepository}) : super([]);

  Future<List<CardModel>> loadCards() async {
    final cards = await localStorageRepository.loadCards();

    state = [...state, ...cards];

    return cards;
  }

  Future<void> deleteCard(int id) async {
    final result = await localStorageRepository.deleteCard(id);
    if (result) {
      final currentList = state.toList();
      currentList.removeWhere((item) => item.id == id);
      state = currentList;
    }
  }

  Future<void> registerCard(Map<String, dynamic> cardLike) async {
    final cardModel = CardModel(
      alias: cardLike['alias'],
      cardNumber: cardLike['cardNumber'],
      nameBank: cardLike['nameBank'],
      ownerName: cardLike['ownerName'],
    );
    final cardId = await localStorageRepository.registerCard(cardModel);

    if (cardId != null) {
      final isCardInList = state.any((item) => item.id == cardId);

      if (!isCardInList) {
        state = [...state, cardModel];
        return;
      }

      state.map((item) {
        if (item.id == cardId) {
          return cardModel.copyWith(id: cardId);
        } else {
          return item;
        }
      }).toList();

      return;
    }
    return;
  }
}
