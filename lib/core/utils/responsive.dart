import 'package:flutter/material.dart';

import '../constants/breakpoints.dart';
import '../theme/theme_extensions.dart';

/// Device size class derived from viewport width.
enum DeviceSize {
  mobile,
  tablet,
  desktop,
  desktopLarge,
}

/// Responsive helpers — desktop-first with intentional mobile collapse.
abstract final class Responsive {
  static DeviceSize deviceSizeOf(double width) {
    if (width >= Breakpoints.desktopLarge) return DeviceSize.desktopLarge;
    if (width >= Breakpoints.desktop) return DeviceSize.desktop;
    if (width >= Breakpoints.tablet) return DeviceSize.tablet;
    return DeviceSize.mobile;
  }

  static DeviceSize of(BuildContext context) =>
      deviceSizeOf(MediaQuery.sizeOf(context).width);

  static bool isMobile(BuildContext context) =>
      of(context) == DeviceSize.mobile;

  static bool isTablet(BuildContext context) =>
      of(context) == DeviceSize.tablet;

  static bool isDesktop(BuildContext context) {
    final size = of(context);
    return size == DeviceSize.desktop || size == DeviceSize.desktopLarge;
  }

  static bool isDesktopLarge(BuildContext context) =>
      of(context) == DeviceSize.desktopLarge;

  /// Horizontal page gutter scales with viewport.
  static double pageGutter(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= Breakpoints.desktop) return 64;
    if (width >= Breakpoints.tablet) return 32;
    return 16;
  }

  /// Section vertical padding — more air on desktop.
  static double sectionPaddingY(BuildContext context) {
    if (isDesktop(context)) return 120;
    if (isTablet(context)) return 80;
    return 64;
  }

  /// Scales a desktop typography size down for smaller viewports.
  static double fluidFontSize(
    BuildContext context, {
    required double desktop,
    double? tablet,
    double? mobile,
  }) {
    final size = of(context);
    return switch (size) {
      DeviceSize.desktopLarge || DeviceSize.desktop => desktop,
      DeviceSize.tablet => tablet ?? desktop * 0.75,
      DeviceSize.mobile => mobile ?? desktop * 0.55,
    };
  }

  /// Hero display size — dramatic on desktop, restrained on mobile.
  static double heroFontSize(BuildContext context) => fluidFontSize(
        context,
        desktop: 80,
        tablet: 56,
        mobile: 40,
      );

  static double contentMaxWidth(BuildContext context) {
    final theme = Theme.of(context).extension<StepZeroTheme>();
    return theme?.contentMaxWidth ?? Breakpoints.maxContentWidth;
  }
}
