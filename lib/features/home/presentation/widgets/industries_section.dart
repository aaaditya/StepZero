import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/curves.dart';
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

/// Domain literacy grid — sourced from Industries catalog.
class IndustriesSection extends ConsumerWidget {
  const IndustriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final industries = ref.watch(industriesProvider);
    final columns = Responsive.isDesktop(context)
        ? 4
        : Responsive.isTablet(context)
            ? 2
            : 1;

    return SectionLandmark(
      label: 'Industries',
      child: SectionContainer(
        maxWidth: 1200,
        backgroundColor: AppColors.surfaceMuted,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              eyebrow: 'Industries',
              title: 'Built for local businesses that want to feel premium.',
              subtitle:
                  'Same craft as global brands — tuned to the economics and rituals of your category.',
              action: Responsive.isDesktop(context)
                  ? TextButton(
                      onPressed: () => context.go(AppRoutes.industries),
                      child: const Text('All industries →'),
                    )
                  : null,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            LayoutBuilder(
              builder: (context, constraints) {
                const gap = AppSpacing.md;
                final width = columns == 1
                    ? constraints.maxWidth
                    : (constraints.maxWidth - gap * (columns - 1)) / columns;
                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (var i = 0; i < industries.length; i++)
                      SizedBox(
                        width: width,
                        child: _IndustryCard(
                          industry: industries[i],
                          index: i,
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

class _IndustryCard extends StatelessWidget {
  const _IndustryCard({required this.industry, required this.index});

  final Industry industry;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpandableSurfaceCard(
      onTap: () => context.go(AppRoutes.industry(industry.slug)),
      padding: const EdgeInsets.all(AppSpacing.lg),
      expandScale: 1.025,
      translateY: -4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            ContentIcons.resolve(industry.iconKey),
            size: 22,
            color: AppColors.accent,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            industry.name,
            style: AppTypography.bodyStrong.copyWith(fontSize: 18),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            industry.insight,
            style: AppTypography.captionStyle.copyWith(height: 1.45),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 50 * index),
          duration: 420.ms,
          curve: AppCurves.enter,
        )
        .moveY(
          begin: 12,
          end: 0,
          delay: Duration(milliseconds: 50 * index),
          duration: 450.ms,
          curve: AppCurves.enter,
        );
  }
}
