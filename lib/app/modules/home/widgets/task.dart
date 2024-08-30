import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/models/task_model.dart';
import 'package:to_do_list/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel model;

  const Task({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey.shade400,
          )
        ],
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(7),
          titleAlignment: ListTileTitleAlignment.center,
          leading: Checkbox(
            activeColor: ThemeDefinition.primaryColor,
            value: model.done,
            onChanged: (value) {
              context.read<HomeController>().checkOrUncheckTask(model);
            },
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Excluir Tarefa'),
                    content: const Text('Tem certeza de que deseja excluir essa tarefa?'),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3.0))
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {                          
                          provider.deleteTaskAndRefresh(model.id);
                          Navigator.of(context).pop();
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(Colors.red),
                        ),
                        child: const Text('Excluir', style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          title: Text(
            model.description,
            style: TextStyle(
              decoration: model.done ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            DateFormat('d/MM/y').format(model.date),
            style: TextStyle(
              decoration: model.done ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
