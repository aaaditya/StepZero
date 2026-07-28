import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/curves.dart';
import '../../../../core/constants/durations.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/pill_badge.dart';
import '../../../../core/widgets/trust_indicator.dart';

/// Left-column hero narrative — belief, outcome, action.
class HeroCopyColumn extends StatelessWidget {
  const HeroCopyColumn({
    this.expandButtons = false,
    super.key,
  });

  /// Full-width CTAs on mobile.
  final bool expandButtons;

  static const List<String> trustLabels = [
    'Strategy before website',
    'Limited projects / quarter',
    'Compound, don’t hand off',
  ];

  @override
  Widget build(BuildContext context) {
    final headlineSize = Responsive.fluidFontSize(
      context,
      desktop: 64,
      tablet: 48,
      mobile: 36,
    );

    final headlineStyle = AppTypography.displayHero.copyWith(
      fontSize: headlineSize,
      fontWeight: FontWeight.w700,
      height: 1.05,
      letterSpacing: -1.8,
      color: AppColors.textPrimary,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const PillBadge(
          label: 'Brand before traffic',
          backgroundColor: AppColors.accentSubtle,
          foregroundColor: AppColors.accent,
          borderColor: AppColors.accent,
          leading: Icon(Icons.north_east_rounded, size: 14, color: AppColors.accent),
        )
            .animate()
            .fadeIn(duration: 500.ms, curve: AppCurves.enter)
            .moveY(begin: 18, end: 0, duration: 550.ms, curve: AppCurves.enter),
        const SizedBox(height: AppSpacing.lg),
        _StaggeredHeadline(
          lines: const [
            'We build businesses',
            'people trust.',
          ],
          style: headlineStyle,
          accentLineIndex: 1,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'We turn local operators into premium brands — '
          'and install the systems that make that growth compound.',
          style: AppTypography.bodyLargeStyle.copyWith(
            fontSize: Responsive.fluidFontSize(
              context,
              desktop: 19,
              tablet: 17,
              mobile: 16,
            ),
            height: 1.55,
            color: AppColors.textSecondary,
          ),
        )
            .animate()
            .fadeIn(delay: 380.ms, duration: 500.ms, curve: AppCurves.enter),
        const SizedBox(height: AppSpacing.xl),
        _HeroCtaRow(expand: expandButtons)
            .animate()
            .fadeIn(delay: 480.ms, duration: 450.ms)
            .moveY(
              begin: 16,
              end: 0,
              delay: 480.ms,
              duration: 500.ms,
              curve: AppCurves.enter,
            ),
        const SizedBox(height: AppSpacing.xl),
        const TrustIndicatorRow(labels: trustLabels)
            .animate()
            .fadeIn(delay: 620.ms, duration: 450.ms, curve: AppCurves.enter),
      ],
    );
  }
}

class _StaggeredHeadline extends StatelessWidget {
  const _StaggeredHeadline({
    required this.lines,
    required this.style,
    this.accentLineIndex,
  });

  final List<String> lines;
  final TextStyle style;
  final int? accentLineIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < lines.length; i++)
          Text(
            lines[i],
            style: style.copyWith(
              color: i == accentLineIndex ? AppColors.accent : style.color,
            ),
          )
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: 140 + (i * 90)),
                duration: 480.ms,
                curve: AppCurves.enter,
              )
              .moveY(
                begin: 14,
                end: 0,
                delay: Duration(milliseconds: 140 + (i * 90)),
                duration: 520.ms,
                curve: AppCurves.enter,
              ),
      ],
    );
  }
}

class _HeroCtaRow extends StatelessWidget {
  const _HeroCtaRow({required this.expand});

  final bool expand;

  @override
  Widget build(BuildContext context) {
    final primary = AppButton(
      label: 'Start a project',
      size: AppButtonSize.lg,
      expand: expand,
      magnetic: true,
      pulse: true,
      onPressed: () => context.go(AppRoutes.contact),
    );

    final secondary = AppButton(
      label: 'View our work',
      variant: AppButtonVariant.secondary,
      size: AppButtonSize.lg,
      expand: expand,
      onPressed: () => context.go(AppRoutes.work),
    );

    if (expand) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          primary,
          const SizedBox(height: AppSpacing.sm),
          secondary,
        ],
      );
    }

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: [primary, secondary],
    );
  }
}

/// Timing constants — keep total entrance under ~1200ms.
abstract final class HeroMotion {
  static const Duration totalBudget = Duration(milliseconds: 1200);
  static const Duration navFade = AppDurations.slow;
  static const Duration badge = Duration(milliseconds: 550);
  static const Duration headline = Duration(milliseconds: 520);
  static const Duration cta = Duration(milliseconds: 500);
}
