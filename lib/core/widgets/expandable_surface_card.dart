import 'package:flutter/material.dart';

import '../constants/curves.dart';
import '../constants/durations.dart';
import '../theme/app_colors.dart';
import '../theme/app_elevation.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

/// Surface that gently expands / lifts on hover — for outcome cards, etc.
class ExpandableSurfaceCard extends StatefulWidget {
  const ExpandableSurfaceCard({
    required this.child,
    this.onTap,
    this.padding,
    this.expandedPadding,
    this.borderRadius,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.showBorder = true,
    this.expandScale = 1.02,
    this.translateY = -6,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? expandedPadding;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? hoverBackgroundColor;
  final bool showBorder;
  final double expandScale;
  final double translateY;

  @override
  State<ExpandableSurfaceCard> createState() => _ExpandableSurfaceCardState();
}

class _ExpandableSurfaceCardState extends State<ExpandableSurfaceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? AppRadius.xlAll;
    final padding = _hovered
        ? (widget.expandedPadding ??
            widget.padding ??
            const EdgeInsets.all(AppSpacing.xl))
        : (widget.padding ?? const EdgeInsets.all(AppSpacing.xl));

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppDurations.normal,
          curve: AppCurves.hover,
          transform: Matrix4.identity()
            ..translate(0.0, _hovered ? widget.translateY : 0.0)
            ..scale(_hovered ? widget.expandScale : 1.0),
          transformAlignment: Alignment.center,
          padding: padding,
          decoration: BoxDecoration(
            color: _hovered
                ? (widget.hoverBackgroundColor ?? AppColors.surface)
                : (widget.backgroundColor ?? AppColors.surface),
            borderRadius: radius,
            border: widget.showBorder
                ? Border.all(
                    color: _hovered ? AppColors.borderStrong : AppColors.border,
                  )
                : null,
            boxShadow: _hovered ? AppElevation.medium : AppElevation.low,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
