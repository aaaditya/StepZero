import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/curves.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../content/presentation/pages/faq_page.dart';
import '../../../content/presentation/providers/content_providers.dart';

/// Minimal accordion — sourced from FAQs catalog.
class FaqSection extends ConsumerStatefulWidget {
  const FaqSection({super.key});

  @override
  ConsumerState<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends ConsumerState<FaqSection> {
  int? _openIndex = 0;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(featuredFaqsProvider);

    return SectionLandmark(
      label: 'Frequently asked questions',
      child: SectionContainer(
        maxWidth: 800,
        backgroundColor: AppColors.surfaceMuted,
        child: Column(
          children: [
            const SectionHeader(
              eyebrow: 'FAQ',
              title: 'Straight answers.',
              subtitle: 'No pitch theater. Just what operators usually ask.',
              alignment: CrossAxisAlignment.center,
            ),
            const SizedBox(height: AppSpacing.xxxl),
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
