import 'package:flutter/material.dart';

import '../utils/responsive.dart';

/// Builds different trees per [DeviceSize] without MediaQuery boilerplate.
///
/// Desktop is the default design target — [desktop] is required;
/// tablet/mobile fall back to desktop unless provided.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.desktop,
    this.tablet,
    this.mobile,
    super.key,
  });

  final WidgetBuilder desktop;
  final WidgetBuilder? tablet;
  final WidgetBuilder? mobile;

  @override
  Widget build(BuildContext context) {
    return switch (Responsive.of(context)) {
      DeviceSize.desktopLarge || DeviceSize.desktop => desktop(context),
      DeviceSize.tablet => (tablet ?? desktop)(context),
      DeviceSize.mobile => (mobile ?? tablet ?? desktop)(context),
    };
  }
}

/// Value-based responsive selector for non-widget values (padding, columns).
T responsiveValue<T>(
  BuildContext context, {
  required T desktop,
  T? tablet,
  T? mobile,
}) {
  return switch (Responsive.of(context)) {
    DeviceSize.desktopLarge || DeviceSize.desktop => desktop,
    DeviceSize.tablet => tablet ?? desktop,
    DeviceSize.mobile => mobile ?? tablet ?? desktop,
  };
}
