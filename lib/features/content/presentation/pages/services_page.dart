import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/expandable_surface_card.dart';
import '../../../../core/widgets/reveal.dart';
import '../../domain/models.dart';
import '../providers/content_providers.dart';
import '../widgets/content_icons.dart';
import '../widgets/content_page_scaffold.dart';

class ServicesPage extends ConsumerWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(servicesProvider);
    final columns = Responsive.isDesktop(context)
        ? 2
        : Responsive.isTablet(context)
            ? 2
            : 1;

    return ContentPageScaffold(
      landmark: 'Services',
      eyebrow: 'Services',
      title: 'How we transform businesses.',
      subtitle:
          'Four systems. One outcome: a local business that feels premium '
          'and runs with clarity.',
      ctaLabel: 'Book a discovery call',
      child: LayoutBuilder(
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
                    child: _ServiceCard(service: services[i], index: i),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class ServiceDetailPage extends ConsumerWidget {
  const ServiceDetailPage({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(serviceProvider(slug));
    if (service == null) {
      return const ContentEmptyState(title: 'Service not found');
    }

    return ContentPageScaffold(
      landmark: service.title,
      eyebrow: 'Service',
      title: service.title,
      subtitle: service.summary,
      ctaLabel: 'Start with this system',
      maxWidth: 800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            ContentIcons.resolve(service.iconKey),
            color: AppColors.accent,
            size: 28,
          ),
          const SizedBox(height: AppSpacing.xl),
          ContentProse(text: service.detail),
          const SizedBox(height: AppSpacing.xxxl),
          Text('Outcomes', style: AppTypography.headingSStyle),
          const SizedBox(height: AppSpacing.lg),
          for (final outcome in service.outcomes) ...[
            Row(
              children: [
                const Icon(Icons.check_rounded, size: 18, color: AppColors.accent),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(outcome, style: AppTypography.bodyLargeStyle),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          const SizedBox(height: AppSpacing.xxl),
          TextButton(
            onPressed: () => context.go(AppRoutes.services),
            child: const Text('← All services'),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service, required this.index});

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
            Text(service.summary, style: AppTypography.smallStyle),
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
              'Explore →',
              style: AppTypography.buttonLabel.copyWith(color: AppColors.accent),
            ),
          ],
        ),
      ),
    );
  }
}
