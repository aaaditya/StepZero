import 'package:flutter/widgets.dart';

/// Shared reduced-motion gate used by motion primitives.
abstract final class MotionAccessibility {
  static bool reduceMotion(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context);
}
