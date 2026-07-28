import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/seo/page_meta.dart';
import '../../../../core/seo/seo_effect.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../shared/layout/page_body.dart';
import '../../domain/case_study.dart';
import '../providers/case_study_providers.dart';
import '../widgets/case_study_chapter.dart';
import '../widgets/case_study_chapters.dart';
import '../widgets/case_study_content_blocks.dart';
import '../widgets/case_study_hero.dart';
import '../widgets/case_study_toc.dart';

/// Full case study reading experience — docs TOC + product storytelling.
class CaseStudyPage extends ConsumerStatefulWidget {
  const CaseStudyPage({required this.slug, super.key});

  final String slug;

  @override
  ConsumerState<CaseStudyPage> createState() => _CaseStudyPageState();
}

class _CaseStudyPageState extends ConsumerState<CaseStudyPage> {
  String _activeId = 'overview';
  final _chapterKeys = <String, GlobalKey>{
    for (final entry in CaseStudy.toc) entry.$1: GlobalKey(),
  };

  @override
  Widget build(BuildContext context) {
    final study = ref.watch(caseStudyProvider(widget.slug));
    if (study == null) {
      return PageBody(
        child: SectionContainer(
          child: Column(
            children: [
              Text('Case study not found', style: AppTypography.headingMStyle),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: 'Back to work',
                onPressed: () => context.go(AppRoutes.work),
              ),
            ],
          ),
        ),
      );
    }

    final next = ref.watch(caseStudyProvider(study.nextSlug));
    final isDesktop = Responsive.isDesktop(context);
    final path = AppRoutes.caseStudy(study.slug);

    return SeoEffect(
      meta: PageMeta(
        title: '${study.name} — ${study.headline} · StepZero',
        description: study.challenge,
        path: path,
        type: 'article',
        jsonLd: StructuredData.caseStudy(
          name: study.name,
          headline: study.headline,
          path: path,
          industry: study.overview.industry,
        ),
      ),
      child: SectionLandmark(
      label: '${study.name} case study',
      child: PageBody(
        child: MaxWidthBox(
          maxWidth: 1200,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.pageGutter(context),
            vertical: AppSpacing.xxl,
          ),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: StickyToc(
                        child: CaseStudyToc(
                          activeId: _activeId,
                          onSelect: _scrollTo,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xxl),
                    Expanded(child: _Body(study: study, next: next, keys: _chapterKeys)),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CaseStudyMobileToc(
                      activeId: _activeId,
                      onSelect: _scrollTo,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _Body(study: study, next: next, keys: _chapterKeys),
                  ],
                ),
        ),
      ),
    ),
    );
  }

  void _scrollTo(String id) {
    setState(() => _activeId = id);
    final key = _chapterKeys[id];
    final ctx = key?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        alignment: 0.08,
      );
    }
  }
}

/// Keeps TOC visually sticky within the page scroll.
class StickyToc extends StatelessWidget {
  const StickyToc({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.study,
    required this.next,
    required this.keys,
  });

  final CaseStudy study;
  final CaseStudy? next;
  final Map<String, GlobalKey> keys;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CaseStudyHero(study: study),
        const Divider(color: AppColors.border),
        const SizedBox(height: AppSpacing.xxxl),
        KeyedSubtree(
          key: keys['overview'],
          child: CaseStudyOverviewSection(study: study),
        ),
        KeyedSubtree(
          key: keys['challenge'],
          child: CaseStudyChapter(
            id: 'challenge',
            eyebrow: 'Challenge',
            title: 'The tension we had to resolve.',
            child: CaseStudyCallout(body: study.challenge),
          ),
        ),
        KeyedSubtree(
          key: keys['research'],
          child: CaseStudyResearchSection(study: study),
        ),
        KeyedSubtree(
          key: keys['strategy'],
          child: CaseStudyStrategySection(study: study),
        ),
        KeyedSubtree(
          key: keys['brand'],
          child: CaseStudyBrandSection(study: study),
        ),
        KeyedSubtree(
          key: keys['website'],
          child: CaseStudyWebsiteSection(study: study),
        ),
        KeyedSubtree(
          key: keys['mobile'],
          child: CaseStudyMobileSection(study: study),
        ),
        KeyedSubtree(
          key: keys['automation'],
          child: CaseStudyAutomationSection(study: study),
        ),
        KeyedSubtree(
          key: keys['results'],
          child: CaseStudyResultsSection(study: study),
        ),
        KeyedSubtree(
          key: keys['gallery'],
          child: CaseStudyGallerySection(study: study),
        ),
        KeyedSubtree(
          key: keys['metrics'],
          child: CaseStudyMetricsSection(study: study),
        ),
        KeyedSubtree(
          key: keys['testimonial'],
          child: CaseStudyTestimonialSection(study: study),
        ),
        KeyedSubtree(
          key: keys['stack'],
          child: CaseStudyStackSection(study: study),
        ),
        KeyedSubtree(
          key: keys['timeline'],
          child: CaseStudyTimelineSection(study: study),
        ),
        KeyedSubtree(
          key: keys['lessons'],
          child: CaseStudyLessonsSection(study: study),
        ),
        if (next != null)
          KeyedSubtree(
            key: keys['next'],
            child: CaseStudyNextSection(study: study, next: next!),
          ),
      ],
    );
  }
}
