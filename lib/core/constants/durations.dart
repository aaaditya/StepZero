/// Motion duration tokens — Linear / Apple calm pacing.
///
/// Prefer these over magic numbers so motion feels consistent
/// across hover, page transitions, and reveal sequences.
abstract final class AppDurations {
  /// Micro interactions (opacity flicker, focus ring, press).
  static const Duration instant = Duration(milliseconds: 100);

  /// Hover / press feedback.
  static const Duration fast = Duration(milliseconds: 180);

  /// Default UI transitions.
  static const Duration normal = Duration(milliseconds: 280);

  /// Section reveals, page fades.
  static const Duration slow = Duration(milliseconds: 420);

  /// Hero / cinematic entrances.
  static const Duration dramatic = Duration(milliseconds: 700);

  /// Soft ambient loops (float, gradient drift, pulse).
  static const Duration ambient = Duration(milliseconds: 4200);

  /// Magnetic catch-up / pointer follow.
  static const Duration magnetic = Duration(milliseconds: 220);

  /// Nav underline / indicator slide.
  static const Duration indicator = Duration(milliseconds: 320);

  /// Counter / metric count-up.
  static const Duration counter = Duration(milliseconds: 1200);

  /// Stagger delay between sibling reveal items.
  static const Duration stagger = Duration(milliseconds: 80);

  /// Tight stagger for headlines (letter/word groups).
  static const Duration staggerTight = Duration(milliseconds: 48);

  /// Page route transition.
  static const Duration page = Duration(milliseconds: 320);

  /// Page route reverse.
  static const Duration pageReverse = Duration(milliseconds: 240);
}
