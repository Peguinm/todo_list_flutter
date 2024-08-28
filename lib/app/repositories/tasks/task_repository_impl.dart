import 'package:intl/intl.dart';
import 'package:to_do_list/app/core/database/sqlite_connection_factory.dart';
import 'package:to_do_list/app/repositories/tasks/tasks_repository.dart';

class TaskRepositoryImpl implements TasksRepository {

  final SqliteConnectionFactory _sqliteConnectionFactory;
  final DateFormat f = DateFormat('d/MM/y');

  TaskRepositoryImpl({required SqliteConnectionFactory sqliteConnectionFactory}) : _sqliteConnectionFactory = sqliteConnectionFactory; 

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();

    await conn.rawQuery('''
      insert into "tasks" (id, description, date, complete) 
      values (${null}, '$description', '${f.format(date)}', 0)
    ''');

    //* Conferindo legal
    // final res = await conn.rawQuery('Select * from tasks');
    // print(res);
  }



}