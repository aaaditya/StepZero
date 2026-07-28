import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/reveal.dart';

/// Anchored chapter shell used across the case study reading experience.
class CaseStudyChapter extends StatelessWidget {
  const CaseStudyChapter({
    required this.id,
    required this.eyebrow,
    required this.title,
    required this.child,
    this.subtitle,
    this.wide = false,
    super.key,
  });

  final String id;
  final String eyebrow;
  final String title;
  final String? subtitle;
  final Widget child;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Reveal(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.section),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Anchor target for TOC / deep links.
            SizedBox(height: 0, key: ValueKey('anchor-$id')),
            Text(
              eyebrow.toUpperCase(),
              style: AppTypography.captionStyle.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.3,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Semantics(
              header: true,
              child: Text(
                title,
                style: AppTypography.headingMStyle.copyWith(
                  fontSize: wide ? 40 : 36,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.8,
                ),
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.md),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: wide ? 800 : 640),
                child: Text(subtitle!, style: AppTypography.bodyLargeStyle),
              ),
            ],
            const SizedBox(height: AppSpacing.xxl),
            child,
          ],
        ),
      ),
    );
  }
}

/// Editorial callout for Challenge / emphasis blocks.
class CaseStudyCallout extends StatelessWidget {
  const CaseStudyCallout({
    required this.body,
    this.label = 'The tension',
    super.key,
  });

  final String body;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.accent, width: 3)),
        color: AppColors.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTypography.captionStyle.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            body,
            style: AppTypography.headingSStyle.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              height: 1.45,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
