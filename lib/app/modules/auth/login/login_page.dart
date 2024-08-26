import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:to_do_list/app/core/notifier/default_listener.dart';
import 'package:to_do_list/app/core/ui/messages.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/core/widgets/todo_list_logo.dart';
import 'package:to_do_list/app/core/widgets/todo_list_text_input.dart';
import 'package:to_do_list/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _emailFocus.unfocus();
      },
    );

    DefaultListener(changeNotifier: context.read<LoginController>()).listener(
      context: context,
      infoCallback: (changeNotifer, listener) {
        if (changeNotifer is LoginController) {
          if (changeNotifer.hasInfo) {
            Messages.of(context).showInfo(changeNotifer.infoMessage!);
          }
        }
      },
      succesCallback: (changeNotifer, listener) {},
    );
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

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
                        key: _globalKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TodoListLogo(),
                            const SizedBox(height: 10),
                            //* Input de email
                            TodoListTextInput(
                              label: 'E-mail',
                              textController: _emailEC,
                              focusNode: _emailFocus,
                              validator: Validatorless.multiple([
                                Validatorless.required('E-mail obrigatório'),
                                Validatorless.email('Insira um e-mail válido'),
                              ]),
                            ),
                            const SizedBox(height: 10),
                            //* Input de senha
                            TodoListTextInput(
                              label: 'Senha',
                              textController: _passwordEC,
                              isObscure: true,
                              validator: Validatorless.multiple([
                                Validatorless.required('Senha obrigatória'),
                              ]),
                              //suffixIconButton: IconButton(icon: Icon(Icons.ac_unit), onPressed: () {},),
                            ),
                            const SizedBox(height: 10),
                            //
                            //* Botão forgot password
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  if (_emailEC.text.isEmpty) {
                                    Messages.of(context).showError(
                                        'Insira um e-mail para recuperar a senha');
                                    _emailFocus.requestFocus();
                                  } else {
                                    context.read<LoginController>().forgotPassword(_emailEC.text);
                                  }
                                },
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
                              onPressed: () {
                                final isValid =
                                    _globalKey.currentState?.validate() ??
                                        false;

                                if (isValid) {
                                  final email = _emailEC.text;
                                  final password = _passwordEC.text;

                                  context
                                      .read<LoginController>()
                                      .login(email, password);
                                }
                              },
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
                              onPressed: () {
                                context.read<LoginController>().googleLogin();
                              },
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
