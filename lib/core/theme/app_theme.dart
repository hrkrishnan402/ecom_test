import 'package:flutter/material.dart';

/// Application-wide theme data built on Material 3.
///
/// All colors, text styles, and component themes are defined here
/// so widgets reference `Theme.of(context)` instead of raw color constants.
class AppTheme {
  AppTheme._();

  // ── Palette ──────────────────────────────────────────────────────────────────
  static const Color primaryColor = Color(0xFFE53935); // red accent
  static const Color vegColor = Color(0xFF4CAF50);
  static const Color nonVegColor = Color(0xFFE53935);
  static const Color counterBackground = Color(0xFF2E7D32);
  static const Color surfaceColor = Colors.white;
  static const Color dividerColor = Color(0xFFEEEEEE);
  static const Color tabBorderColor = Color(0xFFE0E0E0);

  // ── Theme Data ───────────────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      surface: surfaceColor,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: surfaceColor,

      // ── AppBar ──
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Colors.black87, size: 26),
      ),

      // ── TabBar ──
      tabBarTheme: const TabBarThemeData(
        indicatorColor: primaryColor,
        labelColor: primaryColor,
        unselectedLabelColor: Colors.black54,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        unselectedLabelStyle:
            TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
      ),

      // ── Divider ──
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
        space: 1,
      ),

      // ── Text ──
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          fontSize: 12.5,
          color: Colors.black54,
          height: 1.4,
        ),
        labelMedium: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
