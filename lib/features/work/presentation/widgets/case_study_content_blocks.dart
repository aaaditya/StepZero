import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/animated_counter.dart';
import '../../domain/case_study.dart';
import 'case_study_chapter.dart';

class CaseStudyOverviewSection extends StatelessWidget {
  const CaseStudyOverviewSection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    final overview = study.overview;
    final isDesktop = Responsive.isDesktop(context);

    return CaseStudyChapter(
      id: 'overview',
      eyebrow: 'Client overview',
      title: 'Who we worked with.',
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    overview.summary,
                    style: AppTypography.bodyLargeStyle.copyWith(height: 1.65),
                  ),
                ),
                const SizedBox(width: AppSpacing.xxl),
                Expanded(flex: 4, child: _Facts(overview: overview)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overview.summary,
                  style: AppTypography.bodyLargeStyle.copyWith(height: 1.65),
                ),
                const SizedBox(height: AppSpacing.xl),
                _Facts(overview: overview),
              ],
            ),
    );
  }
}

class _Facts extends StatelessWidget {
  const _Facts({required this.overview});

  final CaseStudyOverview overview;

  @override
  Widget build(BuildContext context) {
    final rows = [
      ('Industry', overview.industry),
      ('Location', overview.location),
      ('Size', overview.companySize),
      ('Engagement', overview.engagement),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: const BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.xlAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            _FactRow(label: rows[i].$1, value: rows[i].$2),
            if (i != rows.length - 1) const SizedBox(height: AppSpacing.md),
          ],
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Scope',
            style: AppTypography.captionStyle.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textTertiary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final service in overview.services)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    service,
                    style: AppTypography.captionStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 96,
          child: Text(
            label,
            style: AppTypography.captionStyle.copyWith(
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTypography.smallStyle.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class CaseStudyResearchSection extends StatelessWidget {
  const CaseStudyResearchSection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    return CaseStudyChapter(
      id: 'research',
      eyebrow: 'Research',
      title: 'What we learned before we designed.',
      child: Column(
        children: [
          for (var i = 0; i < study.research.length; i++) ...[
            _InsightCard(index: i + 1, insight: study.research[i]),
            if (i != study.research.length - 1)
              const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.index, required this.insight});

  final int index;
  final CaseStudyInsight insight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: AppRadius.xlAll,
        color: AppColors.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '0$index',
            style: AppTypography.captionStyle.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(insight.title, style: AppTypography.bodyStrong.copyWith(fontSize: 18)),
          const SizedBox(height: AppSpacing.xs),
          Text(insight.body, style: AppTypography.bodyStyle.copyWith(fontSize: 16)),
        ],
      ),
    );
  }
}

class CaseStudyStrategySection extends StatelessWidget {
  const CaseStudyStrategySection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    return CaseStudyChapter(
      id: 'strategy',
      eyebrow: 'Strategy',
      title: 'The decisions that shaped everything else.',
      child: Column(
        children: [
          for (var i = 0; i < study.strategy.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.accentSubtle,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${i + 1}',
                    style: AppTypography.bodyStrong.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        study.strategy[i].title,
                        style: AppTypography.bodyStrong.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        study.strategy[i].body,
                        style: AppTypography.bodyStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (i != study.strategy.length - 1)
              const SizedBox(height: AppSpacing.xl),
          ],
        ],
      ),
    );
  }
}

class CaseStudyMetricsSection extends StatelessWidget {
  const CaseStudyMetricsSection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.isDesktop(context)
        ? 4
        : Responsive.isTablet(context)
            ? 2
            : 1;

    return CaseStudyChapter(
      id: 'metrics',
      eyebrow: 'Metrics',
      title: 'Proof, not decoration.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          const gap = AppSpacing.md;
          final width = columns == 1
              ? constraints.maxWidth
              : (constraints.maxWidth - gap * (columns - 1)) / columns;
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (final metric in study.metrics)
                SizedBox(
                  width: width,
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceMuted,
                      borderRadius: AppRadius.xlAll,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedCounter.fromMetricString(
                          metric.value,
                          style: AppTypography.headingLStyle.copyWith(
                            fontSize: 40,
                            letterSpacing: -1,
                          ),
                          semanticLabel: '${metric.label} ${metric.value}',
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          metric.label,
                          style: AppTypography.bodyStrong.copyWith(fontSize: 16),
                        ),
                        if (metric.caption != null) ...[
                          const SizedBox(height: 4),
                          Text(metric.caption!, style: AppTypography.captionStyle),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
