import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/notifier/default_change_notifier.dart';
import 'package:to_do_list/app/core/notifier/default_listener.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/core/widgets/todo_list_text_input.dart';
import 'package:to_do_list/app/modules/tasks/task_create_controller.dart';
import 'package:to_do_list/app/modules/tasks/widgets/date_button.dart';
import 'package:validatorless/validatorless.dart';

class TaskCreatePage extends StatefulWidget {
  final TaskCreateController _controller;

  TaskCreatePage({super.key, required TaskCreateController controller})
      : _controller = controller;

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final _descriptionEC = TextEditingController();

  final _formState = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    DefaultListener(
      changeNotifier: widget._controller,
    ).listener(
      context: context,
      succesCallback: (changeNotifer, listener) {        
        print('---------------------------- SUCCESS');
        Navigator.of(context).pop(context);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Cancelar criação?'),
                  content: const Text(
                      'Tem certeza de que deseja cancelar a criação?'),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).popUntil(
                              ModalRoute.withName('/home'),
                            );
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll<Color>(Colors.red),
                          ),
                          child: const Text(
                            'Sim',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Não'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.close,
              color: ThemeDefinition.primaryColor,
              size: 35,
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 100,
        child: FloatingActionButton(
          onPressed: () {
            final bool isValid = _formState.currentState?.validate() ?? false;

            if (isValid) {
              widget._controller.save(context.read<TaskCreateController>().selectedDate, _descriptionEC.text);
            }

          },
          backgroundColor: ThemeDefinition.primaryColor,
          child: const FittedBox(
            fit: BoxFit.fill,
            child: Row(
              children: [
                Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                Text(
                  ' Salvar',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Criar Tarefa',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Divider(
              height: 60,
              color: Colors.grey.withOpacity(.5),
            ),
            Form(
              key: _formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TodoListTextInput(
                    label: '',
                    hint: 'Descrição da tarefa',
                    textController: _descriptionEC,
                    validator: Validatorless.required('Descrição obrigatória'),
                  ),
                  const SizedBox(height: 20),
                  DateButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
