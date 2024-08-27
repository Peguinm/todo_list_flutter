import 'package:flutter/material.dart';
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
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoListFilter(),
              TodoListFilter(),
              TodoListFilter(),
              TodoListFilter(),
              TodoListFilter(),
            ],
          ),
        ),
        const HomeWeekFilter(),
      ],
    );
  }
}
