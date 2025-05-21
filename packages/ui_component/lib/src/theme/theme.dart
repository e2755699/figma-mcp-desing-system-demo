import 'package:flutter/material.dart';

/// UI元件庫主題設定
class UITheme {
  /// 預設淺色主題
  static ThemeData get light {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF0066CC),
        secondary: const Color(0xFF03DAC5),
        error: const Color(0xFFB00020),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  /// 預設深色主題
  static ThemeData get dark {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF4DA6FF),
        secondary: const Color(0xFF03DAC5),
        error: const Color(0xFFCF6679),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
} 