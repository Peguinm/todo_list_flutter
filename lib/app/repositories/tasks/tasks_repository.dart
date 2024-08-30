import 'package:to_do_list/app/models/task_model.dart';

abstract class TasksRepository {

  Future<void> save(DateTime date, String description);

  Future<List<TaskModel>> findByPeriod(DateTime dateBegin, DateTime dateEnd);

  Future<void> checkOrUncheckTask(TaskModel task);

  Future<void> deleteTask(int id);

}