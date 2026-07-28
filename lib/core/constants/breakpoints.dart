/// Responsive breakpoints for StepZero's desktop-first layout system.
///
/// Inspired by modern product sites (Linear, Stripe, Vercel):
/// content breathes on large screens, and collapses intentionally on mobile.
///
/// Usage:
/// ```dart
/// if (width >= Breakpoints.desktop) { ... }
/// ```
abstract final class Breakpoints {
  /// Phones in portrait.
  static const double mobile = 0;

  /// Large phones / small tablets.
  static const double mobileLarge = 480;

  /// Tablets / narrow laptops.
  static const double tablet = 768;

  /// Standard desktop — primary design target.
  static const double desktop = 1024;

  /// Wide desktop / marketing layouts.
  static const double desktopLarge = 1280;

  /// Ultra-wide content ceiling before max-width kicks in.
  static const double desktopXLarge = 1440;

  /// Hard max content width for reading comfort.
  static const double maxContentWidth = 1200;

  /// Slightly wider for hero / full-bleed editorial sections.
  static const double maxHeroWidth = 1400;
}
