/// Animation duration tokens.
///
/// Prefer these over magic numbers so motion feels consistent
/// across hover, page transitions, and reveal sequences.
abstract final class AppDurations {
  /// Micro interactions (opacity flicker, focus ring).
  static const Duration instant = Duration(milliseconds: 100);

  /// Hover / press feedback.
  static const Duration fast = Duration(milliseconds: 180);

  /// Default UI transitions.
  static const Duration normal = Duration(milliseconds: 280);

  /// Section reveals, page fades.
  static const Duration slow = Duration(milliseconds: 420);

  /// Hero / cinematic entrances.
  static const Duration dramatic = Duration(milliseconds: 700);

  /// Stagger delay between sibling reveal items.
  static const Duration stagger = Duration(milliseconds: 80);
}
