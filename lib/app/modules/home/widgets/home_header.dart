import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/auth/my_auth_provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),          
      child: Selector<MyAuthProvider, String>(
        selector: (context, myAuthProvider) {
          return myAuthProvider.user?.displayName ?? 'Indefinido';
        },
        builder: (_, value, __) {
          return Text(
            'Olá, $value!',
            style: Theme.of(context).textTheme.titleLarge,
          );
        },
      ),
    );
  }
}
