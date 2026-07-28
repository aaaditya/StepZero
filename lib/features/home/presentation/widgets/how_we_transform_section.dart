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
import '../../../content/domain/models.dart';
import '../../../content/presentation/providers/content_providers.dart';
import '../../../content/presentation/widgets/content_icons.dart';

/// How we transform businesses — sourced from Services catalog.
class HowWeTransformSection extends ConsumerWidget {
  const HowWeTransformSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(servicesProvider);
    final columns = Responsive.isDesktop(context)
        ? 2
        : Responsive.isTablet(context)
            ? 2
            : 1;

    return SectionLandmark(
      label: 'How we transform businesses',
      child: SectionContainer(
        maxWidth: 1200,
        backgroundColor: AppColors.surfaceMuted,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'Our systems',
              title: 'Four systems. One operating stack.',
              subtitle:
                  'Brand, presence, automation, and growth — installed in '
                  'order so the business feels premium and runs with clarity.',
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
                    for (var i = 0; i < services.length; i++)
                      SizedBox(
                        width: width,
                        child: Reveal(
                          delay: Duration(milliseconds: 80 * i),
                          child: _TransformCard(
                            service: services[i],
                            index: i,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TransformCard extends StatelessWidget {
  const _TransformCard({required this.service, required this.index});

  final ServiceOffering service;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${service.title}. ${service.summary}',
      child: ExpandableSurfaceCard(
        onTap: () => context.go(AppRoutes.service(service.slug)),
        padding: const EdgeInsets.all(AppSpacing.xl),
        expandedPadding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '0${index + 1}',
                  style: AppTypography.captionStyle.copyWith(
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(),
                Icon(
                  ContentIcons.resolve(service.iconKey),
                  color: AppColors.accent,
                  size: 22,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              service.title,
              style: AppTypography.headingSStyle.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              service.summary,
              style: AppTypography.smallStyle.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              service.detail,
              style: AppTypography.bodyStyle.copyWith(fontSize: 16, height: 1.55),
            ),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final item in service.outcomes)
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
                      item,
                      style: AppTypography.captionStyle.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Learn more →',
              style: AppTypography.buttonLabel.copyWith(color: AppColors.accent),
            ),
          ],
        ),
      ),
    );
  }
}
