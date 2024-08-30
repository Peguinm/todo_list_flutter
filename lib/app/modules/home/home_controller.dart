import 'package:to_do_list/app/core/notifier/default_change_notifier.dart';
import 'package:to_do_list/app/models/filter_enum.dart';
import 'package:to_do_list/app/models/task_model.dart';
import 'package:to_do_list/app/models/total_tasks_model.dart';
import 'package:to_do_list/app/models/week_task_model.dart';
import 'package:to_do_list/app/services/tasks/task_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TaskService _taskService;

  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;

  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDate;
  DateTime? selecteDay;

  bool showDoneTasks = false;

  HomeController({required TaskService taskService})
      : _taskService = taskService;

  FILTER_ENUM filterSelected = FILTER_ENUM.TODAY;

  Future<void> loadTotalTasks() async {
    final totalTasksList = await Future.wait<dynamic>([
      _taskService.getToday(),
      _taskService.getTomorrow(),
      _taskService.getWeek(),
    ]);

    final todayTasks = totalTasksList[0] as List<TaskModel>;
    final tomorrowTasks = totalTasksList[1] as List<TaskModel>;
    final weekTasks = totalTasksList[2] as WeekTaskModel;

    todayTotalTasks = TotalTasksModel(
      totalTasks: todayTasks.length,
      totalTasksDone: todayTasks.where((e) => e.done).length,
    );
    tomorrowTotalTasks = TotalTasksModel(
      totalTasks: tomorrowTasks.length,
      totalTasksDone: tomorrowTasks.where((e) => e.done).length,
    );
    weekTotalTasks = TotalTasksModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksDone: weekTasks.tasks.where((e) => e.done).length,
    );

    notifyListeners();
  }

  Future<void> findTasks({required FILTER_ENUM filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();

    List<TaskModel> tasks;

    switch (filter) {
      case FILTER_ENUM.TODAY:
        tasks = await _taskService.getToday();
        break;

      case FILTER_ENUM.TOMORROW:
        tasks = await _taskService.getTomorrow();
        break;

      case FILTER_ENUM.WEEK:
        final weekModel = await _taskService.getWeek();
        tasks = weekModel.tasks;
        initialDate = weekModel.startDate;
        break;
    }

    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == FILTER_ENUM.WEEK) {
      if (selecteDay != null) {
        filterByDay(selecteDay!);
      } else if (initialDate != null) {
        filterByDay(initialDate!);
      }
    } else {
      selecteDay = null;
    }

    if (!showDoneTasks) {
      filteredTasks = filteredTasks.where((e) => !e.done).toList();
    }

    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime day) {
    selecteDay = day;
    filteredTasks = allTasks.where((e) => e.date == selecteDay).toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await loadTotalTasks();
    await findTasks(filter: filterSelected);
    notifyListeners();
  }

  Future<void> checkOrUncheckTask(TaskModel task) async {
    resetState();
    notifyListeners();

    final taskUpdated = task.copyWith(done: !task.done);
    await _taskService.checkOrUncheckTask(taskUpdated);

    refreshPage();
  }

  void showOrHideDoneTasks() {
    showDoneTasks = !showDoneTasks;
    refreshPage();
  }

  int todoTasksByFilter(FILTER_ENUM filter) {
    switch(filter) {
      case FILTER_ENUM.TODAY:
        return ((todayTotalTasks?.totalTasks ?? 0) - (todayTotalTasks?.totalTasksDone ?? 0));
      case FILTER_ENUM.TOMORROW:
        return ((tomorrowTotalTasks?.totalTasks ?? 0) - (tomorrowTotalTasks?.totalTasksDone ?? 0));
      case FILTER_ENUM.WEEK:
        return ((weekTotalTasks?.totalTasks ?? 0) - (weekTotalTasks?.totalTasksDone ?? 0));
    }
  }

  Future<void> deleteTaskAndRefresh(int id) async {
    await _taskService.deleteTask(id);
    refreshPage();
  }
}
