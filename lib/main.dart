import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_list/app/app_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); 

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const AppModule());

}