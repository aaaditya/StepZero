import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/curves.dart';
import '../constants/durations.dart';
import 'motion_accessibility.dart';

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

  /// Fade + slight scale settle (cards / media).
  static List<Effect<dynamic>> fadeScale({
    Duration? delay,
    Duration? duration,
    double begin = 0.97,
  }) =>
      [
        FadeEffect(
          delay: delay,
          duration: duration ?? AppDurations.slow,
          curve: AppCurves.enter,
          begin: 0,
          end: 1,
        ),
        ScaleEffect(
          delay: delay,
          duration: duration ?? AppDurations.slow,
          curve: AppCurves.enter,
          begin: Offset(begin, begin),
          end: const Offset(1, 1),
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
  static Duration staggerDelay(int index, {Duration? base, bool tight = false}) =>
      (base ?? Duration.zero) +
      ((tight ? AppDurations.staggerTight : AppDurations.stagger) * index);
}

/// Convenience wrapper applying [AppAnimations.fadeUp] with reduced-motion gate.
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
    if (MotionAccessibility.reduceMotion(context)) return child;
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
    if (MotionAccessibility.reduceMotion(context)) return child;
    return child.animate(
      effects: AppAnimations.fadeIn(delay: delay, duration: duration),
    );
  }
}

/// Convenience wrapper applying [AppAnimations.fadeScale].
class FadeScale extends StatelessWidget {
  const FadeScale({
    required this.child,
    this.delay,
    this.duration,
    this.begin = 0.97,
    super.key,
  });

  final Widget child;
  final Duration? delay;
  final Duration? duration;
  final double begin;

  @override
  Widget build(BuildContext context) {
    if (MotionAccessibility.reduceMotion(context)) return child;
    return child.animate(
      effects: AppAnimations.fadeScale(
        delay: delay,
        duration: duration,
        begin: begin,
      ),
    );
  }
}
