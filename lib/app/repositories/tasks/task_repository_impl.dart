import 'package:to_do_list/app/core/database/sqlite_connection_factory.dart';
import 'package:to_do_list/app/models/task_model.dart';
import 'package:to_do_list/app/repositories/tasks/tasks_repository.dart';

class TaskRepositoryImpl implements TasksRepository {

  final SqliteConnectionFactory _sqliteConnectionFactory;

  TaskRepositoryImpl({required SqliteConnectionFactory sqliteConnectionFactory}) : _sqliteConnectionFactory = sqliteConnectionFactory; 

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();

    await conn.rawQuery('''
      insert into "tasks" (id, description, date, complete) 
      values (${null}, '$description', '${date.toIso8601String()}', 0)
    ''');

    //* Conferindo legal
    // final res = await conn.rawQuery('Select * from tasks');
    // print(res);
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime dateBegin, DateTime dateEnd) async {
    final start = DateTime(dateBegin.year, dateBegin.month, dateBegin.day, 0, 0, 0);
    final end = DateTime(dateEnd.year, dateEnd.month, dateEnd.day, 0, 0, 0);

    final conn = await SqliteConnectionFactory().openConnection();
    final res = await conn.rawQuery(
      '''
        select *
        from tasks
        where date between ? and ?
        order by date
      ''', 
        [
          start.toIso8601String(),
          end.toIso8601String(),
        ],
      );

    final map = res.map((element) => TaskModel.loadFromDB(element)).toList();

    print('---------------------------- $res');
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~ $map');
    return map;
  }
  
  @override
  Future<void> checkOrUncheckTask(TaskModel task) async {
    final conn = await  SqliteConnectionFactory().openConnection();
    final done = task.done ? 1 : 0;
    await conn.rawUpdate('''
      update tasks 
      set complete = ? 
      where id = ?
    ''', [
      done, task.id
    ]);

  }
  
  @override
  Future<void> deleteTask(int id) async {
    final conn = await SqliteConnectionFactory().openConnection();
    await conn.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
  }



}