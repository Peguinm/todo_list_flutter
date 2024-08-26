import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/auth/my_auth_provider.dart';
// ignore: unused_import
import 'package:to_do_list/app/core/ui/theme_definition.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Selector<MyAuthProvider, String>(
                  selector: (context, myAuthProvider) {
                    return myAuthProvider.user?.photoURL ??
                        'https://i.pinimg.com/236x/21/d2/9f/21d29f70c61cdfc6a90cf1e53004d22e.jpg';
                  },
                  builder: (context, value, child) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(value),
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<MyAuthProvider, String>(
                      selector: (context, myAuthProvider) {
                        return myAuthProvider.user?.displayName ?? 'Indefinido';
                      },
                      builder: (context, value, child) {
                        return Text(
                          value
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
