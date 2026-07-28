import 'package:flutter/material.dart';

import '../constants/curves.dart';
import '../constants/durations.dart';
import '../theme/app_colors.dart';
import 'motion_accessibility.dart';

/// Subtle scale on hover for desktop pointer interactions.
///
/// Intentionally tiny (1.01–1.02) — luxury sites whisper, they don't shout.
class HoverScale extends StatefulWidget {
  const HoverScale({
    required this.child,
    this.scale = 1.015,
    this.duration = AppDurations.fast,
    this.curve = AppCurves.hover,
    this.onTap,
    super.key,
  });

  final Widget child;
  final double scale;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onTap;

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final reduce = MotionAccessibility.reduceMotion(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: !reduce && _hovered ? widget.scale : 1,
          duration: reduce ? Duration.zero : widget.duration,
          curve: widget.curve,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Soft color / opacity shift on hover for links and text CTAs.
class HoverOpacity extends StatefulWidget {
  const HoverOpacity({
    required this.child,
    this.hoveredOpacity = 0.72,
    this.duration = AppDurations.fast,
    this.onTap,
    super.key,
  });

  final Widget child;
  final double hoveredOpacity;
  final Duration duration;
  final VoidCallback? onTap;

  @override
  State<HoverOpacity> createState() => _HoverOpacityState();
}

class _HoverOpacityState extends State<HoverOpacity> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
          opacity: _hovered ? widget.hoveredOpacity : 1,
          duration: widget.duration,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Cursor-aware hover lift with optional tilt (desktop only).
class CursorAwareHover extends StatefulWidget {
  const CursorAwareHover({
    required this.child,
    this.maxTilt = 0.018,
    this.lift = -6,
    this.scale = 1.015,
    this.onTap,
    super.key,
  });

  final Widget child;
  final double maxTilt;
  final double lift;
  final double scale;
  final VoidCallback? onTap;

  @override
  State<CursorAwareHover> createState() => _CursorAwareHoverState();
}

class _CursorAwareHoverState extends State<CursorAwareHover> {
  bool _hovered = false;
  Offset _tilt = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final reduce = MotionAccessibility.reduceMotion(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _tilt = Offset.zero;
      }),
      onHover: reduce
          ? null
          : (e) {
              final box = context.findRenderObject() as RenderBox?;
              if (box == null || !box.hasSize) return;
              final size = box.size;
              final nx = ((e.localPosition.dx / size.width) - 0.5) * 2;
              final ny = ((e.localPosition.dy / size.height) - 0.5) * 2;
              setState(() {
                _tilt = Offset(
                  ny * widget.maxTilt,
                  -nx * widget.maxTilt,
                );
              });
            },
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: reduce ? Duration.zero : AppDurations.fast,
          curve: AppCurves.hover,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(0.0, _hovered ? widget.lift : 0.0)
            ..scale(_hovered ? widget.scale : 1.0)
            ..rotateX(_tilt.dx)
            ..rotateY(_tilt.dy),
          transformAlignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Animated active underline for nav items.
class NavUnderline extends StatelessWidget {
  const NavUnderline({
    required this.active,
    this.color = AppColors.accent,
    this.height = 2,
    super.key,
  });

  final bool active;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final reduce = MotionAccessibility.reduceMotion(context);
    return AnimatedContainer(
      duration: reduce ? Duration.zero : AppDurations.indicator,
      curve: AppCurves.indicator,
      height: height,
      width: active ? 18 : 0,
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
