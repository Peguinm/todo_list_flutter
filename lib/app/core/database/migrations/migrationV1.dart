
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/app/core/database/migrations/migration.dart';

class MigrationV1 implements Migration {

  @override
  void create(Batch batch) {

    batch.rawQuery(
      '''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description VARCHAR(500) NOT NULL,
        date DATETIME,
        complete INT
      )
      '''
    );
    
  }

  @override
  void update(batch) {}

}