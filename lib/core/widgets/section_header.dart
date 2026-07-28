import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/curves.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';

/// Consistent section intro used across homepage product surfaces.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.eyebrow,
    this.subtitle,
    this.alignment = CrossAxisAlignment.start,
    this.maxTitleWidth = 720,
    this.action,
    super.key,
  });

  final String title;
  final String? eyebrow;
  final String? subtitle;
  final CrossAxisAlignment alignment;
  final double maxTitleWidth;
  final Widget? action;

  bool get _centered => alignment == CrossAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    final titleSize = Responsive.fluidFontSize(
      context,
      desktop: 48,
      tablet: 36,
      mobile: 28,
    );

    final header = Column(
      crossAxisAlignment: alignment,
      children: [
        if (eyebrow != null) ...[
          Text(
            eyebrow!.toUpperCase(),
            style: AppTypography.captionStyle.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
              fontSize: 12,
            ),
            textAlign: _centered ? TextAlign.center : TextAlign.start,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxTitleWidth),
          child: Text(
            title,
            style: AppTypography.headingLStyle.copyWith(
              fontSize: titleSize,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.2,
              height: 1.1,
            ),
            textAlign: _centered ? TextAlign.center : TextAlign.start,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.lg),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: _centered ? 640 : 560,
            ),
            child: Text(
              subtitle!,
              style: AppTypography.bodyLargeStyle.copyWith(
                fontSize: Responsive.fluidFontSize(
                  context,
                  desktop: 18,
                  tablet: 17,
                  mobile: 16,
                ),
              ),
              textAlign: _centered ? TextAlign.center : TextAlign.start,
            ),
          ),
        ],
      ],
    );

    final animated = header
        .animate()
        .fadeIn(duration: 500.ms, curve: AppCurves.enter)
        .moveY(begin: 18, end: 0, duration: 550.ms, curve: AppCurves.enter);

    if (action == null) return animated;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: animated),
        const SizedBox(width: AppSpacing.lg),
        action!,
      ],
    );
  }
}
