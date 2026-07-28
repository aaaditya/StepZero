import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/animations/parallax.dart';
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
      desktop: 56,
      tablet: 42,
      mobile: 32,
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
              const Color(0xFF1A1A2E),
              AppColors.accent.withValues(alpha: 0.9),
            ],
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal:
                    Responsive.isMobile(context) ? AppSpacing.lg : AppSpacing.xxxl,
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
                    'Ready to Leave Step Zero?',
                    textAlign: TextAlign.center,
                    style: AppTypography.headingXlStyle.copyWith(
                      fontSize: titleSize,
                      color: AppColors.textInverse,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Text(
                      'Let’s build a business customers remember.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyLargeStyle.copyWith(
                        color: AppColors.textInverse.withValues(alpha: 0.78),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Responsive.isMobile(context)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppButton(
                              label: 'Book Discovery Call',
                              expand: true,
                              magnetic: true,
                              pulse: true,
                              onPressed: () => context.go(AppRoutes.contact),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            AppButton(
                              label: 'See Our Work',
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
                              label: 'Book Discovery Call',
                              size: AppButtonSize.lg,
                              magnetic: true,
                              pulse: true,
                              onPressed: () => context.go(AppRoutes.contact),
                            ),
                            AppButton(
                              label: 'See Our Work',
                              variant: AppButtonVariant.onDark,
                              size: AppButtonSize.lg,
                              onPressed: () => context.go(AppRoutes.work),
                            ),
                          ],
                        ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Limited projects each quarter. Serious inquiries only.',
                    textAlign: TextAlign.center,
                    style: AppTypography.captionStyle.copyWith(
                      color: AppColors.textInverse.withValues(alpha: 0.55),
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
