import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/widgets/todo_list_logo.dart';
import 'package:to_do_list/app/core/widgets/todo_list_text_input.dart';
import 'package:to_do_list/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  RegisterController? controller;

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<RegisterController>().addListener(
      () {
        controller = context.read<RegisterController>();
        String? error = controller?.error;
        bool success = controller?.success ?? false;

        if (success) {
          Navigator.of(context).pop(context);
        } else if (error != null && error.isNotEmpty) {
          final snackBar = SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cadastro',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Crie sua conta',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Form(
                key: _globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FittedBox(
                      fit: BoxFit.fitHeight,
                      child: TodoListLogo(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TodoListTextInput(
                      label: 'E-mail',
                      textController: _emailEC,
                      validator: Validatorless.multiple([
                        Validatorless.required('E-mail obrigatório'),
                        Validatorless.email('O valor inserido não é um e-mail'),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TodoListTextInput(
                      label: 'Senha',
                      textController: _passwordEC,
                      isObscure: true,
                      validator: Validatorless.multiple([
                        Validatorless.required('Senha obrigatória'),
                        Validatorless.min(
                            6, 'A senha deve possuír no minímo 6 dígitos'),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TodoListTextInput(
                      label: 'Confirmar Senha',
                      textController: _confirmPasswordEC,
                      isObscure: true,
                      validator: Validatorless.multiple([
                        Validatorless.required('Senha obrigatória'),
                        Validatorless.compare(
                            _passwordEC, 'As senhas estão diferentes'),
                      ]),
                    ),
                    const Divider(
                      thickness: 2,
                      height: 60,
                      indent: 50,
                      endIndent: 50,
                    ),
                    //
                    //* Botão de signin
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStatePropertyAll<Size>(
                          Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        elevation: const WidgetStatePropertyAll<double>(3.0),
                      ),
                      onPressed: () {
                        final bool isValid =
                            _globalKey.currentState?.validate() ?? false;

                        if (isValid) {
                          final email = _emailEC.text;
                          final password = _passwordEC.text;

                          context.read<RegisterController>().registerUser(email, password);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Registrar'),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
