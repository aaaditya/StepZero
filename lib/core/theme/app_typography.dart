import 'package:flutter/material.dart';

import 'app_colors.dart';

/// StepZero typography scale — self-hosted Inter (no CDN on critical path).
///
/// Bundled variable font improves LCP / font CLS vs runtime Google Fonts fetch.
abstract final class AppTypography {
  static const String fontFamily = 'Inter';

  // ─── Scale (px) ─────────────────────────────────────────────
  static const double hero = 80;
  static const double headingXl = 56;
  static const double headingL = 48;
  static const double headingM = 36;
  static const double headingS = 28;
  static const double bodyLarge = 20;
  static const double body = 18;
  static const double small = 16;
  static const double caption = 14;

  static TextStyle _inter({
    required double size,
    required FontWeight weight,
    required double height,
    double letterSpacing = 0,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: letterSpacing,
      color: color ?? AppColors.textPrimary,
      fontFamilyFallback: const [
        'system-ui',
        '-apple-system',
        'Segoe UI',
        'Roboto',
        'sans-serif',
      ],
    );
  }

  // ─── Named styles ───────────────────────────────────────────

  /// Full-bleed hero display — desktop only; scale down on mobile.
  static TextStyle get displayHero => _inter(
        size: hero,
        weight: FontWeight.w600,
        height: 1.05,
        letterSpacing: -1.6,
      );

  static TextStyle get headingXlStyle => _inter(
        size: headingXl,
        weight: FontWeight.w600,
        height: 1.1,
        letterSpacing: -1.2,
      );

  static TextStyle get headingLStyle => _inter(
        size: headingL,
        weight: FontWeight.w600,
        height: 1.15,
        letterSpacing: -1.0,
      );

  static TextStyle get headingMStyle => _inter(
        size: headingM,
        weight: FontWeight.w600,
        height: 1.2,
        letterSpacing: -0.6,
      );

  static TextStyle get headingSStyle => _inter(
        size: headingS,
        weight: FontWeight.w600,
        height: 1.25,
        letterSpacing: -0.3,
      );

  static TextStyle get bodyLargeStyle => _inter(
        size: bodyLarge,
        weight: FontWeight.w400,
        height: 1.6,
        letterSpacing: -0.1,
        color: AppColors.textSecondary,
      );

  static TextStyle get bodyStyle => _inter(
        size: body,
        weight: FontWeight.w400,
        height: 1.65,
        color: AppColors.textSecondary,
      );

  static TextStyle get bodyStrong => _inter(
        size: body,
        weight: FontWeight.w500,
        height: 1.65,
      );

  static TextStyle get smallStyle => _inter(
        size: small,
        weight: FontWeight.w400,
        height: 1.5,
        color: AppColors.textSecondary,
      );

  static TextStyle get captionStyle => _inter(
        size: caption,
        weight: FontWeight.w400,
        height: 1.45,
        letterSpacing: 0.1,
        color: AppColors.textTertiary,
      );

  static TextStyle get labelStyle => _inter(
        size: caption,
        weight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.2,
      );

  static TextStyle get buttonLabel => _inter(
        size: small,
        weight: FontWeight.w500,
        height: 1.25,
        letterSpacing: -0.1,
      );

  static TextStyle get navLabel => _inter(
        size: small,
        weight: FontWeight.w500,
        height: 1.25,
        letterSpacing: -0.1,
      );

  /// Material [TextTheme] wired to our scale.
  static TextTheme get textTheme => TextTheme(
        displayLarge: displayHero,
        displayMedium: headingXlStyle,
        displaySmall: headingLStyle,
        headlineLarge: headingLStyle,
        headlineMedium: headingMStyle,
        headlineSmall: headingSStyle,
        titleLarge: headingSStyle,
        titleMedium: bodyStrong,
        titleSmall: labelStyle,
        bodyLarge: bodyLargeStyle,
        bodyMedium: bodyStyle,
        bodySmall: smallStyle,
        labelLarge: buttonLabel,
        labelMedium: labelStyle,
        labelSmall: captionStyle,
      );
}
