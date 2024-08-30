import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/models/filter_enum.dart';
import 'package:to_do_list/app/modules/home/home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
        (controller) => controller.filterSelected == FILTER_ENUM.WEEK,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('DIA DA SEMANA', style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 10),
          Container(
            height: 100,
            child: Selector<HomeController, DateTime>(
              selector: (context, controller) =>
                  controller.initialDate ?? DateTime.now(),
              builder: (_, value, __) {
                return DatePicker(
                  value,
                  initialSelectedDate: value,
                  locale: 'pt_BR',
                  selectionColor: ThemeDefinition.primaryColor.withOpacity(.5),
                  daysCount: 7,
                  monthTextStyle: const TextStyle(fontSize: 8),
                  dateTextStyle: const TextStyle(fontSize: 13),
                  dayTextStyle: const TextStyle(fontSize: 13),
                  onDateChange: (day) {
                    context.read<HomeController>().filterByDay(day);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
