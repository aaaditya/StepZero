import 'package:flutter/material.dart';

/// StepZero color tokens.
///
/// Soft warm off-white canvas (#FAFAF8) with near-black type and a
/// restrained indigo accent. No decorative gradients baked into tokens —
/// gradients are compositional choices, not system defaults.
abstract final class AppColors {
  // ─── Surfaces ───────────────────────────────────────────────
  static const Color background = Color(0xFFFAFAF8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF5F5F3);
  static const Color surfaceElevated = Color(0xFFFFFFFF);

  // ─── Text ───────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textInverse = Color(0xFFFAFAF8);
  static const Color textOnAccent = Color(0xFFFFFFFF);

  // ─── Borders ────────────────────────────────────────────────
  static const Color border = Color(0xFFECECEC);
  static const Color borderStrong = Color(0xFFD4D4D4);
  static const Color borderFocus = Color(0xFF5B5FEF);

  // ─── Brand ──────────────────────────────────────────────────
  static const Color accent = Color(0xFF5B5FEF);
  static const Color accentHover = Color(0xFF4A4EE0);
  static const Color accentPressed = Color(0xFF3F43D0);
  static const Color accentSubtle = Color(0xFFEDEDFF);

  // ─── Semantic ───────────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color successSubtle = Color(0xFFDCFCE7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorSubtle = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningSubtle = Color(0xFFFEF3C7);

  // ─── Overlay / scrim ────────────────────────────────────────
  static const Color overlay = Color(0x66000000);
  static const Color scrim = Color(0x14000000);

  // ─── Material ColorScheme mapping ───────────────────────────
  static ColorScheme get lightColorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: accent,
        onPrimary: textOnAccent,
        secondary: textSecondary,
        onSecondary: textInverse,
        error: error,
        onError: textOnAccent,
        surface: surface,
        onSurface: textPrimary,
        surfaceContainerLowest: background,
        surfaceContainerLow: surfaceMuted,
        surfaceContainer: surface,
        surfaceContainerHigh: surfaceElevated,
        outline: border,
        outlineVariant: borderStrong,
      );
}
