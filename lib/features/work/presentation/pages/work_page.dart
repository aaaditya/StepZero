import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/expandable_surface_card.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../shared/layout/page_body.dart';
import '../../domain/case_study.dart';
import '../providers/case_study_providers.dart';

/// Work index — transformations, not a portfolio dump.
class WorkPage extends ConsumerWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studies = ref.watch(caseStudiesProvider);
    final columns = Responsive.isDesktop(context)
        ? 2
        : 1;

    return SectionLandmark(
      label: 'Work',
      child: PageBody(
        child: SectionContainer(
          maxWidth: 1200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                eyebrow: 'Work',
                title: 'Transformations, told completely.',
                subtitle:
                    'Each case study is a business system narrative — challenge, '
                    'judgment, craft, and measurable change.',
              ),
              const SizedBox(height: AppSpacing.xxxl),
              LayoutBuilder(
                builder: (context, constraints) {
                  const gap = AppSpacing.lg;
                  final width = columns == 1
                      ? constraints.maxWidth
                      : (constraints.maxWidth - gap) / 2;
                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: [
                      for (var i = 0; i < studies.length; i++)
                        SizedBox(
                          width: width,
                          child: Reveal(
                            delay: Duration(milliseconds: 80 * i),
                            child: WorkIndexCard(study: studies[i]),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkIndexCard extends StatelessWidget {
  const WorkIndexCard({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${study.name}. ${study.headline}',
      child: ExpandableSurfaceCard(
        onTap: () => context.go(AppRoutes.caseStudy(study.slug)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(study.accent),
                      Color(study.accent).withValues(alpha: 0.55),
                      AppColors.surfaceMuted,
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      study.overview.industry,
                      style: AppTypography.captionStyle.copyWith(
                        color: AppColors.textInverse,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(study.name, style: AppTypography.headingSStyle.copyWith(fontSize: 24)),
            const SizedBox(height: AppSpacing.sm),
            Text(study.headline, style: AppTypography.bodyStyle.copyWith(fontSize: 16)),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final metric in study.heroMetrics.take(3))
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentSubtle,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '${metric.label} ${metric.value}',
                      style: AppTypography.captionStyle.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Read case study →',
              style: AppTypography.buttonLabel.copyWith(color: AppColors.accent),
            ),
          ],
        ),
      ),
    );
  }
}
