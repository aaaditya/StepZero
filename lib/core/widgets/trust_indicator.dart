import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Compact editorial micro-trust under hero CTAs — not SaaS checkboxes.
class TrustIndicator extends StatelessWidget {
  const TrustIndicator({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.accent,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: AppTypography.captionStyle.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 13,
            letterSpacing: -0.1,
          ),
        ),
      ],
    );
  }
}

/// Horizontal (wrap) row of [TrustIndicator]s.
class TrustIndicatorRow extends StatelessWidget {
  const TrustIndicatorRow({
    required this.labels,
    this.spacing = AppSpacing.xl,
    this.runSpacing = AppSpacing.sm,
    super.key,
  });

  final List<String> labels;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: [
        for (final label in labels) TrustIndicator(label: label),
      ],
    );
  }
}
