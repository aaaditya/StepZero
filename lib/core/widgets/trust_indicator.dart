import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Compact check + label used under hero CTAs for micro-trust.
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
          width: 18,
          height: 18,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.successSubtle,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 12,
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.captionStyle.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
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
    this.spacing = AppSpacing.lg,
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
