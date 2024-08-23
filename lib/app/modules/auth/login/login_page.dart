import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/core/widgets/todo_list_logo.dart';
import 'package:to_do_list/app/core/widgets/todo_list_text_input.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                //* Esse cara define um tamanho para o column, exatamente o tamanho que ele ocupa na tela
                //* resolvendo problemas de tamanho infinito do column
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // const TodoListLogo(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 60),
                      child: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TodoListLogo(),
                            const SizedBox(height: 10),
                            TodoListTextInput(
                              label: 'E-mail',
                            ),
                            const SizedBox(height: 10),
                            TodoListTextInput(
                              label: 'Senha',
                              isObscure: true,
                              //suffixIconButton: IconButton(icon: Icon(Icons.ac_unit), onPressed: () {},),
                            ),
                            const SizedBox(height: 10),
                            //
                            //* Botão forgot password
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Esqueceu sua senha?',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),                            
                            //
                            //* Botão login
                            ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: WidgetStatePropertyAll<Size>(
                                  Size(
                                    constraints.maxWidth,
                                    40,
                                  ),
                                ),
                                elevation:
                                    const WidgetStatePropertyAll<double>(3.0),
                              ),
                              onPressed: () {},
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('Login'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //
                    //
                    Expanded(
                      child: Container(
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                            width: 1,
                            color: Colors.grey.withAlpha(100),
                          )),
                          color: ThemeDefinition.secondaryColor.withAlpha(80),
                        ),
                        //
                        //* Login com google
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            SignInButton(
                              Buttons.google,
                              onPressed: () {},
                              elevation: 2,
                              padding: const EdgeInsets.all(4),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3.0),
                                ),
                              ),
                              text: 'Entrar com o Google',
                            ),
                            //
                            //* Botão de cadastro
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Não tem conta?  '),
                                TextButton(
                                  onPressed: () {                                    
                                    Navigator.of(context)
                                        .pushNamed('/register');
                                  },
                                  child: const Text('Cadastre-se'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
