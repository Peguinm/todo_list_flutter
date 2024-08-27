import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final checkVN = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey.shade400,
          )
        ],
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: EdgeInsets.all(7),
          titleAlignment: ListTileTitleAlignment.center,
          leading: ValueListenableBuilder<bool>(
            valueListenable: checkVN,
            builder: (_, value, __) {
              return Checkbox(
                activeColor: ThemeDefinition.primaryColor,
                value: value,
                onChanged: (value) {
                  checkVN.value = value ?? false;
                },
              );
            },
          ),
          title: Text(
            'Title',
            style: TextStyle(
              decoration: true ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            '20/12/2020',
            style: TextStyle(
              decoration: true ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
