import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/curves.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_elevation.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/section_header.dart';

class _Insight {
  const _Insight({
    required this.title,
    required this.dek,
    required this.tag,
    required this.readTime,
    required this.featured,
    required this.tone,
  });

  final String title;
  final String dek;
  final String tag;
  final String readTime;
  final bool featured;
  final Color tone;
}

/// Editorial magazine layout — thinking as a trust product.
class InsightsSection extends StatelessWidget {
  const InsightsSection({super.key});

  static const _insights = <_Insight>[
    _Insight(
      title: 'Brand before traffic: why ads fail unclear businesses',
      dek: 'Acquisition amplifies what already exists. If identity is fuzzy, spend just buys confusion faster.',
      tag: 'Strategy',
      readTime: '6 min',
      featured: true,
      tone: AppColors.accent,
    ),
    _Insight(
      title: 'The QR menu is a brand surface',
      dek: 'Menus are not PDFs. They’re conversion products sitting in every guest’s hand.',
      tag: 'Digital',
      readTime: '4 min',
      featured: false,
      tone: Color(0xFF0F766E),
    ),
    _Insight(
      title: 'Automation that still feels human',
      dek: 'WhatsApp and AI should remove friction — never the warmth that made someone choose you.',
      tag: 'Automation',
      readTime: '5 min',
      featured: false,
      tone: Color(0xFFB45309),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final featured = _insights.firstWhere((e) => e.featured);
    final latest = _insights.where((e) => !e.featured).toList();
    final isDesktop = Responsive.isDesktop(context);

    return SectionContainer(
      maxWidth: 1200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            eyebrow: 'Insights',
            title: 'Thinking you can try before you buy.',
            subtitle:
                'Short essays for operators who want clarity — not content factories.',
            action: Responsive.isDesktop(context)
                ? TextButton(
                    onPressed: () {},
                    child: const Text('View all insights →'),
                  )
                : null,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: _FeaturedInsightCard(insight: featured),
                ),
                const SizedBox(width: AppSpacing.xl),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      for (var i = 0; i < latest.length; i++) ...[
                        _InsightRow(insight: latest[i], index: i),
                        if (i != latest.length - 1)
                          const SizedBox(height: AppSpacing.md),
                      ],
                    ],
                  ),
                ),
              ],
            )
          else ...[
            _FeaturedInsightCard(insight: featured),
            const SizedBox(height: AppSpacing.lg),
            for (var i = 0; i < latest.length; i++) ...[
              _InsightRow(insight: latest[i], index: i),
              if (i != latest.length - 1) const SizedBox(height: AppSpacing.md),
            ],
          ],
        ],
      ),
    );
  }
}

class _FeaturedInsightCard extends StatefulWidget {
  const _FeaturedInsightCard({required this.insight});

  final _Insight insight;

  @override
  State<_FeaturedInsightCard> createState() => _FeaturedInsightCardState();
}

class _FeaturedInsightCardState extends State<_FeaturedInsightCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final insight = widget.insight;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: AppCurves.hover,
          transform: Matrix4.identity()
            ..translate(0.0, _hovered ? -4.0 : 0.0),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.xxlAll,
            border: Border.all(color: AppColors.border),
            boxShadow: _hovered ? AppElevation.medium : AppElevation.low,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 10,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 260),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        insight.tone.withValues(alpha: _hovered ? 0.28 : 0.18),
                        AppColors.surfaceMuted,
                        insight.tone.withValues(alpha: 0.08),
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xxs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Featured',
                          style: AppTypography.captionStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${insight.tag} · ${insight.readTime}',
                      style: AppTypography.captionStyle.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      insight.title,
                      style: AppTypography.headingSStyle.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      insight.dek,
                      style: AppTypography.bodyStyle.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Read article →',
                      style: AppTypography.buttonLabel.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms, curve: AppCurves.enter)
        .moveY(begin: 16, end: 0, duration: 550.ms, curve: AppCurves.enter);
  }
}

class _InsightRow extends StatefulWidget {
  const _InsightRow({required this.insight, required this.index});

  final _Insight insight;
  final int index;

  @override
  State<_InsightRow> createState() => _InsightRowState();
}

class _InsightRowState extends State<_InsightRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final insight = widget.insight;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(AppRoutes.home),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.surfaceMuted : AppColors.surface,
            borderRadius: AppRadius.xlAll,
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: AppRadius.mdAll,
                  gradient: LinearGradient(
                    colors: [
                      insight.tone.withValues(alpha: 0.25),
                      AppColors.surfaceMuted,
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${insight.tag} · ${insight.readTime}',
                      style: AppTypography.captionStyle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      insight.title,
                      style: AppTypography.bodyStrong.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 80 * widget.index),
          duration: 420.ms,
          curve: AppCurves.enter,
        );
  }
}
