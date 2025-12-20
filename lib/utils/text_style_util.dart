import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class TextStyleUtil {
  static TextStyle marqueeTextStyle() {
    return TextStyle(
      fontFamily: "WelcomePlace",
      fontSize: 16,
      fontWeight: FontWeight.w200,
      color: Colors.white,
      shadows: [
        Shadow(
          blurRadius: 10.0,
          color: Colors.black.withOpacity(0.8),
          offset: const Offset(2.0, 2.0)
        )
      ]
    );
  }

  static TextStyle luxuriousTextStyle(double fontSize) {
    return GoogleFonts.luxuriousScript(
      color: Colors.black,
      fontWeight: FontWeight.w200,
      fontSize: fontSize
    );
  }

  static TextStyle commonTextStyle(double fontSize) {
    return TextStyle(
      fontFamily: "WelcomePlace",
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );
  }

}