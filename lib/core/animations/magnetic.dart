import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants/curves.dart';
import '../constants/durations.dart';
import 'motion_accessibility.dart';

/// Cursor-aware magnetic attraction for CTAs (desktop pointer only).
///
/// Pulls the child a few pixels toward the pointer — Apple/Linear restraint,
/// not a physics toy. No-ops on touch / reduced motion.
///
/// Avoids [LayoutBuilder] so it works inside [IntrinsicWidth] buttons.
class Magnetic extends StatefulWidget {
  const Magnetic({
    required this.child,
    this.maxOffset = 10,
    this.enabled = true,
    this.duration = AppDurations.magnetic,
    super.key,
  });

  final Widget child;
  final double maxOffset;
  final bool enabled;
  final Duration duration;

  @override
  State<Magnetic> createState() => _MagneticState();
}

class _MagneticState extends State<Magnetic> {
  Offset _offset = Offset.zero;

  void _onHover(PointerHoverEvent event) {
    if (!widget.enabled) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final size = box.size;
    if (size.width <= 0 || size.height <= 0) return;
    final center = Offset(size.width / 2, size.height / 2);
    final local = event.localPosition;
    final dx = ((local.dx - center.dx) / center.dx).clamp(-1.0, 1.0);
    final dy = ((local.dy - center.dy) / center.dy).clamp(-1.0, 1.0);
    setState(() {
      _offset = Offset(dx * widget.maxOffset, dy * widget.maxOffset);
    });
  }

  void _reset() {
    if (_offset == Offset.zero) return;
    setState(() => _offset = Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    if (MotionAccessibility.reduceMotion(context) || !widget.enabled) {
      return widget.child;
    }

    return MouseRegion(
      onHover: _onHover,
      onExit: (_) => _reset(),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: AppCurves.magnetic,
        transform: Matrix4.translationValues(_offset.dx, _offset.dy, 0),
        child: widget.child,
      ),
    );
  }
}

/// Soft ambient glow pulse — for primary CTAs / dark surfaces.
class SoftPulse extends StatefulWidget {
  const SoftPulse({
    required this.child,
    this.color,
    this.minOpacity = 0.12,
    this.maxOpacity = 0.28,
    this.blur = 28,
    this.enabled = true,
    this.duration = AppDurations.ambient,
    super.key,
  });

  final Widget child;
  final Color? color;
  final double minOpacity;
  final double maxOpacity;
  final double blur;
  final bool enabled;
  final Duration duration;

  @override
  State<SoftPulse> createState() => _SoftPulseState();
}

class _SoftPulseState extends State<SoftPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    if (widget.enabled) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant SoftPulse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.enabled && _controller.isAnimating) {
      _controller
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MotionAccessibility.reduceMotion(context) || !widget.enabled) {
      return widget.child;
    }

    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = CurvedAnimation(
          parent: _controller,
          curve: AppCurves.ambient,
        ).value;
        final opacity =
            widget.minOpacity + (widget.maxOpacity - widget.minOpacity) * t;
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: opacity),
                blurRadius: widget.blur,
                spreadRadius: 0,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Press scale feedback for buttons / interactive surfaces.
class PressableScale extends StatefulWidget {
  const PressableScale({
    required this.child,
    this.onTap,
    this.scale = 0.97,
    this.duration = AppDurations.instant,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  final Duration duration;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final reduce = MotionAccessibility.reduceMotion(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: widget.onTap == null || reduce
          ? null
          : (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? widget.scale : 1,
        duration: reduce ? Duration.zero : widget.duration,
        curve: AppCurves.hover,
        child: widget.child,
      ),
    );
  }
}
