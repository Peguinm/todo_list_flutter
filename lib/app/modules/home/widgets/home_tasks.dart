import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/models/filter_enum.dart';
import 'package:to_do_list/app/models/task_model.dart';
import 'package:to_do_list/app/modules/home/home_controller.dart';
import 'package:to_do_list/app/modules/home/widgets/task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Selector<HomeController, String>(
          selector: (context, controller) {
            return controller.filterSelected.description;
          },
          builder: (BuildContext context, String value, Widget? child) {
            return Text(value, style: Theme.of(context).textTheme.labelMedium);
          },
        ),
        const SizedBox(height: 10),
        Column(
          children: context
              .select<HomeController, List<TaskModel>>(
                  (controller) => controller.filteredTasks)
              .map((task) => Task(model: task,))
              .toList(),
        )
      ],
    );
  }
}
