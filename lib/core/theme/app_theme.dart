import 'package:flutter/material.dart';

import 'app_fonts.dart';

class AppTheme {
  // Brand Colors (Travel Palette)
  static const Color primary = Color(0xFF0077B6);
  static const Color primaryDark = Color(0xFF005A8C);
  static const Color primarySoft = Color(0xFF1A8FC4);
  static const Color primaryLight = Color(0xFFE8F4FA);
  static const Color secondary = Color(0xFFFF6B6B);
  static const Color background = Color(0xFFF6F6F6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textStrong = Color(0xFF1F1F1F);
  static const Color textBody = Color(0xFF6B7280);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFB8BCC6);
  static const Color border = Color(0xFFE6E6EA);

  // Legacy aliases
  static const Color backgroundLight = background;
  static const Color surfaceLight = surface;
  static const Color textPrimary = textStrong;

  static Gradient get scaffoldGradient => const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [primaryLight, background, background],
        stops: [0.0, 0.4, 1.0],
      );

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppFonts.somarSans,
    primaryColor: primary,
    scaffoldBackgroundColor: background,

    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: secondary,
      surface: surface,
      error: Color(0xFFE63946),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.elMessiri,
        color: textStrong,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: IconThemeData(color: textStrong),
    ),

    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: border),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size.fromHeight(54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        textStyle: const TextStyle(
          fontFamily: AppFonts.somarSans,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size.fromHeight(54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        textStyle: const TextStyle(
          fontFamily: AppFonts.somarSans,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: primary, width: 1.5),
      ),
      hintStyle: const TextStyle(
        fontFamily: AppFonts.somarSans,
        color: textHint,
        fontSize: 14,
      ),
      labelStyle: const TextStyle(
        fontFamily: AppFonts.somarSans,
        color: textSecondary,
        fontSize: 14,
      ),
    ),

    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontFamily: AppFonts.elMessiri,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textStrong,
      ),
      titleMedium: TextStyle(
        fontFamily: AppFonts.elMessiri,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: textStrong,
      ),
      bodyMedium: TextStyle(
        fontFamily: AppFonts.somarSans,
        fontSize: 14,
        color: textBody,
        height: 1.5,
      ),
    ),
  );
}
