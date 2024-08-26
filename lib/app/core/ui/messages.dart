import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';

class Messages {
  final BuildContext context;

  Messages._(this.context);

  factory Messages.of(BuildContext context) => Messages._(context);

  void _showMessage(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
  void showError(String error) => _showMessage(error, Colors.red);

  void showInfo(String message) => _showMessage(message, ThemeDefinition.primaryColor);
}
