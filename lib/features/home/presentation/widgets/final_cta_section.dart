import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/animations/parallax.dart';
import '../../../../core/constants/app_layout.dart';
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

/// Inevitable close — calm invitation, not a hard sell banner.
class FinalCtaSection extends StatelessWidget {
  const FinalCtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final titleSize = Responsive.fluidFontSize(
      context,
      desktop: 52,
      tablet: 40,
      mobile: 30,
    );

    return SectionLandmark(
      label: 'Call to action',
      child: SectionContainer(
        maxWidth: 1000,
        child: ClipRRect(
          borderRadius: AppRadius.xxlAll,
          child: DriftingGradient(
            duration: const Duration(seconds: 12),
            borderRadius: AppRadius.xxlAll,
            colors: [
              AppColors.textPrimary,
              const Color(AppLayout.ctaMid),
              AppColors.accent.withValues(alpha: 0.9),
            ],
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context)
                    ? AppSpacing.lg
                    : AppSpacing.xxxl,
                vertical: Responsive.isMobile(context)
                    ? AppSpacing.xxxl
                    : AppSpacing.section,
              ),
              decoration: BoxDecoration(
                borderRadius: AppRadius.xxlAll,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.22),
                    blurRadius: 48,
                    offset: const Offset(0, 24),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Ready to become the brand people trust?',
                    textAlign: TextAlign.center,
                    style: AppTypography.headingXlStyle.copyWith(
                      fontSize: titleSize,
                      color: AppColors.textInverse,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                      letterSpacing: -1.2,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 540),
                    child: Text(
                      'Tell us where you are — brand, website, growth, or chaos. '
                      'We’ll tell you the honest next step.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyLargeStyle.copyWith(
                        color: AppColors.textInverse.withValues(alpha: 0.82),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Responsive.isMobile(context)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppButton(
                              label: 'Start a project',
                              expand: true,
                              magnetic: true,
                              pulse: true,
                              onPressed: () => context.go(AppRoutes.contact),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            AppButton(
                              label: 'View our work',
                              variant: AppButtonVariant.onDark,
                              expand: true,
                              onPressed: () => context.go(AppRoutes.work),
                            ),
                          ],
                        )
                      : Wrap(
                          alignment: WrapAlignment.center,
                          spacing: AppSpacing.md,
                          runSpacing: AppSpacing.sm,
                          children: [
                            AppButton(
                              label: 'Start a project',
                              size: AppButtonSize.lg,
                              magnetic: true,
                              pulse: true,
                              onPressed: () => context.go(AppRoutes.contact),
                            ),
                            AppButton(
                              label: 'View our work',
                              variant: AppButtonVariant.onDark,
                              size: AppButtonSize.lg,
                              onPressed: () => context.go(AppRoutes.work),
                            ),
                          ],
                        ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Limited projects each quarter.',
                    textAlign: TextAlign.center,
                    style: AppTypography.captionStyle.copyWith(
                      color: AppColors.textInverse.withValues(alpha: 0.78),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 550.ms, curve: AppCurves.enter)
            .moveY(begin: 18, end: 0, duration: 600.ms, curve: AppCurves.enter),
      ),
    );
  }
}
