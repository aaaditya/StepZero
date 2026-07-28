import 'package:flutter/material.dart';

import '../constants/curves.dart';
import '../constants/durations.dart';

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
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? widget.scale : 1,
          duration: widget.duration,
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
