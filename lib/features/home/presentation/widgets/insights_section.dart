import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../content/domain/models.dart';
import '../../../content/presentation/providers/content_providers.dart';

/// Editorial magazine layout — sourced from Articles catalog.
class InsightsSection extends ConsumerWidget {
  const InsightsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(articlesProvider);
    final featured = articles.firstWhere(
      (e) => e.featured,
      orElse: () => articles.first,
    );
    final latest = articles.where((e) => e.slug != featured.slug).toList();
    final isDesktop = Responsive.isDesktop(context);

    return SectionLandmark(
      label: 'Insights',
      child: SectionContainer(
        maxWidth: 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              eyebrow: 'Insights',
              title: 'Clarity before commitment.',
              subtitle:
                  'Short essays for operators who want sharper decisions.',
              action: Responsive.isDesktop(context)
                  ? TextButton(
                      onPressed: () => context.go(AppRoutes.articles),
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
                    child: _FeaturedInsightCard(article: featured),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        for (var i = 0; i < latest.length; i++) ...[
                          _InsightRow(article: latest[i], index: i),
                          if (i != latest.length - 1)
                            const SizedBox(height: AppSpacing.md),
                        ],
                      ],
                    ),
                  ),
                ],
              )
            else ...[
              _FeaturedInsightCard(article: featured),
              const SizedBox(height: AppSpacing.lg),
              for (var i = 0; i < latest.length; i++) ...[
                _InsightRow(article: latest[i], index: i),
                if (i != latest.length - 1) const SizedBox(height: AppSpacing.md),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _FeaturedInsightCard extends StatefulWidget {
  const _FeaturedInsightCard({required this.article});

  final Article article;

  @override
  State<_FeaturedInsightCard> createState() => _FeaturedInsightCardState();
}

class _FeaturedInsightCardState extends State<_FeaturedInsightCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    final tone = Color(article.tone);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(AppRoutes.article(article.slug)),
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
                  color: AppColors.textPrimary,
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        top: -30,
                        child: Text(
                          '0${(article.title.hashCode.abs() % 8) + 1}',
                          style: AppTypography.displayHero.copyWith(
                            fontSize: 160,
                            color: tone.withValues(alpha: 0.22),
                            height: 1,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FEATURED',
                              style: AppTypography.captionStyle.copyWith(
                                color: AppColors.accent,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.4,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              article.title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.headingMStyle.copyWith(
                                color: AppColors.textInverse,
                                fontSize: Responsive.fluidFontSize(
                                  context,
                                  desktop: 32,
                                  tablet: 26,
                                  mobile: 22,
                                ),
                                height: 1.15,
                                letterSpacing: -0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${article.tag} · ${article.readTime}',
                      style: AppTypography.captionStyle.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      article.dek,
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
  const _InsightRow({required this.article, required this.index});

  final Article article;
  final int index;

  @override
  State<_InsightRow> createState() => _InsightRowState();
}

class _InsightRowState extends State<_InsightRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(AppRoutes.article(article.slug)),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${article.tag} · ${article.readTime}',
                      style: AppTypography.captionStyle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.title,
                      style: AppTypography.bodyStrong.copyWith(fontSize: 17),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: _hovered ? AppColors.accent : AppColors.textTertiary,
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
