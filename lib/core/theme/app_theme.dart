import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /// Shared scaffold gradients for light and dark modes.
  static const LinearGradient lightScaffoldGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color.fromRGBO(239, 239, 245, 1),
      Color.fromRGBO(255, 255, 255, 1),
    ],
  );

  static const LinearGradient darkScaffoldGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Color.fromRGBO(32, 32, 36,1), Color.fromRGBO(18, 18, 18, 1)],
  );

  static LinearGradient scaffoldGradient(Brightness? brightness) {
    return brightness == Brightness.dark
        ? darkScaffoldGradient
        : lightScaffoldGradient;
  }

  static CupertinoThemeData lightTheme() {
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF6C63FF),
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      primaryContrastingColor: CupertinoColors.systemGrey4,
      barBackgroundColor: const Color(0xFFF8F9FA),
      textTheme: CupertinoTextThemeData(
        tabLabelTextStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color.fromARGB(221, 0, 0, 0),
        ),
        textStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color.fromARGB(221, 75, 75, 75),
        ),
        navTitleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
        navLargeTitleTextStyle: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        actionTextStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w400,
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
        tabLabelTextStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color.fromARGB(221, 255, 255, 255),
        ),
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
        navLargeTitleTextStyle: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        actionTextStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w400,
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
