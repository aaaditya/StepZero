import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/curves.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../content/domain/models.dart';
import '../../../content/presentation/providers/content_providers.dart';
import '../../../content/presentation/widgets/content_icons.dart';

/// Interactive industry panel — list + atmospheric detail (not an icon grid).
class IndustriesSection extends ConsumerStatefulWidget {
  const IndustriesSection({super.key});

  @override
  ConsumerState<IndustriesSection> createState() => _IndustriesSectionState();
}

class _IndustriesSectionState extends ConsumerState<IndustriesSection> {
  int _active = 0;

  @override
  Widget build(BuildContext context) {
    final industries = ref.watch(industriesProvider);
    if (industries.isEmpty) return const SizedBox.shrink();
    final active = industries[_active.clamp(0, industries.length - 1)];
    final isDesktop = Responsive.isDesktop(context);

    return SectionLandmark(
      label: 'Industries',
      child: SectionContainer(
        maxWidth: 1200,
        backgroundColor: AppColors.surfaceMuted,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              eyebrow: 'Who we serve',
              title: 'Built for operators who want to feel premium.',
              subtitle:
                  'Same craft as global brands — tuned to the economics '
                  'and rituals of your category.',
              action: isDesktop
                  ? TextButton(
                      onPressed: () => context.go(AppRoutes.industries),
                      child: const Text('All industries →'),
                    )
                  : null,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        for (var i = 0; i < industries.length; i++)
                          _IndustryListItem(
                            industry: industries[i],
                            selected: i == _active,
                            onTap: () => setState(() => _active = i),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xxl),
                  Expanded(
                    flex: 6,
                    child: _IndustryPanel(industry: active),
                  ),
                ],
              )
            else
              Column(
                children: [
                  for (var i = 0; i < industries.length; i++) ...[
                    _IndustryListItem(
                      industry: industries[i],
                      selected: i == _active,
                      onTap: () => setState(() => _active = i),
                    ),
                    if (i == _active) ...[
                      const SizedBox(height: AppSpacing.md),
                      _IndustryPanel(industry: active),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _IndustryListItem extends StatefulWidget {
  const _IndustryListItem({
    required this.industry,
    required this.selected,
    required this.onTap,
  });

  final Industry industry;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_IndustryListItem> createState() => _IndustryListItemState();
}

class _IndustryListItemState extends State<_IndustryListItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.selected || _hovered;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: AppCurves.hover,
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: widget.selected
                ? AppColors.surface
                : active
                    ? AppColors.surface.withValues(alpha: 0.55)
                    : Colors.transparent,
            borderRadius: AppRadius.mdAll,
            border: Border.all(
              color: widget.selected ? AppColors.border : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Icon(
                ContentIcons.resolve(widget.industry.iconKey),
                size: 20,
                color: widget.selected
                    ? AppColors.accent
                    : AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  widget.industry.name,
                  style: AppTypography.bodyStrong.copyWith(
                    fontSize: 17,
                    color: widget.selected
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
              if (widget.selected)
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: AppColors.accent,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IndustryPanel extends StatelessWidget {
  const _IndustryPanel({required this.industry});

  final Industry industry;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      switchInCurve: AppCurves.enter,
      child: DecoratedBox(
        key: ValueKey(industry.slug),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.xxlAll,
          border: Border.all(color: AppColors.border),
        ),
        child: ClipRRect(
          borderRadius: AppRadius.xxlAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.accent.withValues(alpha: 0.9),
                        AppColors.textPrimary,
                        AppColors.accent.withValues(alpha: 0.55),
                      ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -40,
                        bottom: -40,
                        child: Icon(
                          ContentIcons.resolve(industry.iconKey),
                          size: 200,
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.xxl),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            industry.name,
                            style: AppTypography.headingLStyle.copyWith(
                              color: AppColors.textInverse,
                              fontSize: Responsive.fluidFontSize(
                                context,
                                desktop: 40,
                                tablet: 32,
                                mobile: 28,
                              ),
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      industry.insight,
                      style: AppTypography.bodyLargeStyle.copyWith(
                        fontSize: 20,
                        height: 1.45,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppButton(
                      label: 'Explore ${industry.name.toLowerCase()}',
                      variant: AppButtonVariant.secondary,
                      size: AppButtonSize.sm,
                      onPressed: () =>
                          context.go(AppRoutes.industry(industry.slug)),
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
        .fadeIn(duration: 320.ms, curve: AppCurves.enter);
  }
}
