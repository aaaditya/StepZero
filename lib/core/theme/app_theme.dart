import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/durations.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_typography.dart';
import 'theme_extensions.dart';

/// Assembles Material 3 [ThemeData] from StepZero design tokens.
///
/// Single light theme for the marketing site. Dark mode is intentionally
/// deferred — premium brand sites usually ship one decisive look first.
abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = AppColors.lightColorScheme;
    final textTheme = AppTypography.textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      fontFamily: 'Inter',
      extensions: const <ThemeExtension<dynamic>>[
        StepZeroTheme.light,
      ],
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: null, // set via GoogleFonts at call site / nav
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      dividerColor: AppColors.border,
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.lgAll,
          side: BorderSide(color: AppColors.border),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceMuted,
        selectedColor: AppColors.accentSubtle,
        disabledColor: AppColors.surfaceMuted,
        labelStyle: AppTypography.labelStyle,
        side: BorderSide.none,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.pillAll),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: AppTypography.bodyStyle.copyWith(
          color: AppColors.textTertiary,
        ),
        labelStyle: AppTypography.smallStyle,
        errorStyle: AppTypography.captionStyle.copyWith(
          color: AppColors.error,
        ),
        border: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.borderFocus, width: 1.5),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.accent.withValues(alpha: 0.4);
            }
            if (states.contains(WidgetState.pressed)) {
              return AppColors.accentPressed;
            }
            if (states.contains(WidgetState.hovered)) {
              return AppColors.accentHover;
            }
            return AppColors.accent;
          }),
          foregroundColor: const WidgetStatePropertyAll(AppColors.textOnAccent),
          textStyle: WidgetStatePropertyAll(AppTypography.buttonLabel),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          ),
          minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
          animationDuration: AppDurations.fast,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.surfaceMuted;
            }
            return Colors.transparent;
          }),
          foregroundColor: const WidgetStatePropertyAll(AppColors.textPrimary),
          textStyle: WidgetStatePropertyAll(AppTypography.buttonLabel),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return const BorderSide(color: AppColors.borderFocus, width: 1.5);
            }
            return const BorderSide(color: AppColors.border);
          }),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          ),
          minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
          animationDuration: AppDurations.fast,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.accent;
            }
            return AppColors.textPrimary;
          }),
          textStyle: WidgetStatePropertyAll(AppTypography.buttonLabel),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: AppRadius.smAll),
          ),
          overlayColor: WidgetStatePropertyAll(
            AppColors.accent.withValues(alpha: 0.06),
          ),
          animationDuration: AppDurations.fast,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(AppColors.textPrimary),
          overlayColor: WidgetStatePropertyAll(
            AppColors.accent.withValues(alpha: 0.08),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: AppRadius.smAll),
          ),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        waitDuration: AppDurations.normal,
        decoration: const BoxDecoration(
          color: AppColors.textPrimary,
          borderRadius: AppRadius.smAll,
        ),
        textStyle: AppTypography.captionStyle.copyWith(
          color: AppColors.textInverse,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTypography.smallStyle.copyWith(
          color: AppColors.textInverse,
        ),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accent,
        linearTrackColor: AppColors.border,
      ),
      splashFactory: InkSparkle.splashFactory,
    );
  }
}
