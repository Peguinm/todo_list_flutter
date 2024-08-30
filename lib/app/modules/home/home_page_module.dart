import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/modules/page_module.dart';
import 'package:to_do_list/app/modules/home/home_controller.dart';
import 'package:to_do_list/app/modules/home/home_page.dart';
import 'package:to_do_list/app/repositories/tasks/task_repository_impl.dart';
import 'package:to_do_list/app/repositories/tasks/tasks_repository.dart';
import 'package:to_do_list/app/services/tasks/task_service.dart';
import 'package:to_do_list/app/services/tasks/task_service_impl.dart';

class HomePageModule extends PageModule {
  HomePageModule()
      : super(providers: [
          Provider<TasksRepository>(
            create: (context) {
              return TaskRepositoryImpl(
                  sqliteConnectionFactory: context.read());
            },
          ),
          Provider<TaskService>(
            create: (context) {
              return TaskServiceImpl(tasksRepository: context.read());
            },
          ),
          ChangeNotifierProvider<HomeController>(
            create: (context) => HomeController(taskService: context.read()),
          )
        ], routes: {
          '/home': (context) => HomePage(),
        });
}
