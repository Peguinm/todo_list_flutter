import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/models/filter_enum.dart';
import 'package:to_do_list/app/models/total_tasks_model.dart';
import 'package:to_do_list/app/modules/home/home_controller.dart';
import 'package:to_do_list/app/modules/home/widgets/home_week_filter.dart';
import 'package:to_do_list/app/modules/home/widgets/todo_list_filter.dart';

class HomeFilter extends StatelessWidget {
  const HomeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FILTROS', style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoListFilter(
                label: 'HOJE',
                filterEnum: FILTER_ENUM.TODAY,
                totalTasksModel:
                    TotalTasksModel(totalTasks: 10, totalTasksDone: 1),
                selected: context.select<HomeController, FILTER_ENUM>(
                        (value) => value.filterSelected) ==
                    FILTER_ENUM.TODAY,
              ),
              TodoListFilter(
                label: 'AMANHÃ',
                filterEnum: FILTER_ENUM.TOMORROW,
                totalTasksModel:
                    TotalTasksModel(totalTasks: 10, totalTasksDone: 10),
                selected: context.select<HomeController, FILTER_ENUM>(
                        (value) => value.filterSelected) ==
                    FILTER_ENUM.TOMORROW,
              ),
              TodoListFilter(
                label: 'SEMANA',
                filterEnum: FILTER_ENUM.WEEK,
                totalTasksModel:
                    TotalTasksModel(totalTasks: 10, totalTasksDone: 10),
                selected: context.select<HomeController, FILTER_ENUM>(
                        (value) => value.filterSelected) ==
                    FILTER_ENUM.WEEK,
              ),
            ],
          ),
        ),
        const HomeWeekFilter(),
      ],
    );
  }
}
