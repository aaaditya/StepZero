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

class _ProcessStep {
  const _ProcessStep({
    required this.title,
    required this.description,
    required this.duration,
    required this.involvement,
  });

  final String title;
  final String description;
  final String duration;
  final String involvement;
}

/// Horizontal premium process — confidence through clarity.
class ProcessSection extends StatefulWidget {
  const ProcessSection({super.key});

  @override
  State<ProcessSection> createState() => _ProcessSectionState();
}

class _ProcessSectionState extends State<ProcessSection>
    with SingleTickerProviderStateMixin {
  static const _steps = <_ProcessStep>[
    _ProcessStep(
      title: 'Discover',
      description:
          'Diagnose the business, audience truth, and constraints before '
          'any pixels. We map what is broken and what is already working.',
      duration: '1–2 weeks',
      involvement: '2 founder workshops · access to analytics & brand assets',
    ),
    _ProcessStep(
      title: 'Strategy',
      description:
          'Lock positioning, success metrics, and the transformation sequence. '
          'You leave with a written operating brief — not a moodboard.',
      duration: '1–2 weeks',
      involvement: '1 strategy review · decision owner on your side',
    ),
    _ProcessStep(
      title: 'Design',
      description:
          'Craft identity and experience systems that feel premium in your '
          'category — not generic agency templates.',
      duration: '2–3 weeks',
      involvement: '2 design reviews · feedback within 3 business days',
    ),
    _ProcessStep(
      title: 'Build',
      description:
          'Ship site, automation, and operating assets as one system. '
          'Training included so your team can run it without us.',
      duration: '2–4 weeks',
      involvement: 'Content supply · weekly async check-ins',
    ),
    _ProcessStep(
      title: 'Compound',
      description:
          'Go live, then keep compounding — content, SEO, automation, and '
          'iteration so the system gets sharper after launch.',
      duration: 'Ongoing',
      involvement: 'Monthly growth cadence · optional retainer',
    ),
  ];

  late final AnimationController _lineController;
  int _active = 0;
  bool _lineStarted = false;

  @override
  void initState() {
    super.initState();
    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
  }

  @override
  void dispose() {
    _lineController.dispose();
    super.dispose();
  }

  void _maybeStartLine() {
    if (_lineStarted) return;
    _lineStarted = true;
    _lineController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return SectionLandmark(
      label: 'Process',
      child: SectionContainer(
        maxWidth: 1200,
        backgroundColor: AppColors.surfaceMuted,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'Process',
              title: 'A calm path from unclear to unmistakable.',
              subtitle:
                  'Named stages. Clear involvement. No mysterious black boxes.',
            ),
            const SizedBox(height: AppSpacing.xxxl),
            VisibilityDetectorHook(
              onVisible: _maybeStartLine,
              child: isDesktop
                  ? _DesktopProcess(
                      steps: _steps,
                      active: _active,
                      line: _lineController,
                      onSelect: (i) => setState(() => _active = i),
                    )
                  : _MobileProcess(
                      steps: _steps,
                      active: _active,
                      onSelect: (i) => setState(() => _active = i),
                    ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              child: _ProcessDetail(
                key: ValueKey(_active),
                step: _steps[_active],
                index: _active,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Fires [onVisible] once when laid out (LazySection already defers build).
class VisibilityDetectorHook extends StatefulWidget {
  const VisibilityDetectorHook({
    required this.child,
    required this.onVisible,
    super.key,
  });

  final Widget child;
  final VoidCallback onVisible;

  @override
  State<VisibilityDetectorHook> createState() => _VisibilityDetectorHookState();
}

class _VisibilityDetectorHookState extends State<VisibilityDetectorHook> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.onVisible());
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _DesktopProcess extends StatelessWidget {
  const _DesktopProcess({
    required this.steps,
    required this.active,
    required this.line,
    required this.onSelect,
  });

  final List<_ProcessStep> steps;
  final int active;
  final AnimationController line;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 4,
          child: AnimatedBuilder(
            animation: line,
            builder: (context, _) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Container(
                        height: 2,
                        margin: const EdgeInsets.only(top: 1),
                        color: AppColors.border,
                      ),
                      Container(
                        height: 2,
                        margin: const EdgeInsets.only(top: 1),
                        width: constraints.maxWidth * line.value,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < steps.length; i++)
              Expanded(
                child: _ProcessNode(
                  index: i,
                  step: steps[i],
                  selected: i == active,
                  onTap: () => onSelect(i),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _MobileProcess extends StatelessWidget {
  const _MobileProcess({
    required this.steps,
    required this.active,
    required this.onSelect,
  });

  final List<_ProcessStep> steps;
  final int active;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          _ProcessNode(
            index: i,
            step: steps[i],
            selected: i == active,
            onTap: () => onSelect(i),
            compact: false,
          ),
      ],
    );
  }
}

class _ProcessNode extends StatefulWidget {
  const _ProcessNode({
    required this.index,
    required this.step,
    required this.selected,
    required this.onTap,
    this.compact = true,
  });

  final int index;
  final _ProcessStep step;
  final bool selected;
  final VoidCallback onTap;
  final bool compact;

  @override
  State<_ProcessNode> createState() => _ProcessNodeState();
}

class _ProcessNodeState extends State<_ProcessNode> {
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
        child: Padding(
          padding: EdgeInsets.only(
            right: widget.compact ? AppSpacing.sm : 0,
            bottom: widget.compact ? 0 : AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.selected ? AppColors.accent : AppColors.surface,
                      border: Border.all(
                        color: emphasize ? AppColors.accent : AppColors.borderStrong,
                      ),
                    ),
                    child: Text(
                      '${widget.index + 1}',
                      style: AppTypography.captionStyle.copyWith(
                        color: widget.selected
                            ? AppColors.textOnAccent
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  if (!widget.compact) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      widget.step.title,
                      style: AppTypography.bodyStrong.copyWith(
                        color: emphasize
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
              if (widget.compact) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  widget.step.title,
                  style: AppTypography.bodyStrong.copyWith(
                    fontSize: 15,
                    color: emphasize
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.step.duration,
                  style: AppTypography.captionStyle,
                ),
              ],
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 70 * widget.index),
          duration: 420.ms,
          curve: AppCurves.enter,
        );
  }
}

class _ProcessDetail extends StatelessWidget {
  const _ProcessDetail({
    required this.step,
    required this.index,
    super.key,
  });

  final _ProcessStep step;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '0${index + 1} · ${step.duration}',
            style: AppTypography.captionStyle.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            step.title,
            style: AppTypography.headingSStyle,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            step.description,
            style: AppTypography.bodyLargeStyle,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'What we need from you',
            style: AppTypography.captionStyle.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            step.involvement,
            style: AppTypography.bodyStyle.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
