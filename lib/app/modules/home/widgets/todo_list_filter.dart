import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';

class TodoListFilter extends StatefulWidget {
  const TodoListFilter({super.key});

  @override
  State<TodoListFilter> createState() => _TodoListFilterState();
}

class _TodoListFilterState extends State<TodoListFilter> {
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
        color: ThemeDefinition.primaryColor,
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '5k Vbucks',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
          Text(
            'ONTEM',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          LinearProgressIndicator(
            backgroundColor: ThemeDefinition.secondaryColor,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            value: 0.0,
          )
        ],
      ),
    );
  }
}
