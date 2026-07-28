import 'package:flutter/material.dart';

import '../constants/curves.dart';
import '../constants/durations.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import 'motion_accessibility.dart';

/// Premium loading skeleton with soft shimmer — for lazy / progressive media.
class MotionSkeleton extends StatefulWidget {
  const MotionSkeleton({
    this.width,
    this.height = 16,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    super.key,
  });

  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  State<MotionSkeleton> createState() => _MotionSkeletonState();
}

class _MotionSkeletonState extends State<MotionSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? AppRadius.mdAll;
    final base = widget.baseColor ?? AppColors.surfaceMuted;
    final highlight =
        widget.highlightColor ?? AppColors.surface.withValues(alpha: 0.9);

    if (MotionAccessibility.reduceMotion(context)) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(color: base, borderRadius: radius),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: LinearGradient(
              begin: Alignment(-1.0 + 2.0 * _controller.value, 0),
              end: Alignment(-0.2 + 2.0 * _controller.value, 0),
              colors: [base, highlight, base],
              stops: const [0.25, 0.5, 0.75],
            ),
          ),
        );
      },
    );
  }
}

/// Progressive image shell — skeleton → fade-in content.
class ProgressiveReveal extends StatelessWidget {
  const ProgressiveReveal({
    required this.child,
    required this.ready,
    this.skeleton,
    this.duration = AppDurations.slow,
    super.key,
  });

  final Widget child;
  final bool ready;
  final Widget? skeleton;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final reduce = MotionAccessibility.reduceMotion(context);
    return AnimatedSwitcher(
      duration: reduce ? Duration.zero : duration,
      switchInCurve: AppCurves.enter,
      switchOutCurve: AppCurves.exit,
      child: ready
          ? KeyedSubtree(key: const ValueKey('ready'), child: child)
          : KeyedSubtree(
              key: const ValueKey('skeleton'),
              child: skeleton ??
                  const MotionSkeleton(height: 180, width: double.infinity),
            ),
    );
  }
}
