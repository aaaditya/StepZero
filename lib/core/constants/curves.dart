import 'package:flutter/animation.dart';

/// Named easing curves for StepZero motion.
///
/// Prefer decelerate-style curves for entrances (premium, settled)
/// and subtle ease for hover so interactions feel intentional, not springy.
abstract final class AppCurves {
  /// Default UI motion — smooth and confident.
  static const Curve standard = Curves.easeOutCubic;

  /// Entrances / reveals — settles into place.
  static const Curve enter = Curves.easeOutQuart;

  /// Exits — slightly quicker departure.
  static const Curve exit = Curves.easeInCubic;

  /// Hover scale / color shifts.
  static const Curve hover = Curves.easeOut;

  /// Emphasis / hero motion.
  static const Curve emphasis = Curves.easeOutExpo;

  /// Page route transitions.
  static const Curve page = Curves.easeInOutCubic;
}
