import 'package:financiera_milenians_app/domain/card.dart';

abstract class LocalStorageDatasource {
  Future<void> registerCard(CardModel cardModel);
  Future<List<CardModel>> loadCards();
}
