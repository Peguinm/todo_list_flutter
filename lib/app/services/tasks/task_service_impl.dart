import 'package:to_do_list/app/repositories/tasks/tasks_repository.dart';
import 'package:to_do_list/app/services/tasks/task_service.dart';

class TaskServiceImpl implements TaskService {
  
  final TasksRepository _tasksRepository;

  TaskServiceImpl({required TasksRepository tasksRepository}) : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) {
    return _tasksRepository.save(date, description);
  }

}