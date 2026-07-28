import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/reveal.dart';
import '../../domain/models.dart';
import '../providers/content_providers.dart';
import '../widgets/content_page_scaffold.dart';

class PricingPage extends ConsumerWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(pricingProvider);
    final columns = Responsive.isDesktop(context)
        ? 3
        : Responsive.isTablet(context)
            ? 2
            : 1;

    return ContentPageScaffold(
      landmark: 'Pricing',
      eyebrow: 'Pricing',
      title: 'Clear engagement shapes.',
      subtitle:
          'No mystery retainers. Pick a system — discovery confirms scope '
          'and fit.',
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = AppSpacing.lg;
              final width = columns == 1
                  ? constraints.maxWidth
                  : (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < plans.length; i++)
                    SizedBox(
                      width: width,
                      child: Reveal(
                        delay: Duration(milliseconds: 80 * i),
                        child: _PlanCard(plan: plans[i]),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.xxxl),
          Text(
            'Every engagement starts with a discovery call — even if the '
            'honest next step isn’t us.',
            textAlign: TextAlign.center,
            style: AppTypography.smallStyle,
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan});

  final PricingPlan plan;

  @override
  Widget build(BuildContext context) {
    final highlighted = plan.highlighted;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: highlighted ? AppColors.textPrimary : AppColors.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(
          color: highlighted ? AppColors.textPrimary : AppColors.border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (highlighted)
              Text(
                'MOST CHOSEN',
                style: AppTypography.captionStyle.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            if (highlighted) const SizedBox(height: AppSpacing.sm),
            Text(
              plan.name,
              style: AppTypography.headingSStyle.copyWith(
                color: highlighted ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              plan.priceLabel,
              style: AppTypography.headingMStyle.copyWith(
                fontSize: 36,
                color: highlighted ? Colors.white : AppColors.textPrimary,
              ),
            ),
            Text(
              plan.cadence,
              style: AppTypography.captionStyle.copyWith(
                color: highlighted
                    ? Colors.white70
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              plan.summary,
              style: AppTypography.smallStyle.copyWith(
                height: 1.5,
                color: highlighted
                    ? Colors.white.withValues(alpha: 0.85)
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            for (final item in plan.includes) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: highlighted ? AppColors.accent : AppColors.accent,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      item,
                      style: AppTypography.bodyStyle.copyWith(
                        color: highlighted
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: plan.ctaLabel,
              expand: true,
              variant: highlighted
                  ? AppButtonVariant.onDark
                  : AppButtonVariant.secondary,
              onPressed: () => context.go(AppRoutes.contact),
            ),
          ],
        ),
      ),
    );
  }
}
