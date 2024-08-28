import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/models/filter_enum.dart';
import 'package:to_do_list/app/models/total_tasks_model.dart';

class TodoListFilter extends StatelessWidget {
  final String label;
  final FILTER_ENUM filterEnum;
  final TotalTasksModel? totalTasksModel;
  final bool selected;

  const TodoListFilter({
    super.key,
    required this.label,
    required this.filterEnum,
    this.totalTasksModel,
    required this.selected
  });

  double _getDonePercentage() {
    final doneTasks = totalTasksModel?.totalTasksDone ?? 0;
    final totalTasks = totalTasksModel?.totalTasks ?? 1;

    return doneTasks / totalTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: selected ? ThemeDefinition.primaryColor : Colors.grey.shade100,
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'TASK\'S ${totalTasksModel?.totalTasks ?? 0}',
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey,
              fontSize: 10,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),                    
          TweenAnimationBuilder(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInCubic,
            tween: Tween(
              begin: 0.0,
              end: _getDonePercentage(),
            ),
            builder: (context, value, child) {
              return LinearProgressIndicator(
              backgroundColor: selected ? ThemeDefinition.secondaryColor : Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(selected ? Colors.white : Colors.grey),
              value: value,
            );
            },            
          )
        ],
      ),
    );
  }
}
