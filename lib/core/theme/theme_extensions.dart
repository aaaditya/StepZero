import 'package:flutter/material.dart';

import '../constants/durations.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// Custom [ThemeExtension] for tokens Material doesn't cover.
///
/// Access via `Theme.of(context).extension<StepZeroTheme>()!`
/// or the [BuildContext] helpers in `context_extensions.dart`.
@immutable
class StepZeroTheme extends ThemeExtension<StepZeroTheme> {
  const StepZeroTheme({
    required this.accentSubtle,
    required this.surfaceMuted,
    required this.textTertiary,
    required this.borderStrong,
    required this.successSubtle,
    required this.errorSubtle,
    required this.hoverDuration,
    required this.contentMaxWidth,
    required this.heroMaxWidth,
    required this.sectionPaddingY,
    required this.cardRadius,
    required this.buttonRadius,
    required this.inputRadius,
  });

  final Color accentSubtle;
  final Color surfaceMuted;
  final Color textTertiary;
  final Color borderStrong;
  final Color successSubtle;
  final Color errorSubtle;
  final Duration hoverDuration;
  final double contentMaxWidth;
  final double heroMaxWidth;
  final double sectionPaddingY;
  final double cardRadius;
  final double buttonRadius;
  final double inputRadius;

  static const StepZeroTheme light = StepZeroTheme(
    accentSubtle: AppColors.accentSubtle,
    surfaceMuted: AppColors.surfaceMuted,
    textTertiary: AppColors.textTertiary,
    borderStrong: AppColors.borderStrong,
    successSubtle: AppColors.successSubtle,
    errorSubtle: AppColors.errorSubtle,
    hoverDuration: AppDurations.fast,
    contentMaxWidth: 1200,
    heroMaxWidth: 1400,
    sectionPaddingY: AppSpacing.section,
    cardRadius: AppRadius.lg,
    buttonRadius: AppRadius.md,
    inputRadius: AppRadius.md,
  );

  @override
  StepZeroTheme copyWith({
    Color? accentSubtle,
    Color? surfaceMuted,
    Color? textTertiary,
    Color? borderStrong,
    Color? successSubtle,
    Color? errorSubtle,
    Duration? hoverDuration,
    double? contentMaxWidth,
    double? heroMaxWidth,
    double? sectionPaddingY,
    double? cardRadius,
    double? buttonRadius,
    double? inputRadius,
  }) {
    return StepZeroTheme(
      accentSubtle: accentSubtle ?? this.accentSubtle,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      textTertiary: textTertiary ?? this.textTertiary,
      borderStrong: borderStrong ?? this.borderStrong,
      successSubtle: successSubtle ?? this.successSubtle,
      errorSubtle: errorSubtle ?? this.errorSubtle,
      hoverDuration: hoverDuration ?? this.hoverDuration,
      contentMaxWidth: contentMaxWidth ?? this.contentMaxWidth,
      heroMaxWidth: heroMaxWidth ?? this.heroMaxWidth,
      sectionPaddingY: sectionPaddingY ?? this.sectionPaddingY,
      cardRadius: cardRadius ?? this.cardRadius,
      buttonRadius: buttonRadius ?? this.buttonRadius,
      inputRadius: inputRadius ?? this.inputRadius,
    );
  }

  @override
  StepZeroTheme lerp(ThemeExtension<StepZeroTheme>? other, double t) {
    if (other is! StepZeroTheme) return this;
    return StepZeroTheme(
      accentSubtle: Color.lerp(accentSubtle, other.accentSubtle, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      successSubtle: Color.lerp(successSubtle, other.successSubtle, t)!,
      errorSubtle: Color.lerp(errorSubtle, other.errorSubtle, t)!,
      hoverDuration: t < 0.5 ? hoverDuration : other.hoverDuration,
      contentMaxWidth: lerpDouble(contentMaxWidth, other.contentMaxWidth, t)!,
      heroMaxWidth: lerpDouble(heroMaxWidth, other.heroMaxWidth, t)!,
      sectionPaddingY: lerpDouble(sectionPaddingY, other.sectionPaddingY, t)!,
      cardRadius: lerpDouble(cardRadius, other.cardRadius, t)!,
      buttonRadius: lerpDouble(buttonRadius, other.buttonRadius, t)!,
      inputRadius: lerpDouble(inputRadius, other.inputRadius, t)!,
    );
  }
}

double? lerpDouble(double a, double b, double t) => a + (b - a) * t;
