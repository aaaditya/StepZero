import 'package:flutter/widgets.dart';

/// Spacing scale — 4pt base grid.
///
/// Prefer named tokens over raw doubles so layout rhythm stays intentional.
abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
  static const double huge = 80;
  static const double massive = 96;
  static const double section = 120;

  // ─── Semantic aliases ───────────────────────────────────────

  /// Default gap between related inline elements.
  static const double inlineGap = xs;

  /// Gap between stacked text blocks (headline → body).
  static const double stackGap = md;

  /// Gap between section headline and content.
  static const double sectionHeaderGap = xl;

  /// Vertical padding for a standard marketing section.
  static const double sectionY = section;

  /// Horizontal page gutter — desktop.
  static const double pageGutterDesktop = xxxl;

  /// Horizontal page gutter — tablet.
  static const double pageGutterTablet = xl;

  /// Horizontal page gutter — mobile.
  static const double pageGutterMobile = md;

  // ─── EdgeInsets helpers ─────────────────────────────────────

  static const EdgeInsets zero = EdgeInsets.zero;

  static EdgeInsets all(double value) => EdgeInsets.all(value);

  static EdgeInsets symmetric({
    double horizontal = 0,
    double vertical = 0,
  }) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);

  static EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
}
