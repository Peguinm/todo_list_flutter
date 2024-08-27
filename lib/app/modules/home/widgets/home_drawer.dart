import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/auth/my_auth_provider.dart';
import 'package:to_do_list/app/core/ui/messages.dart';
// ignore: unused_import
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});

  final nameChangeVN = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Drawer(      
      child: ListView(
        children: [
          SizedBox(
            height: 110,
            child: DrawerHeader(          
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
                          return Text(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),          
          ListTile(
            title: const Text('Alterar Nome'),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Alterar Nome'),
                    content: TextField(
                      onChanged: (value) {
                        nameChangeVN.value = value;
                      },
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3.0))),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll<Color>(Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                          ),
                          TextButton(
                            onPressed: () async {
                              final nameValue = nameChangeVN.value;
                              if (nameValue.isEmpty) {
                                Navigator.of(context).popUntil(ModalRoute.withName('/home'));
                                Messages.of(context).showError('Nome obrigatório');
                                
                              } else {
                                Navigator.of(context).pop();
                                Loader.show(context, progressIndicator: const CircularProgressIndicator());
                                await context.read<UserService>().changeUsername(nameValue);
                                Loader.hide();                                
                              }
                            },
                            child: const Text('Alterar'),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: const Text('Sair', style: TextStyle(color: Colors.red),),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Confirmação'),
                    content: const Text('Você deseja sair?'),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3.0))),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll<Color>(Colors.red),
                            ),
                            onPressed: () {
                              context.read<MyAuthProvider>().logout();
                            },
                            child: const Text('Sim',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
