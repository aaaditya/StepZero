import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_elevation.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/expandable_surface_card.dart';
import '../../domain/case_study.dart';
import 'case_study_chapter.dart';

class CaseStudyBrandSection extends StatelessWidget {
  const CaseStudyBrandSection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    final brand = study.brand;
    return CaseStudyChapter(
      id: 'brand',
      eyebrow: 'Brand identity',
      title: 'Identity as a business asset.',
      wide: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              brand.narrative,
              style: AppTypography.bodyLargeStyle.copyWith(height: 1.65),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              for (var i = 0; i < brand.paletteLabels.length; i++)
                _PaletteSwatch(
                  label: brand.paletteLabels[i],
                  color: Color(study.accent).withValues(alpha: 1 - i * 0.18),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          for (final principle in brand.principles)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  const Icon(Icons.check_rounded, size: 18, color: AppColors.accent),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      principle,
                      style: AppTypography.bodyStyle.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: AppSpacing.xxl),
          _VisualStage(
            accent: Color(study.accent),
            label: 'Identity system',
            child: Center(
              child: Text(
                study.name,
                style: AppTypography.headingLStyle.copyWith(
                  color: AppColors.textInverse,
                  fontSize: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaletteSwatch extends StatelessWidget {
  const _PaletteSwatch({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppRadius.mdAll,
            border: Border.all(color: AppColors.border),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: AppTypography.captionStyle),
      ],
    );
  }
}

class CaseStudyWebsiteSection extends StatelessWidget {
  const CaseStudyWebsiteSection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    return _ProductChapter(
      id: 'website',
      eyebrow: 'Website design',
      title: 'A storefront that converts trust into action.',
      chapter: study.website,
      accent: Color(study.accent),
      visual: _LaptopStage(accent: Color(study.accent)),
    );
  }
}

class CaseStudyMobileSection extends StatelessWidget {
  const CaseStudyMobileSection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    return _ProductChapter(
      id: 'mobile',
      eyebrow: 'Mobile experience',
      title: 'Designed for the hand that books.',
      chapter: study.mobile,
      accent: Color(study.accent),
      visual: _PhoneStage(accent: Color(study.accent)),
    );
  }
}

class _ProductChapter extends StatelessWidget {
  const _ProductChapter({
    required this.id,
    required this.eyebrow,
    required this.title,
    required this.chapter,
    required this.accent,
    required this.visual,
  });

  final String id;
  final String eyebrow;
  final String title;
  final CaseStudyProductChapter chapter;
  final Color accent;
  final Widget visual;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return CaseStudyChapter(
      id: id,
      eyebrow: eyebrow,
      title: title,
      wide: true,
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _Decisions(chapter: chapter)),
                const SizedBox(width: AppSpacing.xxl),
                Expanded(flex: 5, child: visual),
              ],
            )
          : Column(
              children: [
                _Decisions(chapter: chapter),
                const SizedBox(height: AppSpacing.xl),
                visual,
              ],
            ),
    );
  }
}

class _Decisions extends StatelessWidget {
  const _Decisions({required this.chapter});

  final CaseStudyProductChapter chapter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          chapter.narrative,
          style: AppTypography.bodyLargeStyle.copyWith(height: 1.65),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          'Key decisions',
          style: AppTypography.captionStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final decision in chapter.decisions)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('→  ', style: TextStyle(color: AppColors.accent)),
                Expanded(
                  child: Text(
                    decision,
                    style: AppTypography.bodyStyle.copyWith(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _VisualStage extends StatelessWidget {
  const _VisualStage({
    required this.accent,
    required this.label,
    required this.child,
  });

  final Color accent;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.captionStyle),
        const SizedBox(height: AppSpacing.sm),
        AspectRatio(
          aspectRatio: 16 / 10,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: AppRadius.xxlAll,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accent,
                  accent.withValues(alpha: 0.7),
                  AppColors.textPrimary,
                ],
              ),
              boxShadow: AppElevation.medium,
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}

class _LaptopStage extends StatelessWidget {
  const _LaptopStage({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return _VisualStage(
      accent: accent,
      label: 'Website',
      child: Center(
        child: Container(
          width: 280,
          height: 170,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 8,
                  color: AppColors.textPrimary.withValues(alpha: 0.75),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 120,
                  height: 6,
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                ),
                const Spacer(),
                Container(
                  width: 56,
                  height: 18,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneStage extends StatelessWidget {
  const _PhoneStage({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return _VisualStage(
      accent: accent,
      label: 'Mobile',
      child: Center(
        child: Container(
          width: 110,
          height: 210,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFF333333)),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderStrong,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 28,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CaseStudyAutomationSection extends StatelessWidget {
  const CaseStudyAutomationSection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    return CaseStudyChapter(
      id: 'automation',
      eyebrow: 'Automation',
      title: 'Systems that remove chaos without removing the human.',
      child: Column(
        children: [
          for (var i = 0; i < study.automation.length; i++) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: AppRadius.xlAll,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    study.automation[i].title,
                    style: AppTypography.bodyStrong.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    study.automation[i].body,
                    style: AppTypography.bodyStyle.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
            if (i != study.automation.length - 1)
              const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class CaseStudyResultsSection extends StatelessWidget {
  const CaseStudyResultsSection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    return CaseStudyChapter(
      id: 'results',
      eyebrow: 'Business results',
      title: 'What changed in the business.',
      child: Text(
        study.resultsNarrative,
        style: AppTypography.bodyLargeStyle.copyWith(height: 1.7, fontSize: 20),
      ),
    );
  }
}

class CaseStudyGallerySection extends StatelessWidget {
  const CaseStudyGallerySection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.isDesktop(context) ? 2 : 1;
    return CaseStudyChapter(
      id: 'gallery',
      eyebrow: 'Gallery',
      title: 'Evidence, captioned.',
      wide: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const gap = AppSpacing.md;
          final width = columns == 1
              ? constraints.maxWidth
              : (constraints.maxWidth - gap) / 2;
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (final item in study.gallery)
                SizedBox(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 10,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: AppRadius.xlAll,
                            gradient: LinearGradient(
                              colors: [
                                Color(item.tone),
                                Color(item.tone).withValues(alpha: 0.55),
                                AppColors.surfaceMuted,
                              ],
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              child: Text(
                                item.label,
                                style: AppTypography.captionStyle.copyWith(
                                  color: AppColors.textInverse,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(item.caption, style: AppTypography.smallStyle),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class CaseStudyTestimonialSection extends StatelessWidget {
  const CaseStudyTestimonialSection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    final t = study.testimonial;
    return CaseStudyChapter(
      id: 'testimonial',
      eyebrow: 'Client testimonial',
      title: 'In their words.',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xxl),
        decoration: const BoxDecoration(
          color: AppColors.surfaceMuted,
          borderRadius: AppRadius.xxlAll,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '“${t.quote}”',
              style: AppTypography.headingSStyle.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w500,
                height: 1.45,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(t.name, style: AppTypography.bodyStrong),
            Text(t.role, style: AppTypography.captionStyle),
          ],
        ),
      ),
    );
  }
}

class CaseStudyStackSection extends StatelessWidget {
  const CaseStudyStackSection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    return CaseStudyChapter(
      id: 'stack',
      eyebrow: 'Tech stack',
      title: 'How it was built.',
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          for (final item in study.techStack)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.borderStrong),
                color: AppColors.surface,
              ),
              child: Text(
                item,
                style: AppTypography.captionStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CaseStudyTimelineSection extends StatelessWidget {
  const CaseStudyTimelineSection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return CaseStudyChapter(
      id: 'timeline',
      eyebrow: 'Timeline',
      title: 'How the engagement unfolded.',
      wide: true,
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < study.timeline.length; i++)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: i == study.timeline.length - 1 ? 0 : AppSpacing.md,
                      ),
                      child: _Phase(phase: study.timeline[i], index: i + 1),
                    ),
                  ),
              ],
            )
          : Column(
              children: [
                for (var i = 0; i < study.timeline.length; i++) ...[
                  _Phase(phase: study.timeline[i], index: i + 1),
                  if (i != study.timeline.length - 1)
                    const SizedBox(height: AppSpacing.md),
                ],
              ],
            ),
    );
  }
}

class _Phase extends StatelessWidget {
  const _Phase({required this.phase, required this.index});

  final CaseStudyTimelinePhase phase;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '0$index · ${phase.duration}',
          style: AppTypography.captionStyle.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(phase.title, style: AppTypography.bodyStrong.copyWith(fontSize: 17)),
        const SizedBox(height: 4),
        Text(phase.body, style: AppTypography.captionStyle.copyWith(height: 1.45)),
      ],
    );
  }
}

class CaseStudyLessonsSection extends StatelessWidget {
  const CaseStudyLessonsSection({required this.study, super.key});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    return CaseStudyChapter(
      id: 'lessons',
      eyebrow: 'Lessons learned',
      title: 'What we’d tell the next client.',
      child: Column(
        children: [
          for (var i = 0; i < study.lessons.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '0${i + 1}',
                    style: AppTypography.captionStyle.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      study.lessons[i],
                      style: AppTypography.bodyLargeStyle.copyWith(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class CaseStudyNextSection extends StatelessWidget {
  const CaseStudyNextSection({
    required this.study,
    required this.next,
    super.key,
  });

  final CaseStudy study;
  final CaseStudy next;

  @override
  Widget build(BuildContext context) {
    return CaseStudyChapter(
      id: 'next',
      eyebrow: 'Next project',
      title: 'Continue the journey.',
      child: ExpandableSurfaceCard(
        onTap: () => context.go(AppRoutes.caseStudy(next.slug)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              next.overview.industry.toUpperCase(),
              style: AppTypography.captionStyle.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              next.name,
              style: AppTypography.headingSStyle.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(next.headline, style: AppTypography.bodyLargeStyle),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Read case study',
              size: AppButtonSize.sm,
              onPressed: () => context.go(AppRoutes.caseStudy(next.slug)),
            ),
          ],
        ),
      ),
    );
  }
}
