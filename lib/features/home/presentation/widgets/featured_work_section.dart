import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_layout.dart';
import '../../../../core/constants/curves.dart';
import '../../../../core/constants/durations.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_elevation.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/animated_counter.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/expandable_surface_card.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../work/domain/case_study.dart';
import '../../../work/presentation/providers/case_study_providers.dart';

/// Large horizontal transformation stories — sourced from case study catalog.
class FeaturedWorkSection extends ConsumerWidget {
  const FeaturedWorkSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studies = ref.watch(caseStudiesProvider);

    return SectionLandmark(
      label: 'Featured transformations',
      child: SectionContainer(
        maxWidth: AppLayout.pageMaxWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              eyebrow: 'Featured transformations',
              title: 'Proof that order beats tactics.',
              subtitle:
                  'Each engagement is a business system — brand, presence, '
                  'automation, growth — told as a transformation, not a moodboard.',
              action: Responsive.isDesktop(context)
                  ? AppButton(
                      label: 'View all work',
                      variant: AppButtonVariant.secondary,
                      size: AppButtonSize.sm,
                      onPressed: () => context.go(AppRoutes.work),
                    )
                  : null,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            for (var i = 0; i < studies.length; i++) ...[
              _CaseStudyCard(study: studies[i], reverse: i.isOdd),
              if (i != studies.length - 1)
                const SizedBox(height: AppSpacing.xxl),
            ],
            if (!Responsive.isDesktop(context)) ...[
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                label: 'View all work',
                expand: true,
                variant: AppButtonVariant.secondary,
                onPressed: () => context.go(AppRoutes.work),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CaseStudyCard extends StatefulWidget {
  const _CaseStudyCard({required this.study, required this.reverse});

  final CaseStudy study;
  final bool reverse;

  @override
  State<_CaseStudyCard> createState() => _CaseStudyCardState();
}

class _CaseStudyCardState extends State<_CaseStudyCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final study = widget.study;
    final accent = Color(study.accent);
    final isDesktop = Responsive.isDesktop(context);

    final mockups = _DeviceCluster(accent: accent, hovered: _hovered);
    final copy = _CaseCopy(study: study);

    final row = isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.reverse
                ? [
                    Expanded(flex: 5, child: copy),
                    const SizedBox(width: AppSpacing.xxl),
                    Expanded(flex: 6, child: mockups),
                  ]
                : [
                    Expanded(flex: 6, child: mockups),
                    const SizedBox(width: AppSpacing.xxl),
                    Expanded(flex: 5, child: copy),
                  ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mockups,
              const SizedBox(height: AppSpacing.xl),
              copy,
            ],
          );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppDurations.normal,
        curve: AppCurves.hover,
        padding: EdgeInsets.all(
          Responsive.isMobile(context) ? AppSpacing.lg : AppSpacing.xxl,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.xxlAll,
          border: Border.all(
            color: _hovered ? AppColors.borderStrong : AppColors.border,
          ),
          boxShadow: _hovered ? AppElevation.medium : AppElevation.low,
        ),
        child: row,
      ),
    )
        .animate()
        .fadeIn(duration: 550.ms, curve: AppCurves.enter)
        .moveY(begin: 20, end: 0, duration: 600.ms, curve: AppCurves.enter);
  }
}

class _CaseCopy extends StatelessWidget {
  const _CaseCopy({required this.study});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    final metrics = study.heroMetrics.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            study.overview.industry,
            style: AppTypography.captionStyle.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          study.name,
          style: AppTypography.headingMStyle.copyWith(
            fontSize: Responsive.fluidFontSize(
              context,
              desktop: 36,
              tablet: 30,
              mobile: 26,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _LabeledBlock(label: 'Problem', body: study.challenge),
        const SizedBox(height: AppSpacing.md),
        _LabeledBlock(label: 'Solution', body: study.outcomeLine),
        const SizedBox(height: AppSpacing.md),
        _LabeledBlock(label: 'Results', body: study.resultsNarrative),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            for (final metric in metrics)
              _MetricChip(label: metric.label, value: metric.value),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        AppButton(
          label: 'View case study',
          variant: AppButtonVariant.secondary,
          size: AppButtonSize.sm,
          onPressed: () => context.go(AppRoutes.caseStudy(study.slug)),
        ),
      ],
    );
  }
}

class _LabeledBlock extends StatelessWidget {
  const _LabeledBlock({required this.label, required this.body});

  final String label;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTypography.captionStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          body,
          style: AppTypography.bodyStyle.copyWith(fontSize: 16),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label $value',
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedCounter.fromMetricString(
              value,
              style: AppTypography.headingSStyle.copyWith(
                fontSize: 22,
                color: AppColors.textPrimary,
              ),
              semanticLabel: value,
            ),
            Text(label, style: AppTypography.captionStyle),
          ],
        ),
      ),
    );
  }
}

class _DeviceCluster extends StatelessWidget {
  const _DeviceCluster({required this.accent, required this.hovered});

  final Color accent;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return HoverZoomMedia(
      scale: 1.03,
      borderRadius: AppRadius.xlAll,
      child: SizedBox(
        height: Responsive.isMobile(context) ? 260 : 340,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              duration: AppDurations.normal,
              curve: AppCurves.hover,
              left: hovered ? 8 : 16,
              top: 24,
              child: _LaptopMock(accent: accent),
            ),
            AnimatedPositioned(
              duration: AppDurations.normal,
              curve: AppCurves.hover,
              right: hovered ? 12 : 28,
              bottom: 8,
              child: _PhoneMock(accent: accent),
            ),
          ],
        ),
      ),
    );
  }
}

class _LaptopMock extends StatelessWidget {
  const _LaptopMock({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isMobile(context) ? 220 : 280,
      height: Responsive.isMobile(context) ? 150 : 190,
      decoration: const BoxDecoration(
        color: Color(AppLayout.chromeDark),
        borderRadius: AppRadius.lgAll,
      ),
      padding: const EdgeInsets.all(10),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.mdAll,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 8,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 48,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.borderStrong,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 10,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.textPrimary.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            height: 6,
                            width: 90,
                            decoration: BoxDecoration(
                              color: AppColors.textSecondary.withValues(alpha: 0.35),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 18,
                            width: 72,
                            decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              accent.withValues(alpha: 0.55),
                              accent.withValues(alpha: 0.2),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneMock extends StatelessWidget {
  const _PhoneMock({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 170,
      decoration: BoxDecoration(
        color: const Color(AppLayout.chromeMuted),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
        boxShadow: AppElevation.medium,
      ),
      padding: const EdgeInsets.all(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 6,
                width: 36,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        accent.withValues(alpha: 0.45),
                        AppColors.surfaceMuted,
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
