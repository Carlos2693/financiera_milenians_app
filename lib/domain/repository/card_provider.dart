import 'package:financiera_milenians_app/presentation/provider/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:financiera_milenians_app/domain/entity/card.dart';
import 'package:financiera_milenians_app/domain/repository/local_storage_repository.dart';

final cardsProvider =
  StateNotifierProvider<CardStorageNotifier, Map<String, CardModel>>((ref) {
    final localStorageRepository = ref.watch(localStorageRepositoryProvider);
    return CardStorageNotifier(localStorageRepository: localStorageRepository);
  }
);

class CardStorageNotifier extends StateNotifier<Map<String, CardModel>> {

  final LocalStorageRepository localStorageRepository;

  CardStorageNotifier({required this.localStorageRepository}) : super({});

  Future<List<CardModel>> loadCards() async {
    final cards = await localStorageRepository.loadCards();

    final tempCardsMap = <String, CardModel>{};
    for (final card in cards) {
      tempCardsMap[card.cardNumber] = card;
    }

    state = {...state, ...tempCardsMap};

    return cards;
  }

  Future<void> registerCard(CardModel cardModel) async {
    await localStorageRepository.registerCard(cardModel);

    state = {...state, cardModel.cardNumber: cardModel};
  }
}
