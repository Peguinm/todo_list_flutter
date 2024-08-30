import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:to_do_list/app/core/modules/page_builder.dart';

abstract class PageModule {
  final Map<String, WidgetBuilder> _routes;
  final List<SingleChildWidget>? _providers;

  PageModule({
    required Map<String, WidgetBuilder> routes,
    required List<SingleChildWidget>? providers,
  })  : _routes = routes,
        _providers = providers;

  Map<String, WidgetBuilder> get routes {
    return _routes.map(
      (key, pageBuilder) => MapEntry(
        key,
        (context) => PageBuilder(
          providers: _providers,
          pageBuilder: pageBuilder,
        ),
      ),
    );
  }

  Widget getPage(String path, BuildContext context) {
    final widgetBuilder = routes[path];
    if (widgetBuilder != null) {
      return PageBuilder(
        pageBuilder: widgetBuilder,
        providers: _providers,
      );
    }

    throw Exception();
  }
}
