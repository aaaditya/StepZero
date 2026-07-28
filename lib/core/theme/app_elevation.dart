import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Elevation / shadow tokens.
///
/// Premium sites use almost no shadow. When elevation is needed,
/// keep it soft, low-contrast, and single-layer.
abstract final class AppElevation {
  static const List<BoxShadow> none = <BoxShadow>[];

  /// Barely-there lift for interactive surfaces on hover.
  static const List<BoxShadow> low = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  /// Soft card / popover elevation.
  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  /// Modal / overlay elevation.
  static const List<BoxShadow> high = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 40,
      offset: Offset(0, 16),
    ),
  ];

  /// Focus ring used for keyboard accessibility.
  static List<BoxShadow> focusRing({
    Color color = AppColors.borderFocus,
    double spread = 3,
  }) =>
      [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 0,
          spreadRadius: spread,
        ),
      ];
}
