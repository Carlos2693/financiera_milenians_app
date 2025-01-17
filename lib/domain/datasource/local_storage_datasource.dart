import 'package:financiera_milenians_app/domain/entity/card.dart';

abstract class LocalStorageDatasource {
  Future<int?> registerCard(CardModel cardModel);
  Future<List<CardModel>> loadCards();
  Future<CardModel?> getCardModelById(int cardId);
}
