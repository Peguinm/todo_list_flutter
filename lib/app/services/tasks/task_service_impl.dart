import 'package:to_do_list/app/models/task_model.dart';
import 'package:to_do_list/app/models/week_task_model.dart';
import 'package:to_do_list/app/repositories/tasks/tasks_repository.dart';
import 'package:to_do_list/app/services/tasks/task_service.dart';

class TaskServiceImpl implements TaskService {
  
  final TasksRepository _tasksRepository;

  TaskServiceImpl({required TasksRepository tasksRepository}) : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) {
    return _tasksRepository.save(date, description);
  }
  
  @override
  Future<List<TaskModel>> getToday() async {
    final date = DateTime.now();
    return await _tasksRepository.findByPeriod(date, date);
  }
  
  @override
  Future<List<TaskModel>> getTomorrow() async {
    final date = DateTime.now().add(const Duration(days: 1));
    return await _tasksRepository.findByPeriod(date, date);
  }
  
  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    final date = DateTime(today.year, today.month, today.day, 0, 0, 0);
    final currentWeekDay = date.weekday;
    final dateBegin = date.subtract(Duration(days: (currentWeekDay - 1)));
    final dateEnd = dateBegin.add(const Duration(days: 7));

    final tasks = await _tasksRepository.findByPeriod(dateBegin, dateEnd);
    return WeekTaskModel(startDate: dateBegin, endDate: dateEnd, tasks: tasks);
  }
  
  @override
  Future<void> checkOrUncheckTask(TaskModel task) {
    return _tasksRepository.checkOrUncheckTask(task);
  }
  
  @override
  Future<void> deleteTask(int id) {
    return _tasksRepository.deleteTask(id);
  }
  
}