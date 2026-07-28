import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/curves.dart';
import '../../../../core/constants/durations.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/seo/page_meta.dart';
import '../../../../core/seo/seo_effect.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models.dart';
import '../providers/content_providers.dart';
import '../widgets/content_page_scaffold.dart';

class FaqPage extends ConsumerStatefulWidget {
  const FaqPage({super.key});

  @override
  ConsumerState<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends ConsumerState<FaqPage> {
  int? _openIndex = 0;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(faqsProvider);

    return SeoEffect(
      meta: PageMeta(
        title: 'FAQ · StepZero',
        description:
            'Straight answers about engagements, timelines, and how StepZero works.',
        path: AppRoutes.faq,
        jsonLd: StructuredData.faq([
          for (final item in items) (q: item.question, a: item.answer),
        ]),
      ),
      child: ContentPageScaffold(
      landmark: 'FAQ',
      eyebrow: 'FAQ',
      title: 'Straight answers.',
      subtitle: 'No pitch theater. Just what operators usually ask.',
      maxWidth: 800,
      backgroundColor: AppColors.surfaceMuted,
      ctaLabel: 'Book a discovery call',
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            FaqAccordionTile(
              item: items[i],
              expanded: _openIndex == i,
              onTap: () => setState(() {
                _openIndex = _openIndex == i ? null : i;
              }),
            )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 50 * i),
                  duration: 400.ms,
                  curve: AppCurves.enter,
                ),
            if (i != items.length - 1) const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    ),
    );
  }
}

/// Reusable accordion tile — homepage FAQ uses the same widget.
class FaqAccordionTile extends StatelessWidget {
  const FaqAccordionTile({
    required this.item,
    required this.expanded,
    required this.onTap,
    super.key,
  });

  final FaqItem item;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDurations.normal,
      curve: AppCurves.standard,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(
          color: expanded ? AppColors.borderStrong : AppColors.border,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.xlAll,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.lg,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.question,
                        style: AppTypography.bodyStrong.copyWith(fontSize: 17),
                      ),
                    ),
                    AnimatedRotation(
                      turns: expanded ? 0.125 : 0,
                      duration: AppDurations.fast,
                      child: const Icon(
                        Icons.add,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox(width: double.infinity),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.md),
                    child: Text(
                      item.answer,
                      style: AppTypography.bodyStyle.copyWith(fontSize: 16),
                    ),
                  ),
                  crossFadeState: expanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: AppDurations.normal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
