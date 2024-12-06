import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:financiera_milenians_app/data/datasource/isar_datasource.dart';
import 'package:financiera_milenians_app/data/repository/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(
    IsarDatasource(),
  );
});
