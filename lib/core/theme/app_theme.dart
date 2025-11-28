import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static CupertinoThemeData lightTheme() {
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF6C63FF),
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      primaryContrastingColor: CupertinoColors.systemGrey4,
      barBackgroundColor: const Color(0xFFF8F9FA),
      textTheme: CupertinoTextThemeData(
        textStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
        navTitleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
    );
  }

  static CupertinoThemeData darkTheme() {
    return CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF6C63FF),
      scaffoldBackgroundColor: const Color(0xFF121212),
      primaryContrastingColor: CupertinoColors.systemGrey4,
      barBackgroundColor: const Color(0xFF121212),
      textTheme: CupertinoTextThemeData(
        textStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        navTitleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  static Color getMetricColor(int value) {
    if (value >= 80) {
      return const Color(0xFF4CAF50); // Green
    } else if (value >= 50) {
      return const Color(0xFF2196F3); // Blue
    } else {
      return const Color(0xFF9E9E9E); // Neutral gray
    }
  }
}
