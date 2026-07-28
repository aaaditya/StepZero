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
import '../../../../core/widgets/expandable_surface_card.dart';
import '../../domain/models.dart';
import '../providers/content_providers.dart';
import '../widgets/content_icons.dart';
import '../widgets/content_page_scaffold.dart';

class IndustriesPage extends ConsumerWidget {
  const IndustriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final industries = ref.watch(industriesProvider);
    final columns = Responsive.isDesktop(context)
        ? 4
        : Responsive.isTablet(context)
            ? 2
            : 1;

    return ContentPageScaffold(
      landmark: 'Industries',
      eyebrow: 'Industries',
      title: 'Built for local businesses that want to feel premium.',
      subtitle:
          'Same craft as global brands — tuned to the economics and rituals '
          'of your category.',
      backgroundColor: AppColors.surfaceMuted,
      child: LayoutBuilder(
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
                  child: _IndustryCard(industry: industries[i], index: i)
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: 50 * i),
                        duration: 420.ms,
                        curve: AppCurves.enter,
                      ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class IndustryDetailPage extends ConsumerWidget {
  const IndustryDetailPage({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final industry = ref.watch(industryProvider(slug));
    if (industry == null) {
      return const ContentEmptyState(title: 'Industry not found');
    }

    return ContentPageScaffold(
      landmark: industry.name,
      eyebrow: 'Industry',
      title: industry.name,
      subtitle: industry.insight,
      ctaLabel: 'Talk about your category',
      maxWidth: 800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            ContentIcons.resolve(industry.iconKey),
            color: AppColors.accent,
            size: 28,
          ),
          const SizedBox(height: AppSpacing.xl),
          ContentProse(text: industry.body),
          if (industry.proofPoints.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xxxl),
            Text('What we typically ship', style: AppTypography.headingSStyle),
            const SizedBox(height: AppSpacing.lg),
            for (final point in industry.proofPoints) ...[
              Row(
                children: [
                  const Icon(
                    Icons.arrow_outward_rounded,
                    size: 16,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(point, style: AppTypography.bodyLargeStyle),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ],
          const SizedBox(height: AppSpacing.xxl),
          TextButton(
            onPressed: () => context.go(AppRoutes.industries),
            child: const Text('← All industries'),
          ),
        ],
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
    );
  }
}
