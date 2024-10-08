import 'package:to_do_list/app/models/task_model.dart';
import 'package:to_do_list/app/models/week_task_model.dart';

abstract class TaskService {

  Future<void> save(DateTime date, String description);

  Future<List<TaskModel>> getToday();
  Future<List<TaskModel>> getTomorrow();
  Future<WeekTaskModel> getWeek();
  Future<void> checkOrUncheckTask(TaskModel task);
  Future<void> deleteTask(int id);

}