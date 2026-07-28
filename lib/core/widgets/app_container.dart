import 'package:flutter/material.dart';

import '../constants/breakpoints.dart';
import '../theme/app_spacing.dart';
import '../utils/responsive.dart';

/// Centers children and clamps width to the content max.
///
/// Every marketing section should sit inside this (or [SectionContainer])
/// so gutters and max-width stay consistent site-wide.
class MaxWidthBox extends StatelessWidget {
  const MaxWidthBox({
    required this.child,
    this.maxWidth,
    this.padding,
    this.alignment = Alignment.topCenter,
    super.key,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final gutter = Responsive.pageGutter(context);
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? Breakpoints.maxContentWidth,
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: gutter),
          child: child,
        ),
      ),
    );
  }
}

/// Standard vertical section shell with responsive padding + max width.
class SectionContainer extends StatelessWidget {
  const SectionContainer({
    required this.child,
    this.maxWidth,
    this.padding,
    this.backgroundColor,
    this.id,
    super.key,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  /// Optional anchor id for in-page deep links (web).
  final String? id;

  @override
  Widget build(BuildContext context) {
    final sectionY = Responsive.sectionPaddingY(context);
    final content = MaxWidthBox(
      maxWidth: maxWidth,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: Responsive.pageGutter(context),
            vertical: sectionY,
          ),
      child: child,
    );

    if (backgroundColor == null) return content;

    return ColoredBox(
      color: backgroundColor!,
      child: content,
    );
  }
}

/// Adaptive padding that follows desktop / tablet / mobile gutters.
class ResponsivePadding extends StatelessWidget {
  const ResponsivePadding({
    required this.child,
    this.desktop = AppSpacing.pageGutterDesktop,
    this.tablet = AppSpacing.pageGutterTablet,
    this.mobile = AppSpacing.pageGutterMobile,
    this.vertical = 0,
    super.key,
  });

  final Widget child;
  final double desktop;
  final double tablet;
  final double mobile;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    final horizontal = switch (Responsive.of(context)) {
      DeviceSize.desktopLarge || DeviceSize.desktop => desktop,
      DeviceSize.tablet => tablet,
      DeviceSize.mobile => mobile,
    };
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: child,
    );
  }
}
