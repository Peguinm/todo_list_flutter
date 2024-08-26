import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/auth/my_auth_provider.dart';
import 'package:to_do_list/app/modules/home/widgets/home_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App'),
      ),
      drawer: const HomeDrawer(),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.read<MyAuthProvider>().logout();
          },
          child: const Text('Purificar'),
        ),
      ),
    );
  }
}
