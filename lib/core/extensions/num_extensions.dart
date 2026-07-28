import 'package:flutter/widgets.dart';

/// Numeric sugar for spacing / sizing without magic-number noise.
extension NumSpacing on num {
  double get sp => toDouble();

  SizedBox get verticalSpace => SizedBox(height: toDouble());

  SizedBox get horizontalSpace => SizedBox(width: toDouble());

  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: toDouble());

  BorderRadius get circular => BorderRadius.circular(toDouble());
}
