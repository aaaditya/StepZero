import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/curves.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';

class _JourneyStep {
  const _JourneyStep({
    required this.indexLabel,
    required this.title,
    required this.description,
    required this.icon,
    required this.accent,
  });

  final String indexLabel;
  final String title;
  final String description;
  final IconData icon;
  final Color accent;
}

/// Interactive vertical transformation spine — from anonymity to scale.
class TransformationSection extends StatefulWidget {
  const TransformationSection({super.key});

  @override
  State<TransformationSection> createState() => _TransformationSectionState();
}

class _TransformationSectionState extends State<TransformationSection> {
  static const _steps = <_JourneyStep>[
    _JourneyStep(
      indexLabel: 'Step 0',
      title: 'No Identity',
      description: 'Unclear offer, inconsistent presence, trust that leaks.',
      icon: Icons.radio_button_unchecked,
      accent: AppColors.textTertiary,
    ),
    _JourneyStep(
      indexLabel: '01',
      title: 'Brand Strategy',
      description: 'Positioning, audience truth, and the reason to choose you.',
      icon: Icons.center_focus_strong_outlined,
      accent: AppColors.accent,
    ),
    _JourneyStep(
      indexLabel: '02',
      title: 'Visual Identity',
      description: 'A system of marks, type, and color that feels premium.',
      icon: Icons.palette_outlined,
      accent: AppColors.accent,
    ),
    _JourneyStep(
      indexLabel: '03',
      title: 'Website',
      description: 'A digital storefront that converts trust into action.',
      icon: Icons.language,
      accent: AppColors.accent,
    ),
    _JourneyStep(
      indexLabel: '04',
      title: 'Google Presence',
      description: 'Maps, reviews, and local discovery that compound daily.',
      icon: Icons.travel_explore,
      accent: AppColors.accent,
    ),
    _JourneyStep(
      indexLabel: '05',
      title: 'AI Automation',
      description: 'Chat, WhatsApp, and booking that reply while you work.',
      icon: Icons.auto_awesome,
      accent: AppColors.accent,
    ),
    _JourneyStep(
      indexLabel: '06',
      title: 'Growth',
      description: 'Acquisition that fits the brand — not random ads.',
      icon: Icons.trending_up,
      accent: AppColors.success,
    ),
    _JourneyStep(
      indexLabel: '07',
      title: 'Scale',
      description: 'Repeatable excellence across offers, teams, or locations.',
      icon: Icons.hub_outlined,
      accent: AppColors.success,
    ),
  ];

  int _active = 1;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return SectionLandmark(
      label: 'Business transformation journey',
      child: SectionContainer(
      maxWidth: 1200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Transformation',
            title: 'The Journey From Local Business to Premium Brand.',
            subtitle:
                'Businesses don’t stall from lack of tools. They stall from '
                'starting in the wrong order. StepZero installs the sequence.',
          ),
          const SizedBox(height: AppSpacing.xxxl),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _Timeline(steps: _steps, active: _active, onSelect: _select)),
                const SizedBox(width: AppSpacing.xxl),
                Expanded(flex: 4, child: _ActivePanel(step: _steps[_active])),
              ],
            )
          else
            Column(
              children: [
                _ActivePanel(step: _steps[_active]),
                const SizedBox(height: AppSpacing.xl),
                _Timeline(steps: _steps, active: _active, onSelect: _select),
              ],
            ),
        ],
      ),
    ),
    );
  }

  void _select(int index) => setState(() => _active = index);
}

class _Timeline extends StatelessWidget {
  const _Timeline({
    required this.steps,
    required this.active,
    required this.onSelect,
  });

  final List<_JourneyStep> steps;
  final int active;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          _TimelineNode(
            step: steps[i],
            selected: i == active,
            isFirst: i == 0,
            isLast: i == steps.length - 1,
            onTap: () => onSelect(i),
          )
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: 60 * i),
                duration: 420.ms,
                curve: AppCurves.enter,
              )
              .moveY(
                begin: 12,
                end: 0,
                delay: Duration(milliseconds: 60 * i),
                duration: 450.ms,
                curve: AppCurves.enter,
              ),
        ],
      ],
    );
  }
}

class _TimelineNode extends StatefulWidget {
  const _TimelineNode({
    required this.step,
    required this.selected,
    required this.isFirst,
    required this.isLast,
    required this.onTap,
  });

  final _JourneyStep step;
  final bool selected;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  @override
  State<_TimelineNode> createState() => _TimelineNodeState();
}

class _TimelineNodeState extends State<_TimelineNode> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final emphasize = widget.selected || _hovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 36,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 2,
                        color: widget.isFirst
                            ? Colors.transparent
                            : AppColors.border,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 240),
                      width: emphasize ? 18 : 12,
                      height: emphasize ? 18 : 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.selected
                            ? widget.step.accent
                            : AppColors.surface,
                        border: Border.all(
                          color: emphasize
                              ? widget.step.accent
                              : AppColors.borderStrong,
                          width: 2,
                        ),
                        boxShadow: widget.selected
                            ? [
                                BoxShadow(
                                  color: widget.step.accent.withValues(alpha: 0.35),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ]
                            : null,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 2,
                        color: widget.isLast
                            ? Colors.transparent
                            : AppColors.border,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 240),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: emphasize
                              ? widget.step.accent.withValues(alpha: 0.1)
                              : AppColors.surfaceMuted,
                          borderRadius: AppRadius.mdAll,
                        ),
                        child: Icon(
                          widget.step.icon,
                          color: emphasize
                              ? widget.step.accent
                              : AppColors.textSecondary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.step.indexLabel,
                              style: AppTypography.captionStyle.copyWith(
                                color: AppColors.textTertiary,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.6,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.step.title,
                              style: AppTypography.bodyStrong.copyWith(
                                fontSize: 18,
                                color: emphasize
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                            ),
                            if (!Responsive.isDesktop(context)) ...[
                              const SizedBox(height: 4),
                              Text(
                                widget.step.description,
                                style: AppTypography.captionStyle,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivePanel extends StatelessWidget {
  const _ActivePanel({required this.step});

  final _JourneyStep step;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 320),
      switchInCurve: AppCurves.enter,
      switchOutCurve: AppCurves.exit,
      child: Container(
        key: ValueKey(step.title),
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xxl),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.xxlAll,
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: step.accent.withValues(alpha: 0.08),
              blurRadius: 40,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: step.accent.withValues(alpha: 0.12),
                borderRadius: AppRadius.xlAll,
              ),
              child: Icon(step.icon, size: 34, color: step.accent),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              step.indexLabel,
              style: AppTypography.captionStyle.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              step.title,
              style: AppTypography.headingMStyle.copyWith(
                fontSize: Responsive.fluidFontSize(
                  context,
                  desktop: 36,
                  tablet: 30,
                  mobile: 26,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              step.description,
              style: AppTypography.bodyLargeStyle,
            ),
            const SizedBox(height: AppSpacing.xxl),
            _JourneyIllustration(accent: step.accent, icon: step.icon),
          ],
        ),
      ),
    );
  }
}

class _JourneyIllustration extends StatelessWidget {
  const _JourneyIllustration({required this.accent, required this.icon});

  final Color accent;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: AppRadius.xlAll,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              accent.withValues(alpha: 0.16),
              AppColors.surfaceMuted,
              accent.withValues(alpha: 0.06),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 24,
              bottom: 24,
              child: Icon(
                icon,
                size: 88,
                color: accent.withValues(alpha: 0.22),
              ),
            ),
            Positioned(
              left: 28,
              top: 28,
              child: Container(
                width: 120,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Positioned(
              left: 28,
              top: 52,
              child: Container(
                width: 180,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Positioned(
              left: 28,
              bottom: 36,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: AppRadius.smAll,
                ),
                child: Text(
                  'Next step',
                  style: AppTypography.captionStyle.copyWith(
                    color: AppColors.textOnAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
