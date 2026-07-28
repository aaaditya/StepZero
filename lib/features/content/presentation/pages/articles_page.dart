import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_elevation.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/expandable_surface_card.dart';
import '../../../../core/widgets/reveal.dart';
import '../../domain/models.dart';
import '../providers/content_providers.dart';
import '../widgets/content_page_scaffold.dart';

class ArticlesPage extends ConsumerWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(articlesProvider);
    final featured = articles.where((a) => a.featured).toList();
    final rest = articles.where((a) => !a.featured).toList();
    final isDesktop = Responsive.isDesktop(context);

    return ContentPageScaffold(
      landmark: 'Insights',
      eyebrow: 'Insights',
      title: 'Thinking you can try before you buy.',
      subtitle:
          'Short essays for operators who want clarity — not content factories.',
      child: Column(
        children: [
          if (featured.isNotEmpty)
            Reveal(
              child: _FeaturedArticle(
                article: featured.first,
                onTap: () => context.go(AppRoutes.article(featured.first.slug)),
              ),
            ),
          if (rest.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xxl),
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
                    for (var i = 0; i < rest.length; i++)
                      SizedBox(
                        width: width,
                        child: Reveal(
                          delay: Duration(milliseconds: 70 * i),
                          child: _ArticleCard(
                            article: rest[i],
                            onTap: () =>
                                context.go(AppRoutes.article(rest[i].slug)),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

class ArticleDetailPage extends ConsumerWidget {
  const ArticleDetailPage({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final article = ref.watch(articleProvider(slug));
    if (article == null) {
      return const ContentEmptyState(title: 'Article not found');
    }

    return ContentPageScaffold(
      landmark: article.title,
      eyebrow: article.tag,
      title: article.title,
      subtitle: '${article.readTime} read · ${article.dek}',
      maxWidth: 720,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentProse(text: article.body),
          const SizedBox(height: AppSpacing.xxxl),
          TextButton(
            onPressed: () => context.go(AppRoutes.articles),
            child: const Text('← All insights'),
          ),
        ],
      ),
    );
  }
}

class _FeaturedArticle extends StatelessWidget {
  const _FeaturedArticle({required this.article, required this.onTap});

  final Article article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: article.title,
      child: ExpandableSurfaceCard(
        onTap: onTap,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 21 / 9,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(article.tone),
                      Color(article.tone).withValues(alpha: 0.55),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${article.tag} · ${article.readTime}',
                    style: AppTypography.captionStyle.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    article.title,
                    style: AppTypography.headingMStyle.copyWith(fontSize: 32),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(article.dek, style: AppTypography.bodyLargeStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.article, required this.onTap});

  final Article article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: article.title,
      child: Material(
        color: AppColors.surface,
        elevation: 0,
        shadowColor: Colors.transparent,
        borderRadius: AppRadius.xlAll,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.xlAll,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: AppRadius.xlAll,
              border: Border.all(color: AppColors.border),
              boxShadow: AppElevation.low,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 4,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Color(article.tone),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    '${article.tag} · ${article.readTime}',
                    style: AppTypography.captionStyle,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    article.title,
                    style: AppTypography.bodyStrong.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(article.dek, style: AppTypography.smallStyle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
