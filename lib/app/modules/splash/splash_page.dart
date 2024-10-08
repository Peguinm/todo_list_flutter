import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/widgets/todo_list_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TodoListLogo(),
          ),
        ],
      ),
    );
  }
}
