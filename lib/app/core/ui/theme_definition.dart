import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeDefinition {
  static const primaryColor = Color(0xff57b091);
  static const secondaryColor = Color(0xff97d6c1);
  static const accentColor = Color(0xff69d0ad);
  static const backgroudColor = Color.fromARGB(255, 233, 233, 233);
  static const textColor = Color(0xff070a09);
  static const textColorLight = Color.fromARGB(255, 255, 255, 255);
  static const linkColor = Color.fromARGB(255, 28, 162, 252);

  static ThemeData get theme => ThemeData(
        //
        primaryColor: primaryColor,
        //
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionColor: secondaryColor,
          selectionHandleColor: primaryColor,
        ),
        //
        textTheme: GoogleFonts.montserratTextTheme().apply(
          bodyColor: textColor,
          displayColor: textColor,
        ),
        //
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: textColorLight,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
        //
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: linkColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
      );
}
