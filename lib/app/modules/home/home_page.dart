import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/modules/home/widgets/home_drawer.dart';
import 'package:to_do_list/app/modules/home/widgets/home_filter.dart';
import 'package:to_do_list/app/modules/home/widgets/home_header.dart';
import 'package:to_do_list/app/modules/home/widgets/home_tasks.dart';
import 'package:to_do_list/app/modules/tasks/tasks_module.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToCreateTask(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }, 
        pageBuilder: (context, animation, secondaryAnimation) {
          return TasksModule().getPage('/task/create', context);
        } 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: ThemeDefinition.primaryColor),
          backgroundColor: Colors.transparent,
          surfaceTintColor: ThemeDefinition.secondaryColor.withOpacity(1),
          elevation: 0,
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.filter_alt_outlined),
              itemBuilder: (_) => [
                const PopupMenuItem<bool>(
                  child: Text('Mostrar tarefas concluídas'),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ThemeDefinition.primaryColor,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: () => _goToCreateTask(context),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100))),
        ),
        backgroundColor: ThemeDefinition.backgroudColor,
        drawer: HomeDrawer(),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(),
                      HomeFilter(),
                      HomeTasks(),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
