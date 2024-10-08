import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:to_do_list/app/core/database/sqlite_adm_connection.dart';
import 'package:to_do_list/app/core/navigator/todo_list_navigator.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/modules/auth/auth_module.dart';
import 'package:to_do_list/app/modules/home/home_page_module.dart';
import 'package:to_do_list/app/modules/splash/splash_page.dart';
import 'package:to_do_list/app/modules/tasks/tasks_module.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    //* Observer que recebe os states do app para cortar ligação com o database quando necessário
    WidgetsBinding.instance.addObserver(SqliteAdmConnection());
  }

  @override
  void dispose() {
    //* Remover a instancia do oberserver no dispose
    WidgetsBinding.instance.removeObserver(SqliteAdmConnection());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To do list provider",
      navigatorKey: TodoListNavigator.navigatorKey,
      theme: ThemeDefinition.theme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      debugShowCheckedModeBanner: false,
      //* Contrução antiga de page com providers, que foi substituida pela utilização de métodos
      // routes: <String, WidgetBuilder>{
      //   '/login': (BuildContext context) => MultiProvider(
      //         providers: [
      //           ChangeNotifierProvider(
      //             create: (context) => LoginController(),
      //           ),
      //         ],
      //         child: const LoginPage(),
      //       ),
      // },
      //* Construção nova
      routes: {
        ...AuthModule().routes,
        ...HomePageModule().routes,
        ...TasksModule().routes,
      },
      home: const SplashPage(),
    );
  }
}
