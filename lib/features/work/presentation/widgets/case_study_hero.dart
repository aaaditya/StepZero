import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/animated_counter.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/pill_badge.dart';
import '../../../../core/widgets/reveal.dart';
import '../../domain/case_study.dart';

/// Case study opening — Stripe clarity + Apple gravity.
class CaseStudyHero extends StatelessWidget {
  const CaseStudyHero({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    final titleSize = Responsive.fluidFontSize(
      context,
      desktop: 56,
      tablet: 42,
      mobile: 32,
    );

    return Reveal(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.section),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PillBadge(label: study.overview.industry),
            const SizedBox(height: AppSpacing.lg),
            Text(
              study.name,
              style: AppTypography.captionStyle.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Semantics(
              header: true,
              child: Text(
                study.headline,
                style: AppTypography.headingXlStyle.copyWith(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.4,
                  height: 1.08,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Text(
                study.outcomeLine,
                style: AppTypography.bodyLargeStyle,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                for (final metric in study.heroMetrics)
                  _HeroMetric(metric: metric),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.sm,
              children: [
                AppButton(
                  label: 'Start a similar project',
                  onPressed: () => context.go(AppRoutes.contact),
                ),
                AppButton(
                  label: 'All work',
                  variant: AppButtonVariant.secondary,
                  onPressed: () => context.go(AppRoutes.work),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({required this.metric});

  final CaseStudyMetric metric;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCounter.fromMetricString(
            metric.value,
            style: AppTypography.headingSStyle.copyWith(fontSize: 28),
            semanticLabel: '${metric.label} ${metric.value}',
          ),
          const SizedBox(height: 4),
          Text(metric.label, style: AppTypography.captionStyle),
        ],
      ),
    );
  }
}
