import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class PageBuilder extends StatelessWidget {

  final List<SingleChildWidget>? _providers;
  final WidgetBuilder _pageBuilder;

  const PageBuilder({
    List<SingleChildWidget>? providers,
    required WidgetBuilder pageBuilder,
    super.key,
  }) : _providers = providers, _pageBuilder = pageBuilder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers ??
          [
            Provider(
              create: (context) => Object(),
            )
          ],
      child: _pageBuilder(context),
    );
  }
}
