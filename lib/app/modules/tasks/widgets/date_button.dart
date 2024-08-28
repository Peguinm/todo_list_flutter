import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/modules/tasks/task_create_controller.dart';

class DateButton extends StatelessWidget {
  DateButton({super.key});

  final dateFormat = DateFormat('dd/MM/y');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final date = DateTime.now();

        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(date.year),
          lastDate: DateTime(date.year + 10),
        );

        context.read<TaskCreateController>().selectedDate = selectedDate;
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
          border: Border.all(color: ThemeDefinition.primaryColor, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.today,
              color: ThemeDefinition.primaryColor,
            ),
            Selector<TaskCreateController, DateTime?>(
              selector: (context, controller) => controller.selectedDate,
              builder: (_, selectedDate, __) {
                if (selectedDate != null) {
                  return Text(
                    ' ${dateFormat.format(selectedDate)}',
                    style: const TextStyle(color: ThemeDefinition.primaryColor),
                  );
                } else {
                  return const Text(
                    'SELECIONE UMA DATA',
                    style: TextStyle(color: ThemeDefinition.primaryColor),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
