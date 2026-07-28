import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

enum AppBadgeTone {
  neutral,
  accent,
  success,
  error,
  warning,
}

/// Compact status / category label.
///
/// Prefer for taxonomy (industry, status) — not decorative stickers on heroes.
class AppBadge extends StatelessWidget {
  const AppBadge({
    required this.label,
    this.tone = AppBadgeTone.neutral,
    this.icon,
    super.key,
  });

  final String label;
  final AppBadgeTone tone;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      AppBadgeTone.neutral => (AppColors.surfaceMuted, AppColors.textSecondary),
      AppBadgeTone.accent => (AppColors.accentSubtle, AppColors.accent),
      AppBadgeTone.success => (AppColors.successSubtle, AppColors.success),
      AppBadgeTone.error => (AppColors.errorSubtle, AppColors.error),
      AppBadgeTone.warning => (AppColors.warningSubtle, AppColors.warning),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.pillAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(color: fg, size: 12),
              child: icon!,
            ),
            const SizedBox(width: AppSpacing.xxs),
          ],
          Text(
            label,
            style: AppTypography.captionStyle.copyWith(
              color: fg,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
