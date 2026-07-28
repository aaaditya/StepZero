import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../content/domain/models.dart';
import '../../../content/presentation/providers/content_providers.dart';

/// Homepage testimonials teaser — sourced from Testimonials catalog.
class TestimonialsSection extends ConsumerWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(featuredTestimonialsProvider);
    final isDesktop = Responsive.isDesktop(context);

    return SectionLandmark(
      label: 'Testimonials',
      child: SectionContainer(
        maxWidth: 1100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              eyebrow: 'Testimonials',
              title: 'Operators, in their own words.',
              subtitle: 'Proof as voice — not star ratings.',
              action: isDesktop
                  ? TextButton(
                      onPressed: () => context.go(AppRoutes.testimonials),
                      child: const Text('All testimonials →'),
                    )
                  : null,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = isDesktop ? 2 : 1;
                const gap = AppSpacing.lg;
                final width = columns == 1
                    ? constraints.maxWidth
                    : (constraints.maxWidth - gap) / 2;
                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (var i = 0; i < items.length; i++)
                      SizedBox(
                        width: width,
                        child: Reveal(
                          delay: Duration(milliseconds: 80 * i),
                          child: _QuoteCard(item: items[i]),
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

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({required this.item});

  final Testimonial item;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '“${item.quote}”',
              style: AppTypography.bodyLargeStyle.copyWith(
                height: 1.55,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(item.name, style: AppTypography.bodyStrong),
            Text(
              '${item.role}, ${item.company}',
              style: AppTypography.captionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
