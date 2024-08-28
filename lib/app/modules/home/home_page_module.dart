import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/modules/page_module.dart';
import 'package:to_do_list/app/modules/home/home_controller.dart';
import 'package:to_do_list/app/modules/home/home_page.dart';

class HomePageModule extends PageModule {
  HomePageModule()
      : super(providers: [
          ChangeNotifierProvider(
            create: (context) => HomeController(),
          )
        ], routes: {
          '/home': (BuildContext context) => const HomePage(),
        });
}
