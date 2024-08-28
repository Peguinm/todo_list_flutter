import 'package:to_do_list/app/core/notifier/default_change_notifier.dart';
import 'package:to_do_list/app/services/tasks/task_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  final TaskService _taskService;
  DateTime? _selectedDate;

  TaskCreateController({required TaskService taskService})
      : _taskService = taskService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(DateTime? date, String text) async {
    try {      
      showLoadingAndResetState();
      notifyListeners();

      if (date != null) {
        await _taskService.save(date, text);
        success();
      } else {
        setError('Data da task não selecionada');
      }
    } on Exception catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao cadastrar task');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
