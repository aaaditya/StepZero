import 'package:flutter/material.dart';

import '../theme/theme_extensions.dart';
import '../utils/responsive.dart';

/// Ergonomic [BuildContext] accessors used across the design system.
extension StepZeroContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  StepZeroTheme get sz => theme.extension<StepZeroTheme>()!;

  MediaQueryData get mq => MediaQuery.of(this);

  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  DeviceSize get deviceSize => Responsive.of(this);

  bool get isMobile => Responsive.isMobile(this);

  bool get isTablet => Responsive.isTablet(this);

  bool get isDesktop => Responsive.isDesktop(this);

  double get pageGutter => Responsive.pageGutter(this);

  double get sectionPaddingY => Responsive.sectionPaddingY(this);
}
