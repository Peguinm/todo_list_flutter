import 'package:flutter/material.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset('assets/images/logo.png', height: 200,),
    ]);
  }
}
