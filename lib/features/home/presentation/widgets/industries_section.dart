import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/curves.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/expandable_surface_card.dart';
import '../../../../core/widgets/section_header.dart';

class _Industry {
  const _Industry({
    required this.name,
    required this.insight,
    required this.icon,
  });

  final String name;
  final String insight;
  final IconData icon;
}

/// Domain literacy grid — visitor should feel “this is for my world.”
class IndustriesSection extends StatelessWidget {
  const IndustriesSection({super.key});

  static const _industries = <_Industry>[
    _Industry(
      name: 'Restaurants',
      insight: 'Covers, reputation, and menus that convert.',
      icon: Icons.restaurant,
    ),
    _Industry(
      name: 'Cafés',
      insight: 'Atmosphere online that matches the room.',
      icon: Icons.local_cafe_outlined,
    ),
    _Industry(
      name: 'Salons',
      insight: 'Booking clarity and premium visual trust.',
      icon: Icons.content_cut,
    ),
    _Industry(
      name: 'Clinics',
      insight: 'Care signals, intake automation, reviews.',
      icon: Icons.medical_services_outlined,
    ),
    _Industry(
      name: 'Gyms',
      insight: 'Membership journeys that feel intentional.',
      icon: Icons.fitness_center,
    ),
    _Industry(
      name: 'Retail',
      insight: 'Shelf-to-screen systems that sell.',
      icon: Icons.storefront_outlined,
    ),
    _Industry(
      name: 'Hotels',
      insight: 'Stay branding and direct booking paths.',
      icon: Icons.hotel_outlined,
    ),
    _Industry(
      name: 'Real Estate',
      insight: 'Authority sites that close serious buyers.',
      icon: Icons.home_work_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.isDesktop(context)
        ? 4
        : Responsive.isTablet(context)
            ? 2
            : 1;

    return SectionContainer(
      maxWidth: 1200,
      backgroundColor: AppColors.surfaceMuted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Industries',
            title: 'Built for local businesses that want to feel premium.',
            subtitle:
                'Same craft as global brands — tuned to the economics and rituals of your category.',
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
                  for (var i = 0; i < _industries.length; i++)
                    SizedBox(
                      width: width,
                      child: _IndustryCard(
                        industry: _industries[i],
                        index: i,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _IndustryCard extends StatelessWidget {
  const _IndustryCard({required this.industry, required this.index});

  final _Industry industry;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpandableSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      expandScale: 1.025,
      translateY: -4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(industry.icon, size: 22, color: AppColors.accent),
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
