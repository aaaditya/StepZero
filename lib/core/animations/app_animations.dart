import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/curves.dart';
import '../constants/durations.dart';

/// Shared motion recipes built on flutter_animate.
///
/// Keep reveals subtle — premium brands fade/slide a few pixels, they don't bounce.
abstract final class AppAnimations {
  /// Soft fade + slight upward settle for section entrances.
  static List<Effect<dynamic>> fadeUp({
    Duration? delay,
    Duration? duration,
    double offset = 16,
  }) =>
      [
        FadeEffect(
          delay: delay,
          duration: duration ?? AppDurations.slow,
          curve: AppCurves.enter,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          delay: delay,
          duration: duration ?? AppDurations.slow,
          curve: AppCurves.enter,
          begin: Offset(0, offset),
          end: Offset.zero,
        ),
      ];

  /// Opacity-only reveal for text that shouldn't travel.
  static List<Effect<dynamic>> fadeIn({
    Duration? delay,
    Duration? duration,
  }) =>
      [
        FadeEffect(
          delay: delay,
          duration: duration ?? AppDurations.slow,
          curve: AppCurves.enter,
          begin: 0,
          end: 1,
        ),
      ];

  /// Stagger helper — multiply index by [AppDurations.stagger].
  static Duration staggerDelay(int index, {Duration? base}) =>
      (base ?? Duration.zero) + (AppDurations.stagger * index);
}

/// Convenience wrapper applying [AppAnimations.fadeUp].
class FadeUp extends StatelessWidget {
  const FadeUp({
    required this.child,
    this.delay,
    this.duration,
    this.offset = 16,
    super.key,
  });

  final Widget child;
  final Duration? delay;
  final Duration? duration;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return child.animate(
      effects: AppAnimations.fadeUp(
        delay: delay,
        duration: duration,
        offset: offset,
      ),
    );
  }
}

/// Convenience wrapper applying [AppAnimations.fadeIn].
class FadeIn extends StatelessWidget {
  const FadeIn({
    required this.child,
    this.delay,
    this.duration,
    super.key,
  });

  final Widget child;
  final Duration? delay;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return child.animate(
      effects: AppAnimations.fadeIn(delay: delay, duration: duration),
    );
  }
}
