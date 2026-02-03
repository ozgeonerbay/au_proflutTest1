import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App theme with Turkish-friendly font. UTF-8 text displays correctly.
class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.robotoTextTheme(),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
