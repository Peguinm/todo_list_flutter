
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/app/core/database/migrations/migration.dart';

class MigrationV1 implements Migration {

  @override
  void create(Batch batch) {

    batch.query(
      '''
      CREATE TABLE tasks(
        id INT PRIMARY KEY AUTOINCREMENT,
        description VARCHAR(500) NOT NULL,
        date DATETIME,
        complete INT,
      )
      '''
    );
    
  }

  @override
  void update(batch) {}

}