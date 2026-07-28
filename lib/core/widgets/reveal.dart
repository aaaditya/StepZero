import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/curves.dart';
import '../constants/durations.dart';

/// Fade + slide entrance that no-ops when reduced motion is preferred.
class Reveal extends StatelessWidget {
  const Reveal({
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppDurations.slow,
    this.offset = 18,
    this.fade = true,
    this.slide = true,
    super.key,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;
  final bool fade;
  final bool slide;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return child;

    var animated = child.animate(delay: delay);
    if (fade) {
      animated = animated.fadeIn(duration: duration, curve: AppCurves.enter);
    }
    if (slide) {
      animated = animated.moveY(
        begin: offset,
        end: 0,
        duration: duration,
        curve: AppCurves.enter,
      );
    }
    return animated;
  }
}

/// Applies staggered [Reveal] delays to a list of children.
class StaggeredReveal extends StatelessWidget {
  const StaggeredReveal({
    required this.children,
    this.baseDelay = Duration.zero,
    this.step = AppDurations.stagger,
    this.duration = AppDurations.slow,
    this.offset = 16,
    this.direction = Axis.vertical,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.spacing = 0,
    super.key,
  });

  final List<Widget> children;
  final Duration baseDelay;
  final Duration step;
  final Duration duration;
  final double offset;
  final Axis direction;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final revealed = [
      for (var i = 0; i < children.length; i++)
        Reveal(
          delay: baseDelay + (step * i),
          duration: duration,
          offset: offset,
          child: children[i],
        ),
    ];

    if (direction == Axis.vertical) {
      return Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: [
          for (var i = 0; i < revealed.length; i++) ...[
            revealed[i],
            if (spacing > 0 && i != revealed.length - 1) SizedBox(height: spacing),
          ],
        ],
      );
    }

    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: [
        for (var i = 0; i < revealed.length; i++) ...[
          revealed[i],
          if (spacing > 0 && i != revealed.length - 1) SizedBox(width: spacing),
        ],
      ],
    );
  }
}

/// Semantic landmark wrapper for homepage sections.
class SectionLandmark extends StatelessWidget {
  const SectionLandmark({
    required this.label,
    required this.child,
    this.header = true,
    super.key,
  });

  final String label;
  final Widget child;
  final bool header;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: label,
      header: header,
      child: child,
    );
  }
}
