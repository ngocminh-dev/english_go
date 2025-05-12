// theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF006E60); // Xanh ngọc đậm, hiện đại
  static const Color secondary = Color(0xFF00BFA5); // Xanh ngọc sáng
  static const Color background = Color(0xFFF5F7FA); // Nền sáng sang trọng
  static const Color cardColor = Color(0xFFFFFFFF); // Card trắng tinh khôi

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Color(0xFF222222),
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFF333333),
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF555555),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondary,
      elevation: 6,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        elevation: 4,
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: cardColor,
      elevation: 5,
      shadowColor: Colors.black12,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
    scaffoldBackgroundColor: const Color(0xFF121212),
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white60,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F1F1F),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondary,
      elevation: 6,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        elevation: 4,
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: const Color(0xFF1E1E1E),
      elevation: 5,
      shadowColor: Colors.black54,
    ),
  );

}

