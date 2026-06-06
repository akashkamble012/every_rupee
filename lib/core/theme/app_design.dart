import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// AppDesign — Single source of truth for all design tokens.
/// Never use hardcoded colors, radii, or spacing in widgets; always reference
/// this class so a theme change propagates everywhere automatically.
abstract class AppDesign {
  // ── Palette ──────────────────────────────────────────────────────────────

  /// OLED-safe black background
  static const Color background = Color(0xFF000000);

  /// Slightly elevated surface cards
  static const Color surface = Color(0xFF111111);

  /// Elevated input / dialog surface
  static const Color surfaceHigh = Color(0xFF1C1C1E);

  /// Tech Blue — primary brand accent
  static const Color primary = Color(0xFF2979FF);

  /// Lighter primary for hover/focus states
  static const Color primaryLight = Color(0xFF82B1FF);

  // ── Semantic ─────────────────────────────────────────────────────────────

  /// Spend within safe zone (≤ 70 % of cap)
  static const Color success = Color(0xFF00C853);

  /// Spend approaching cap (70–90 %)
  static const Color warning = Color(0xFFFFAB00);

  /// Spend at / over cap (> 90 %)
  static const Color error = Color(0xFFFF1744);

  /// Credit / income indicator
  static const Color credit = Color(0xFF00BFA5);

  /// Debit / expense indicator
  static const Color debit = Color(0xFFFF5252);

  // ── Neutrals ─────────────────────────────────────────────────────────────
  static const Color onBackground = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFFE0E0E0);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color subtle = Color(0xFF757575);
  static const Color divider = Color(0xFF2C2C2E);

  // ── Spacing grid (8-pt base) ──────────────────────────────────────────────
  static const double s2 = 2;
  static const double s4 = 4;
  static const double s8 = 8;
  static const double s12 = 12;
  static const double s16 = 16;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s32 = 32;
  static const double s40 = 40;
  static const double s48 = 48;
  static const double s64 = 64;

  // ── Corner radii ──────────────────────────────────────────────────────────
  static const double radiusSmall = 8;
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;
  static const double radiusXL = 24;
  static const BorderRadius roundSmall =
      BorderRadius.all(Radius.circular(radiusSmall));
  static const BorderRadius roundMedium =
      BorderRadius.all(Radius.circular(radiusMedium));
  static const BorderRadius roundLarge =
      BorderRadius.all(Radius.circular(radiusLarge));

  // ── Elevation shadows ────────────────────────────────────────────────────
  static List<BoxShadow> get shadowCard => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowGlow => [
        BoxShadow(
          color: primary.withValues(alpha: 0.25),
          blurRadius: 24,
          spreadRadius: 0,
        ),
      ];

  // ── Typography ───────────────────────────────────────────────────────────
  static TextStyle get displayLarge => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: onBackground,
        letterSpacing: -1.0,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle get displayMedium => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: onBackground,
        letterSpacing: -0.5,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle get headlineMedium => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: onBackground,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle get titleMedium => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: onSurface,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: onSurface,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: subtle,
      );

  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: onSurface,
        letterSpacing: 0.4,
      );

  /// Monospaced amounts — tabular figures to prevent layout shift
  static TextStyle get amountLarge => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: onBackground,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle get amountMedium => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: onBackground,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle get amountSmall => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: onSurface,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  // ── Material ThemeData ───────────────────────────────────────────────────
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          surface: surface,
          primary: primary,
          secondary: credit,
          error: error,
          onSurface: onSurface,
          onPrimary: Colors.white,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        cardTheme: const CardThemeData(
          color: surface,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: roundMedium),
        ),
        dividerTheme: const DividerThemeData(
          color: divider,
          thickness: 1,
          space: 1,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: surface,
          selectedItemColor: primary,
          unselectedItemColor: subtle,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 8,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceHigh,
          border: const OutlineInputBorder(
            borderRadius: roundMedium,
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: roundMedium,
            borderSide: BorderSide(color: primary, width: 1.5),
          ),
          hintStyle: GoogleFonts.inter(color: subtle, fontSize: 14),
          labelStyle: GoogleFonts.inter(color: subtle, fontSize: 14),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: s16, vertical: s14),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            textStyle:
                GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
            padding: const EdgeInsets.symmetric(vertical: s16, horizontal: s24),
            shape: const RoundedRectangleBorder(borderRadius: roundMedium),
            elevation: 0,
          ),
        ),
      );

  // Helper constants referenced inside theme
  static const double s14 = 14;
}

/// Semantic color helper — returns the correct color based on spend ratio.
Color spendColor(double ratio) {
  if (ratio <= 0.70) return AppDesign.success;
  if (ratio <= 0.90) return AppDesign.warning;
  return AppDesign.error;
}
