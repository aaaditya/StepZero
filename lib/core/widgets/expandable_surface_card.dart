import 'package:flutter/material.dart';

import '../animations/motion_accessibility.dart';
import '../constants/curves.dart';
import '../constants/durations.dart';
import '../theme/app_colors.dart';
import '../theme/app_elevation.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

/// Surface that gently expands / lifts on hover — for outcome cards, etc.
///
/// Adds subtle tilt, border emphasis, and accent glow without layout redesign.
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
    this.enableTilt = true,
    this.glowOnHover = true,
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
  final bool enableTilt;
  final bool glowOnHover;

  @override
  State<ExpandableSurfaceCard> createState() => _ExpandableSurfaceCardState();
}

class _ExpandableSurfaceCardState extends State<ExpandableSurfaceCard> {
  bool _hovered = false;
  Offset _tilt = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final reduce = MotionAccessibility.reduceMotion(context);
    final radius = widget.borderRadius ?? AppRadius.xlAll;
    final padding = _hovered
        ? (widget.expandedPadding ??
            widget.padding ??
            const EdgeInsets.all(AppSpacing.xl))
        : (widget.padding ?? const EdgeInsets.all(AppSpacing.xl));

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _tilt = Offset.zero;
      }),
      onHover: reduce || !widget.enableTilt
          ? null
          : (e) {
              final box = context.findRenderObject() as RenderBox?;
              if (box == null || !box.hasSize) return;
              final size = box.size;
              final nx = ((e.localPosition.dx / size.width) - 0.5) * 2;
              final ny = ((e.localPosition.dy / size.height) - 0.5) * 2;
              setState(() {
                _tilt = Offset(ny * 0.012, -nx * 0.014);
              });
            },
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: reduce ? Duration.zero : AppDurations.normal,
          curve: AppCurves.hover,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(0.0, _hovered && !reduce ? widget.translateY : 0.0)
            ..scale(_hovered && !reduce ? widget.expandScale : 1.0)
            ..rotateX(_tilt.dx)
            ..rotateY(_tilt.dy),
          transformAlignment: Alignment.center,
          padding: padding,
          decoration: BoxDecoration(
            color: _hovered
                ? (widget.hoverBackgroundColor ?? AppColors.surface)
                : (widget.backgroundColor ?? AppColors.surface),
            borderRadius: radius,
            border: widget.showBorder
                ? Border.all(
                    color: _hovered
                        ? AppColors.accent.withValues(alpha: 0.35)
                        : AppColors.border,
                    width: _hovered ? 1.2 : 1,
                  )
                : null,
            boxShadow: [
              if (_hovered) ...AppElevation.medium,
              if (_hovered && widget.glowOnHover && !reduce)
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.12),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Media zoom on hover — for case study / insight imagery.
class HoverZoomMedia extends StatefulWidget {
  const HoverZoomMedia({
    required this.child,
    this.scale = 1.04,
    this.borderRadius,
    super.key,
  });

  final Widget child;
  final double scale;
  final BorderRadius? borderRadius;

  @override
  State<HoverZoomMedia> createState() => _HoverZoomMediaState();
}

class _HoverZoomMediaState extends State<HoverZoomMedia> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final reduce = MotionAccessibility.reduceMotion(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? AppRadius.lgAll,
        child: AnimatedScale(
          scale: !reduce && _hovered ? widget.scale : 1,
          duration: reduce ? Duration.zero : AppDurations.slow,
          curve: AppCurves.hover,
          child: widget.child,
        ),
      ),
    );
  }
}
