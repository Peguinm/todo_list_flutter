import 'package:to_do_list/app/core/database/migrations/migration.dart';
import 'package:to_do_list/app/core/database/migrations/migrationV1.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigratios() {
    return [
      MigrationV1(),
    ];
  }

  List<Migration> getUpdateMigrations(int oldVersion) {
    final List<Migration> listMigrations = [];

    //! Lógica de upgrade

    return listMigrations;
  }
}
