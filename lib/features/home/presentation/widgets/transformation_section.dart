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
    required this.outcomes,
    required this.icon,
    required this.accent,
  });

  final String indexLabel;
  final String title;
  final String description;
  final List<String> outcomes;
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
      indexLabel: '00',
      title: 'No Identity',
      description:
          'Unclear offer, inconsistent presence, trust that leaks at every touchpoint.',
      outcomes: [
        'Customers can’t explain why to choose you',
        'Every new channel starts from zero',
        'Growth feels random, not designed',
      ],
      icon: Icons.radio_button_unchecked,
      accent: AppColors.textTertiary,
    ),
    _JourneyStep(
      indexLabel: '01',
      title: 'Brand Strategy',
      description:
          'Positioning, audience truth, and the reason to choose you — locked before design.',
      outcomes: [
        'One-sentence positioning',
        'Audience & category map',
        'Success metrics defined',
      ],
      icon: Icons.center_focus_strong_outlined,
      accent: AppColors.accent,
    ),
    _JourneyStep(
      indexLabel: '02',
      title: 'Visual Identity',
      description:
          'A system of marks, type, and color that feels premium in your category.',
      outcomes: [
        'Logo & type system',
        'Color & photography rules',
        'Application kit',
      ],
      icon: Icons.palette_outlined,
      accent: AppColors.accent,
    ),
    _JourneyStep(
      indexLabel: '03',
      title: 'Website',
      description:
          'A digital storefront that converts trust into bookings, orders, and inquiries.',
      outcomes: [
        'Conversion architecture',
        'Mobile-first craft',
        'Measurable CTAs',
      ],
      icon: Icons.language,
      accent: AppColors.accent,
    ),
    _JourneyStep(
      indexLabel: '04',
      title: 'Google Presence',
      description:
          'Maps, reviews, and local discovery that compound daily without paid spend.',
      outcomes: [
        'Profile & review system',
        'Local SEO foundation',
        'Reputation cadence',
      ],
      icon: Icons.travel_explore,
      accent: AppColors.accent,
    ),
    _JourneyStep(
      indexLabel: '05',
      title: 'AI Automation',
      description:
          'Chat, WhatsApp, and booking that reply while you work the floor.',
      outcomes: [
        'Always-on replies',
        'Booking & FAQ automation',
        'Human handoff when needed',
      ],
      icon: Icons.auto_awesome,
      accent: AppColors.accent,
    ),
    _JourneyStep(
      indexLabel: '06',
      title: 'Growth',
      description:
          'Acquisition that fits the brand — not random ads bolted on after the fact.',
      outcomes: [
        'Channel strategy',
        'Content that compounds',
        'Paid only where it pays',
      ],
      icon: Icons.trending_up,
      accent: AppColors.success,
    ),
    _JourneyStep(
      indexLabel: '07',
      title: 'Scale',
      description:
          'Repeatable excellence across offers, teams, or locations.',
      outcomes: [
        'Playbooks & training',
        'Multi-location systems',
        'Brand that travels',
      ],
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
            eyebrow: 'The Method',
            title: 'Local business → premium brand.',
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
                      duration: const Duration(milliseconds: 320),
                      curve: Curves.easeOutCubic,
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
                                  color: widget.step.accent
                                      .withValues(alpha: 0.45),
                                  blurRadius: 16,
                                  spreadRadius: 3,
                                ),
                              ]
                            : _hovered
                                ? [
                                    BoxShadow(
                                      color: widget.step.accent
                                          .withValues(alpha: 0.18),
                                      blurRadius: 10,
                                      spreadRadius: 1,
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
            Text(
              'What changes',
              style: AppTypography.captionStyle.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final outcome in step.outcomes) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: step.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        outcome,
                        style: AppTypography.bodyStyle.copyWith(
                          fontSize: 16,
                          height: 1.45,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
