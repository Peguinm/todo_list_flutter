import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/modules/page_module.dart';
import 'package:to_do_list/app/modules/auth/login/login_controller.dart';
import 'package:to_do_list/app/modules/auth/login/login_page.dart';
import 'package:to_do_list/app/modules/auth/register/register_controller.dart';
import 'package:to_do_list/app/modules/auth/register/register_page.dart';

class AuthModule extends PageModule {

  AuthModule()
      : super(
          providers: [
            ChangeNotifierProvider(
              create: (context) => LoginController(userService: context.read()),
            ),
            ChangeNotifierProvider(
              create: (context) => RegisterController(userService: context.read()),
            ),
          ],
          routes: {
            '/login': (BuildContext context) => const LoginPage(),
            '/register': (BuildContext context) => const RegisterPage(),
          },
        );
}
