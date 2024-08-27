import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';

class TaskCreateTextInput extends StatelessWidget {
  const TaskCreateTextInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ThemeDefinition.primaryColor,
      decoration: const InputDecoration(
        hintText: 'Titulo da tarefa',
        //
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          borderSide: BorderSide(
            color: ThemeDefinition.primaryColor,
          ),
        ),
        //
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          borderSide: BorderSide(
            color: ThemeDefinition.primaryColor,
          ),
        ),
      ),
    );
  }
}
