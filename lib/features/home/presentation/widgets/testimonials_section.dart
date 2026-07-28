import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../content/domain/models.dart';
import '../../../content/presentation/providers/content_providers.dart';

/// Editorial testimonials — typography leads, not Material cards.
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
              eyebrow: 'Operators',
              title: 'In their own words.',
              subtitle:
                  'Owners who rebuilt identity, presence, and systems with us.',
              action: isDesktop
                  ? TextButton(
                      onPressed: () => context.go(AppRoutes.testimonials),
                      child: const Text('All testimonials →'),
                    )
                  : null,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            for (var i = 0; i < items.length; i++) ...[
              Reveal(
                delay: Duration(milliseconds: 80 * i),
                child: _QuoteBlock(item: items[i], featured: i == 0),
              ),
              if (i != items.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl),
                  child: Divider(color: AppColors.border, height: 1),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuoteBlock extends StatelessWidget {
  const _QuoteBlock({required this.item, required this.featured});

  final Testimonial item;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final quoteSize = featured
        ? Responsive.fluidFontSize(
            context,
            desktop: 32,
            tablet: 26,
            mobile: 22,
          )
        : Responsive.fluidFontSize(
            context,
            desktop: 24,
            tablet: 22,
            mobile: 20,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '“',
          style: AppTypography.displayHero.copyWith(
            fontSize: featured ? 72 : 48,
            height: 0.7,
            color: AppColors.accent.withValues(alpha: 0.35),
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          item.quote,
          style: AppTypography.headingSStyle.copyWith(
            fontSize: quoteSize,
            height: 1.35,
            letterSpacing: -0.6,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            Container(
              width: 28,
              height: 1,
              color: AppColors.accent,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: AppTypography.bodyStrong),
                  Text(
                    '${item.role}, ${item.company}',
                    style: AppTypography.captionStyle.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
