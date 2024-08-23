import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext{

  Color get primaryColor => Theme.of(this).primaryColor;
  ButtonStyle? get elevatedButtonStyle => Theme.of(this).elevatedButtonTheme.style;

}