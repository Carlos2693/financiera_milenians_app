
import 'package:financiera_milenians_app/domain/entity/card.dart';

abstract class LocalStorageRepository {
  Future<void> registerCard(CardModel cardModel);
  Future<List<CardModel>> loadCards();
}
