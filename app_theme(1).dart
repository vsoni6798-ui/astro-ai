import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color deepSpace = Color(0xFF1A1035);
  static const Color midnight = Color(0xFF2D1B4E);
  static const Color starGold = Color(0xFFFFC857);
  static const Color mysticPurple = Color(0xFF9C6ADE);
  static const Color softLavender = Color(0xFFE8DFFF);

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: deepSpace,
      colorScheme: base.colorScheme.copyWith(
        primary: mysticPurple,
        secondary: starGold,
        surface: midnight,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: midnight,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: midnight,
        selectedItemColor: starGold,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: mysticPurple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: midnight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static LinearGradient get backgroundGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [deepSpace, midnight],
      );
}
