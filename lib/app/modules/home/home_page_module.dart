import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/modules/page_module.dart';
import 'package:to_do_list/app/modules/home/home_page.dart';

class HomePageModule extends PageModule {

  HomePageModule() : super(
    providers: null,
    routes: {
      '/home': (BuildContext context) => const HomePage(),
    }
  );

}