import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/curves.dart';
import '../../../../core/constants/durations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/section_header.dart';

class _FaqItem {
  const _FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;
}

/// Minimal accordion — calm answers for purchase anxiety.
class FaqSection extends StatefulWidget {
  const FaqSection({super.key});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  static const _items = <_FaqItem>[
    _FaqItem(
      question: 'Do you only build websites?',
      answer:
          'No. Websites are one layer. We design the sequence — brand, presence, automation, and growth — so the site has something worth converting.',
    ),
    _FaqItem(
      question: 'How long does a typical engagement take?',
      answer:
          'Most transformation systems land in 8–14 weeks depending on scope. Growth retainers continue after launch so momentum compounds.',
    ),
    _FaqItem(
      question: 'What kinds of businesses do you work with?',
      answer:
          'Local operators who want to feel premium — restaurants, cafés, salons, clinics, gyms, retail, hotels, real estate, and focused startups.',
    ),
    _FaqItem(
      question: 'How many projects do you take?',
      answer:
          'A limited number each quarter. Constraint protects craft. If we’re full, we’ll tell you honestly and offer a waitlist.',
    ),
    _FaqItem(
      question: 'What happens on a discovery call?',
      answer:
          'We diagnose where you are on the journey — identity, presence, systems, growth — and tell you the honest next step, even if it isn’t us.',
    ),
  ];

  int? _openIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
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
          for (var i = 0; i < _items.length; i++) ...[
            _FaqTile(
              item: _items[i],
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
            if (i != _items.length - 1) const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({
    required this.item,
    required this.expanded,
    required this.onTap,
  });

  final _FaqItem item;
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
