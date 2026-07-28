import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/reveal.dart';
import '../../domain/models.dart';
import '../providers/content_providers.dart';
import '../widgets/content_page_scaffold.dart';

class TestimonialsPage extends ConsumerWidget {
  const TestimonialsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(testimonialsProvider);

    return ContentPageScaffold(
      landmark: 'Testimonials',
      eyebrow: 'Testimonials',
      title: 'Operators, in their own words.',
      subtitle:
          'Proof as voice — not star ratings. Each quote sits next to a '
          'real transformation.',
      ctaLabel: 'Start a project',
      maxWidth: 880,
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            Reveal(
              delay: Duration(milliseconds: 70 * i),
              child: _TestimonialBlock(item: items[i]),
            ),
            if (i != items.length - 1) const SizedBox(height: AppSpacing.xl),
          ],
        ],
      ),
    );
  }
}

class _TestimonialBlock extends StatelessWidget {
  const _TestimonialBlock({required this.item});

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
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.industry != null) ...[
              ContentMetaPill(label: item.industry!),
              const SizedBox(height: AppSpacing.lg),
            ],
            Text(
              '“${item.quote}”',
              style: AppTypography.headingSStyle.copyWith(
                fontSize: 24,
                height: 1.45,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              item.name,
              style: AppTypography.bodyStrong.copyWith(fontSize: 16),
            ),
            Text(
              '${item.role}, ${item.company}',
              style: AppTypography.smallStyle,
            ),
          ],
        ),
      ),
    );
  }
}
