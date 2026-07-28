import 'package:flutter/material.dart';
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

class _TransformGroup {
  const _TransformGroup({
    required this.title,
    required this.summary,
    required this.items,
    required this.icon,
    required this.detail,
  });

  final String title;
  final String summary;
  final List<String> items;
  final IconData icon;
  final String detail;
}

/// How we transform businesses — outcome systems, not service SKUs.
class HowWeTransformSection extends StatelessWidget {
  const HowWeTransformSection({super.key});

  static const _groups = <_TransformGroup>[
    _TransformGroup(
      title: 'Brand',
      summary: 'Identity, Logo, Guidelines',
      items: ['Identity systems', 'Logo & marks', 'Brand guidelines'],
      icon: Icons.brush_outlined,
      detail:
          'We define the reason you exist in the market — then lock it into a system your team can actually use.',
    ),
    _TransformGroup(
      title: 'Digital Presence',
      summary: 'Websites, Landing Pages, QR Menus',
      items: ['Premium websites', 'Landing pages', 'QR menus'],
      icon: Icons.desktop_windows_outlined,
      detail:
          'Interfaces that feel as considered as your space — and convert visitors into booked customers.',
    ),
    _TransformGroup(
      title: 'Automation',
      summary: 'AI Chatbots, WhatsApp, Booking Systems',
      items: ['AI chatbots', 'WhatsApp flows', 'Booking systems'],
      icon: Icons.bolt_outlined,
      detail:
          'Always-on conversations and ops that remove busywork without removing the human touch.',
    ),
    _TransformGroup(
      title: 'Growth',
      summary: 'SEO, Content, Analytics',
      items: ['Local SEO', 'Content systems', 'Analytics'],
      icon: Icons.insights_outlined,
      detail:
          'Demand generation that compounds because the brand can hold the attention it earns.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
              eyebrow: 'How we transform',
              title: 'How We Transform Businesses.',
              subtitle:
                  'Four systems. One outcome: a local business that feels premium and runs with clarity.',
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
                    for (var i = 0; i < _groups.length; i++)
                      SizedBox(
                        width: width,
                        child: Reveal(
                          delay: Duration(milliseconds: 80 * i),
                          child: _TransformCard(group: _groups[i], index: i),
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
  const _TransformCard({required this.group, required this.index});

  final _TransformGroup group;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${group.title}. ${group.summary}',
      child: ExpandableSurfaceCard(
        onTap: () => context.go(AppRoutes.services),
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
                Icon(group.icon, color: AppColors.accent, size: 22),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              group.title,
              style: AppTypography.headingSStyle.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              group.summary,
              style: AppTypography.smallStyle.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              group.detail,
              style: AppTypography.bodyStyle.copyWith(fontSize: 16, height: 1.55),
            ),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final item in group.items)
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
