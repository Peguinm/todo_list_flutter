import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/app_widget.dart';
import 'package:to_do_list/app/core/database/sqlite_connection_factory.dart';
import 'package:to_do_list/app/repositories/user/user_repository.dart';
import 'package:to_do_list/app/repositories/user/user_repository_imp.dart';
import 'package:to_do_list/app/services/user/user_service.dart';
import 'package:to_do_list/app/services/user/user_service_impl.dart';

//* Core

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) {
          return FirebaseAuth.instance;
        }),
        Provider(
          lazy:
              false, //* Garantindo que não haverá atrasado ne criação desse provider
          create: (_) {
            return SqliteConnectionFactory();
          },
        ),
        Provider<UserRepository>(
          create: (BuildContext context) {
            return UserRepositoryImp(firebaseAuth: context.read());
          },
        ),
        Provider<UserService>(
          create: (BuildContext context) {
            return UserServiceImpl(userRepository: context.read());
          },
        ),
      ],
      child: const AppWidget(),
    );
  }
}
