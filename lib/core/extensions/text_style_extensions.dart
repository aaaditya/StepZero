import 'package:flutter/painting.dart';

/// Fluent [TextStyle] transforms for compositional typography.
extension TextStyleX on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withSize(double size) => copyWith(fontSize: size);

  TextStyle withHeight(double height) => copyWith(height: height);

  TextStyle withTracking(double letterSpacing) =>
      copyWith(letterSpacing: letterSpacing);
}
