import 'package:financiera_milenians_app/domain/entity/card.dart';
import 'package:isar/isar.dart';

import 'package:financiera_milenians_app/domain/datasource/local_storage_datasource.dart';
import 'package:path_provider/path_provider.dart';


class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [CardModelSchema],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<List<CardModel>> loadCards() async {
    final isar = await db;
    return isar.cardModels.where().findAll();
  }

  @override
  Future<void> registerCard(CardModel cardModel) async {
    final isar = await db;
    isar.writeTxnSync(
      ()=> isar.cardModels.putSync(cardModel)
    );
  }
}
