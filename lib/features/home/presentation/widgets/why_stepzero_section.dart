import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/curves.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';

class _Comparison {
  const _Comparison({
    required this.typical,
    required this.stepZero,
  });

  final String typical;
  final String stepZero;
}

/// Differentiation via contrast — four decisive rows + mid-funnel CTA.
class WhyStepZeroSection extends StatelessWidget {
  const WhyStepZeroSection({super.key});

  static const _rows = <_Comparison>[
    _Comparison(
      typical: 'Builds websites',
      stepZero: 'Builds business systems',
    ),
    _Comparison(
      typical: 'Starts with pixels',
      stepZero: 'Starts with identity & economics',
    ),
    _Comparison(
      typical: 'Hands off at launch',
      stepZero: 'Compounds after launch',
    ),
    _Comparison(
      typical: 'Unlimited clients',
      stepZero: 'Limited projects / quarter',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return SectionLandmark(
      label: 'Why StepZero',
      child: SectionContainer(
        maxWidth: 1100,
        child: Column(
          children: [
            const SectionHeader(
              eyebrow: 'Why StepZero',
              title: 'The difference is the operating system.',
              subtitle:
                  'Most agencies optimize deliverables. We install the order '
                  'that makes deliverables matter.',
              alignment: CrossAxisAlignment.center,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            if (isDesktop) const _ColumnLabels(),
            if (isDesktop) const SizedBox(height: AppSpacing.lg),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppRadius.xxlAll,
                border: Border.all(color: AppColors.border),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  for (var i = 0; i < _rows.length; i++)
                    _ComparisonRow(
                      comparison: _rows[i],
                      index: i,
                      isLast: i == _rows.length - 1,
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),
            AppButton(
              label: 'Start a project',
              size: AppButtonSize.lg,
              magnetic: true,
              pulse: true,
              onPressed: () => context.go(AppRoutes.contact),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColumnLabels extends StatelessWidget {
  const _ColumnLabels();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Typical agency',
              style: AppTypography.captionStyle.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
                color: AppColors.textTertiary,
              ),
            ),
          ),
          const SizedBox(width: 48),
          Expanded(
            child: Text(
              'StepZero',
              style: AppTypography.captionStyle.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
                color: AppColors.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatefulWidget {
  const _ComparisonRow({
    required this.comparison,
    required this.index,
    required this.isLast,
  });

  final _Comparison comparison;
  final int index;
  final bool isLast;

  @override
  State<_ComparisonRow> createState() => _ComparisonRowState();
}

class _ComparisonRowState extends State<_ComparisonRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop =
        Responsive.isDesktop(context) || Responsive.isTablet(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: AppCurves.hover,
        padding: EdgeInsets.symmetric(
          horizontal:
              Responsive.isMobile(context) ? AppSpacing.lg : AppSpacing.xl,
          vertical: AppSpacing.xl,
        ),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.accentSubtle.withValues(alpha: 0.45)
              : AppColors.surface,
          border: widget.isLast
              ? null
              : const Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.comparison.typical,
                      style: AppTypography.bodyStyle.copyWith(
                        color: AppColors.textTertiary,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColors.borderStrong,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  Expanded(
                    child: Text(
                      widget.comparison.stepZero,
                      style: AppTypography.bodyStrong.copyWith(
                        fontSize: 17,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Typical',
                    style: AppTypography.captionStyle.copyWith(
                      color: AppColors.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.comparison.typical,
                    style: AppTypography.bodyStyle.copyWith(
                      color: AppColors.textTertiary,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'StepZero',
                    style: AppTypography.captionStyle.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.comparison.stepZero,
                    style: AppTypography.bodyStrong,
                  ),
                ],
              ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 60 * widget.index),
          duration: 420.ms,
          curve: AppCurves.enter,
        );
  }
}
