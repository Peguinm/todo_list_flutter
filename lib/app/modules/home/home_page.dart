import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/notifier/default_listener.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/models/filter_enum.dart';
import 'package:to_do_list/app/modules/home/home_controller.dart';
import 'package:to_do_list/app/modules/home/widgets/home_drawer.dart';
import 'package:to_do_list/app/modules/home/widgets/home_filter.dart';
import 'package:to_do_list/app/modules/home/widgets/home_header.dart';
import 'package:to_do_list/app/modules/home/widgets/home_tasks.dart';
import 'package:to_do_list/app/modules/tasks/tasks_module.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {

    DefaultListener(changeNotifier: context.read<HomeController>()).listener(
      context: context,
      succesCallback: (changeNotifer, listener) {},
    );  

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<HomeController>().loadTotalTasks();
        context.read<HomeController>().findTasks(filter: FILTER_ENUM.TODAY);
      },
    );

    super.initState();
  }

  Future<void> _goToCreateTask(BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
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
        },
      ),
    );
    context.read<HomeController>().refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomeController>().loadTotalTasks();

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: ThemeDefinition.primaryColor),
          backgroundColor: Colors.transparent,
          surfaceTintColor: ThemeDefinition.secondaryColor.withOpacity(1),
          elevation: 0,
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.filter_alt_outlined),
              onSelected: (_) => context.read<HomeController>().showOrHideDoneTasks(),
              itemBuilder: (_) => [
                PopupMenuItem<bool>(
                  value: true,
                  child: context.read<HomeController>().showDoneTasks ? const Text('Esconder tarefas concluídas') : const Text('Mostrar tarefas concluídas'),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ThemeDefinition.primaryColor,
          foregroundColor: Colors.white,
          onPressed: () => _goToCreateTask(context),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: const Icon(Icons.add),
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
                child: const IntrinsicHeight(
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
