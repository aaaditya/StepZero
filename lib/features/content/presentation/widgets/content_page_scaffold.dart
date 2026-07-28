import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/pill_badge.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../shared/layout/page_body.dart';

/// Shared index/detail page chrome for content collections.
class ContentPageScaffold extends StatelessWidget {
  const ContentPageScaffold({
    required this.landmark,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
    this.ctaLabel,
    this.ctaPath,
    this.maxWidth = 1200,
    this.backgroundColor,
    super.key,
  });

  final String landmark;
  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;
  final String? ctaLabel;
  final String? ctaPath;
  final double maxWidth;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SectionLandmark(
      label: landmark,
      child: PageBody(
        child: SectionContainer(
          maxWidth: maxWidth,
          backgroundColor: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Reveal(
                child: SectionHeader(
                  eyebrow: eyebrow,
                  title: title,
                  subtitle: subtitle,
                  action: ctaLabel != null && Responsive.isDesktop(context)
                      ? TextButton(
                          onPressed: () =>
                              context.go(ctaPath ?? AppRoutes.contact),
                          child: Text('$ctaLabel →'),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              child,
              if (ctaLabel != null && !Responsive.isDesktop(context)) ...[
                const SizedBox(height: AppSpacing.xxxl),
                AppButton(
                  label: ctaLabel!,
                  expand: true,
                  onPressed: () => context.go(ctaPath ?? AppRoutes.contact),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ContentEmptyState extends StatelessWidget {
  const ContentEmptyState({
    required this.title,
    this.actionLabel = 'Back home',
    this.actionPath = AppRoutes.home,
    super.key,
  });

  final String title;
  final String actionLabel;
  final String actionPath;

  @override
  Widget build(BuildContext context) {
    return PageBody(
      child: SectionContainer(
        child: Column(
          children: [
            Text(title, style: AppTypography.headingMStyle),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: actionLabel,
              onPressed: () => context.go(actionPath),
            ),
          ],
        ),
      ),
    );
  }
}

class ContentMetaPill extends StatelessWidget {
  const ContentMetaPill({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return PillBadge(label: label);
  }
}

class ContentProse extends StatelessWidget {
  const ContentProse({required this.text, this.maxWidth = 680, super.key});

  final String text;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final paragraphs = text.split('\n\n');
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < paragraphs.length; i++) ...[
            Text(
              paragraphs[i],
              style: AppTypography.bodyLargeStyle.copyWith(
                height: 1.65,
                color: AppColors.textPrimary,
              ),
            ),
            if (i != paragraphs.length - 1)
              const SizedBox(height: AppSpacing.lg),
          ],
        ],
      ),
    );
  }
}
