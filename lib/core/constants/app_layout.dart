/// Shared layout / a11y / interaction constants — no magic numbers in UI.
abstract final class AppLayout {
  /// WCAG / Material recommended minimum touch target.
  static const double minTouchTarget = 48;

  /// Content reading column for long-form.
  static const double readingMaxWidth = 680;

  /// Marketing page content max.
  static const double pageMaxWidth = 1200;

  /// Hero / featured work ultra-wide.
  static const double heroMaxWidth = 1440;

  /// Glass nav resting height (content row).
  static const double navContentHeight = 64;

  /// Glass nav scrolled height.
  static const double navContentHeightScrolled = 58;

  /// Scroll offset that elevates the glass nav.
  static const double navElevateOffset = 12;

  /// Device mock accent for restaurant case study (teal).
  static const int accentTeal = 0xFF0F766E;

  /// Dark CTA wash mid-stop.
  static const int ctaMid = 0xFF1A1A2E;

  /// Window chrome (device mocks).
  static const int chromeDark = 0xFF1A1A1A;
  static const int chromeMuted = 0xFF2A2A2A;

  /// Traffic-light controls on window chrome.
  static const int trafficRed = 0xFFFF5F57;
  static const int trafficAmber = 0xFFFFBD2E;
  static const int trafficGreen = 0xFF28C840;
}
