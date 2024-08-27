import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text('DIA DA SEMANA', style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 10),
        Container(
          height: 100,
          child: DatePicker(
            DateTime(2024, 8, 25),
            locale: 'pt_BR',
            selectionColor: ThemeDefinition.primaryColor.withOpacity(.5),
            daysCount: 7,          
            monthTextStyle: const TextStyle(fontSize: 8),
            dateTextStyle: const TextStyle(fontSize: 13),
            dayTextStyle: const TextStyle(fontSize: 13),
          ),
        )
      ],
    );
  }
}
