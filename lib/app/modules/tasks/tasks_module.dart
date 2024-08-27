import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/modules/page_module.dart';
import 'package:to_do_list/app/modules/tasks/task_create_controller.dart';
import 'package:to_do_list/app/modules/tasks/task_create_page.dart';

class TasksModule extends PageModule {

  TasksModule() : super(
    providers: [
      ChangeNotifierProvider(create: (context) => TaskCreateController())
    ],
    routes: {
      '/task/create': (BuildContext context) => TaskCreatePage(controller: context.read(),),
    },
  );

}