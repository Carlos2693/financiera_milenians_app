import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:financiera_milenians_app/domain/entity/card.dart';
import 'package:financiera_milenians_app/domain/repository/local_storage_repository.dart';
import 'package:financiera_milenians_app/presentation/provider/storage/local_storage_provider.dart';

final cardProvider = StateNotifierProvider.autoDispose.family<CardNotifier, CardState, String>(
  (ref, cardId) {
    final localStorageRepository = ref.watch(localStorageRepositoryProvider);

    return CardNotifier(
      localStorageRepository: localStorageRepository,
      cardId: cardId,
    );
  }
);

class CardNotifier extends StateNotifier<CardState> {
  final LocalStorageRepository localStorageRepository;

  CardNotifier({
    required this.localStorageRepository,
    required String cardId,
  }) : super(CardState(id: cardId)) {
    loadCard();
  }

  CardModel newEmptyCard() {
    return CardModel(
      alias: '',
      ownerName: '',
      nameBank: '',
      cardNumber: '',
    );
  }

  Future<void> loadCard() async {
    try {
      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          cardModel: newEmptyCard()
        );
        return;
      }

      final cardId = int.tryParse(state.id);
      if (cardId != null) {
        // ! WIP Only for testing
        await Future.delayed(const Duration(milliseconds: 500));
        final card = await localStorageRepository.getCardModelById(cardId);

        state = state.copyWith(
          isLoading: false,
          cardModel: card,
        );
      }
    } catch (ex) {
      // 404 card not found
      print(ex);
    }
  }
}

class CardState {
  final String id;
  final CardModel? cardModel;
  final bool isLoading;
  final bool isSaving;

  CardState({
    required this.id,
    this.cardModel,
    this.isLoading = true,
    this.isSaving = false,
  });

  CardState copyWith({
    String? id,
    CardModel? cardModel,
    bool? isLoading,
    bool? isSaving,
  }) => CardState(
    id: id ?? this.id,
    cardModel: cardModel ?? this.cardModel,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );
}
