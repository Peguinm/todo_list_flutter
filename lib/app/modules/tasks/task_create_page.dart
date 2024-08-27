import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/modules/tasks/task_create_controller.dart';
import 'package:to_do_list/app/modules/tasks/widgets/task_create_text_input.dart';
import 'package:to_do_list/main.dart';

class TaskCreatePage extends StatelessWidget {
  TaskCreatePage({super.key, required TaskCreateController controller})
      : _controller = controller;

  TaskCreateController _controller;

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
          onPressed: () {},
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TaskCreateTextInput(),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                      border: Border.all(
                        color: ThemeDefinition.primaryColor,
                        width: 1
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},                    
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent),
                        elevation: WidgetStatePropertyAll<double>(0.0),
                        foregroundColor: WidgetStatePropertyAll<Color>(ThemeDefinition.primaryColor),
                      ),                                                            
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.today, color: ThemeDefinition.primaryColor,),
                          Text(' 10/10/2010'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
