import 'package:flutter/material.dart';

import '../animations/hover_effects.dart';
import '../theme/app_colors.dart';
import '../theme/app_elevation.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

/// Card variants — use sparingly.
///
/// Cards are for interactive containers only (work pieces, selectable plans).
/// Decorative boxed content violates the StepZero design principles.
enum AppCardVariant {
  outlined,
  filled,
  elevated,
}

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.onTap,
    this.variant = AppCardVariant.outlined,
    this.padding,
    this.borderRadius,
    this.enableHover = true,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final AppCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final bool enableHover;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppRadius.lgAll;

    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: switch (variant) {
          AppCardVariant.outlined || AppCardVariant.elevated => AppColors.surface,
          AppCardVariant.filled => AppColors.surfaceMuted,
        },
        borderRadius: radius,
        border: variant == AppCardVariant.outlined
            ? Border.all(color: AppColors.border)
            : null,
        boxShadow: variant == AppCardVariant.elevated ? AppElevation.medium : null,
      ),
      child: child,
    );

    if (onTap == null) return content;

    if (enableHover) {
      return HoverScale(scale: 1.01, onTap: onTap, child: content);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: onTap, child: content),
    );
  }
}
