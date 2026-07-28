import 'package:flutter/widgets.dart';

/// Widget composition helpers used at call sites for cleaner trees.
extension WidgetX on Widget {
  Widget padded([EdgeInsetsGeometry padding = const EdgeInsets.all(16)]) =>
      Padding(padding: padding, child: this);

  Widget centered() => Center(child: this);

  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  Widget constrained({
    double? maxWidth,
    double? maxHeight,
    double? minWidth,
    double? minHeight,
  }) =>
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? double.infinity,
          maxHeight: maxHeight ?? double.infinity,
          minWidth: minWidth ?? 0,
          minHeight: minHeight ?? 0,
        ),
        child: this,
      );

  Widget opacity(double value) => Opacity(opacity: value, child: this);

  Widget ignorePointer({bool ignoring = true}) =>
      IgnorePointer(ignoring: ignoring, child: this);
}
