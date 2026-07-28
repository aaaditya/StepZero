import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/curves.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_elevation.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/section_header.dart';

class _CaseStudy {
  const _CaseStudy({
    required this.name,
    required this.industry,
    required this.problem,
    required this.solution,
    required this.results,
    required this.metrics,
    required this.accent,
  });

  final String name;
  final String industry;
  final String problem;
  final String solution;
  final String results;
  final List<(String, String)> metrics;
  final Color accent;
}

/// Large horizontal transformation stories — not a portfolio tile grid.
class FeaturedWorkSection extends StatelessWidget {
  const FeaturedWorkSection({super.key});

  static const _cases = <_CaseStudy>[
    _CaseStudy(
      name: 'Northside Clinic',
      industry: 'Healthcare',
      problem: 'Looked interchangeable online. Booking lived in phone tag.',
      solution: 'Brand system, premium site, AI intake + WhatsApp follow-ups.',
      results: 'Patients now self-qualify before they ever call the desk.',
      metrics: [('Bookings', '+142%'), ('No-shows', '-38%'), ('Rating', '4.9')],
      accent: AppColors.accent,
    ),
    _CaseStudy(
      name: 'Oven & Oak',
      industry: 'Restaurant',
      problem: 'Beautiful room, forgettable digital presence, dead hours midweek.',
      solution: 'Identity refresh, site + QR menu, review engine, local SEO.',
      results: 'Weeknight covers filled. Brand finally matched the plating.',
      metrics: [('Covers', '+87%'), ('Orders', '+164%'), ('Search', 'Top 3')],
      accent: Color(0xFF0F766E),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      maxWidth: 1440,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            eyebrow: 'Featured transformations',
            title: 'Proof that order beats tactics.',
            subtitle:
                'Each engagement is a business system — brand, presence, automation, growth — told as a transformation, not a moodboard.',
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
          for (var i = 0; i < _cases.length; i++) ...[
            _CaseStudyCard(study: _cases[i], reverse: i.isOdd),
            if (i != _cases.length - 1) const SizedBox(height: AppSpacing.xxl),
          ],
          if (!Responsive.isDesktop(context)) ...[
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'View all work',
              variant: AppButtonVariant.secondary,
              expand: true,
              onPressed: () => context.go(AppRoutes.work),
            ),
          ],
        ],
      ),
    );
  }
}

class _CaseStudyCard extends StatefulWidget {
  const _CaseStudyCard({required this.study, required this.reverse});

  final _CaseStudy study;
  final bool reverse;

  @override
  State<_CaseStudyCard> createState() => _CaseStudyCardState();
}

class _CaseStudyCardState extends State<_CaseStudyCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final study = widget.study;

    final copy = _CaseCopy(study: study);
    final mockups = _DeviceCluster(accent: study.accent, hovered: _hovered);

    final row = isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.reverse
                ? [
                    Expanded(flex: 55, child: mockups),
                    const SizedBox(width: AppSpacing.xxl),
                    Expanded(flex: 45, child: copy),
                  ]
                : [
                    Expanded(flex: 45, child: copy),
                    const SizedBox(width: AppSpacing.xxl),
                    Expanded(flex: 55, child: mockups),
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
        duration: const Duration(milliseconds: 280),
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

  final _CaseStudy study;

  @override
  Widget build(BuildContext context) {
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
            study.industry,
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
        _LabeledBlock(label: 'Problem', body: study.problem),
        const SizedBox(height: AppSpacing.md),
        _LabeledBlock(label: 'Solution', body: study.solution),
        const SizedBox(height: AppSpacing.md),
        _LabeledBlock(label: 'Results', body: study.results),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            for (final metric in study.metrics)
              _MetricChip(label: metric.$1, value: metric.$2),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        AppButton(
          label: 'View case study',
          size: AppButtonSize.sm,
          onPressed: () => context.go(AppRoutes.work),
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
            letterSpacing: 1.1,
            fontWeight: FontWeight.w600,
            color: AppColors.textTertiary,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(body, style: AppTypography.bodyStyle.copyWith(fontSize: 16)),
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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.mdAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTypography.headingSStyle.copyWith(
              fontSize: 22,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: AppTypography.captionStyle,
          ),
        ],
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
    return SizedBox(
      height: Responsive.isMobile(context) ? 260 : 340,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 280),
            curve: AppCurves.hover,
            left: hovered ? 8 : 16,
            top: 24,
            child: _LaptopMock(accent: accent),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 280),
            curve: AppCurves.hover,
            right: hovered ? 12 : 28,
            bottom: 8,
            child: _PhoneMock(accent: accent),
          ),
        ],
      ),
    );
  }
}

class _LaptopMock extends StatelessWidget {
  const _LaptopMock({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Responsive.isMobile(context) ? 240 : 320,
          height: Responsive.isMobile(context) ? 150 : 200,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(14),
            boxShadow: AppElevation.medium,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accent.withValues(alpha: 0.25),
                  AppColors.surface,
                  accent.withValues(alpha: 0.08),
                ],
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 140,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 64,
                  height: 22,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: Responsive.isMobile(context) ? 280 : 360,
          height: 10,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}

class _PhoneMock extends StatelessWidget {
  const _PhoneMock({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isMobile(context) ? 90 : 110,
      height: Responsive.isMobile(context) ? 180 : 220,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppElevation.high,
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: 28,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderStrong,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 8,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const Spacer(),
            Container(
              height: 24,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
