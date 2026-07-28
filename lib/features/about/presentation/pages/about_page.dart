import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../shared/layout/page_body.dart';
import '../../../content/presentation/providers/content_providers.dart';

/// About — studio story + team teaser driven by Settings + Team catalog.
class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(siteSettingsProvider);
    final team = ref.watch(teamProvider);
    final isDesktop = Responsive.isDesktop(context);

    return SectionLandmark(
      label: 'About',
      child: PageBody(
        child: Column(
          children: [
            SectionContainer(
              maxWidth: 880,
              child: Reveal(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      eyebrow: 'About',
                      title: 'A studio for operators who want to feel premium.',
                      subtitle:
                          'StepZero is not an agency menu. We build the sequence '
                          'that turns a local business into a trusted brand.',
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 680),
                      child: Text(
                        settings.mission,
                        style: AppTypography.bodyLargeStyle.copyWith(height: 1.65),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      settings.tagline,
                      style: AppTypography.headingSStyle.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    AppButton(
                      label: settings.primaryCtaLabel,
                      onPressed: () => context.go(settings.primaryCtaPath),
                    ),
                  ],
                ),
              ),
            ),
            SectionContainer(
              maxWidth: 1200,
              backgroundColor: AppColors.surfaceMuted,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    eyebrow: 'Team',
                    title: 'Small studio. Senior craft.',
                    action: isDesktop
                        ? TextButton(
                            onPressed: () => context.go(AppRoutes.team),
                            child: const Text('Meet the team →'),
                          )
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                  // Reuse team page visual density via compact preview
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final columns = isDesktop ? 3 : 1;
                      const gap = AppSpacing.lg;
                      final width = columns == 1
                          ? constraints.maxWidth
                          : (constraints.maxWidth - gap * (columns - 1)) /
                              columns;
                      return Wrap(
                        spacing: gap,
                        runSpacing: gap,
                        children: [
                          for (var i = 0; i < team.length; i++)
                            SizedBox(
                              width: width,
                              child: Reveal(
                                delay: Duration(milliseconds: 70 * i),
                                child: _AboutTeamTeaser(
                                  name: team[i].name,
                                  role: team[i].role,
                                  tone: team[i].tone,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  if (!isDesktop) ...[
                    const SizedBox(height: AppSpacing.xxl),
                    AppButton(
                      label: 'Meet the team',
                      expand: true,
                      variant: AppButtonVariant.secondary,
                      onPressed: () => context.go(AppRoutes.team),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutTeamTeaser extends StatelessWidget {
  const _AboutTeamTeaser({
    required this.name,
    required this.role,
    required this.tone,
  });

  final String name;
  final String role;
  final int tone;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(tone), Color(tone).withValues(alpha: 0.55)],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTypography.bodyStrong),
                  Text(role, style: AppTypography.captionStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
