import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Designul foloseste "Product Sans" (font proprietar Google, indisponibil
/// public). Poppins este cel mai apropiat echivalent liber: tot geometric,
/// acelasi "a" cu un singur etaj.
abstract final class AppTheme {
  static TextStyle font({
    required double size,
    required FontWeight weight,
    required Color color,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.poppins(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height == null ? null : height / size,
        letterSpacing: letterSpacing,
      );

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accent,
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      );

  // --- Stiluri reutilizate, cu valorile exacte din Figma ---

  /// Titlu de sectiune: 20px / 700
  static TextStyle get sectionTitle =>
      font(size: 20, weight: FontWeight.w700, color: AppColors.textHeading, height: 23);

  /// "Show all": 13px / 500
  static TextStyle get showAll =>
      font(size: 13, weight: FontWeight.w500, color: AppColors.textShowAll, height: 20, letterSpacing: -0.1);

  /// Nume de produs pe card: 12px / 500
  static TextStyle get productName =>
      font(size: 12, weight: FontWeight.w500, color: AppColors.textPrimary, height: 15, letterSpacing: -0.1);

  /// Pret pe card: 16px / 700
  static TextStyle get productPrice =>
      font(size: 16, weight: FontWeight.w700, color: AppColors.textPrimary, height: 23);

  /// Titlu de accordion: 16px / 700
  static TextStyle get accordionTitle =>
      font(size: 16, weight: FontWeight.w700, color: AppColors.textDark, height: 23);
}
