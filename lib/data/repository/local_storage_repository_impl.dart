import 'package:financiera_milenians_app/domain/datasource/local_storage_datasource.dart';
import 'package:financiera_milenians_app/domain/entity/card.dart';
import 'package:financiera_milenians_app/domain/repository/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {

  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<List<CardModel>> loadCards() {
    return datasource.loadCards();
  }

  @override
  Future<void> registerCard(CardModel cardModel) {
    return datasource.registerCard(cardModel);
  }
}
