import 'package:flutter/material.dart';

import '../constants/curves.dart';
import '../constants/durations.dart';
import '../widgets/lazy_section.dart';
import 'motion_accessibility.dart';

/// Subtle scroll / pointer parallax for depth layers (hero glows, cards).
///
/// Desktop-friendly. Amplitude stays tiny — depth, not distraction.
class ParallaxLayer extends StatefulWidget {
  const ParallaxLayer({
    required this.child,
    this.scrollFactor = 0.08,
    this.pointerFactor = 12,
    this.enablePointer = true,
    this.enableScroll = true,
    super.key,
  });

  final Widget child;
  final double scrollFactor;
  final double pointerFactor;
  final bool enablePointer;
  final bool enableScroll;

  @override
  State<ParallaxLayer> createState() => _ParallaxLayerState();
}

class _ParallaxLayerState extends State<ParallaxLayer> {
  Offset _pointer = Offset.zero;
  double _scrollDy = 0;
  ScrollController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final next = ShellScroll.maybeOf(context);
    if (next != _controller) {
      _controller?.removeListener(_onScroll);
      _controller = next;
      _controller?.addListener(_onScroll);
      _onScroll();
    }
  }

  void _onScroll() {
    if (!mounted || !widget.enableScroll) return;
    if (_controller?.hasClients != true) return;
    final next = -_controller!.offset * widget.scrollFactor;
    if ((next - _scrollDy).abs() < 0.3) return;
    setState(() => _scrollDy = next);
  }

  @override
  void dispose() {
    _controller?.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MotionAccessibility.reduceMotion(context)) {
      return widget.child;
    }

    final dx = widget.enablePointer ? _pointer.dx : 0.0;
    final dy = (widget.enablePointer ? _pointer.dy : 0.0) +
        (widget.enableScroll ? _scrollDy : 0.0);

    final layer = AnimatedContainer(
      duration: AppDurations.magnetic,
      curve: AppCurves.magnetic,
      transform: Matrix4.translationValues(dx, dy, 0),
      child: widget.child,
    );

    if (!widget.enablePointer) return layer;

    return MouseRegion(
      opaque: false,
      onHover: (e) {
        final box = context.findRenderObject() as RenderBox?;
        if (box == null || !box.hasSize) return;
        final size = box.size;
        final local = e.localPosition;
        final px =
            ((local.dx / size.width) - 0.5) * 2 * widget.pointerFactor;
        final py =
            ((local.dy / size.height) - 0.5) * 2 * widget.pointerFactor;
        setState(() => _pointer = Offset(px, py));
      },
      onExit: (_) => setState(() => _pointer = Offset.zero),
      child: layer,
    );
  }
}

/// Slowly drifting gradient wash — ambient hero / CTA atmosphere.
class DriftingGradient extends StatefulWidget {
  const DriftingGradient({
    required this.colors,
    this.duration = const Duration(seconds: 14),
    this.borderRadius,
    this.child,
    super.key,
  });

  final List<Color> colors;
  final Duration duration;
  final BorderRadius? borderRadius;
  final Widget? child;

  @override
  State<DriftingGradient> createState() => _DriftingGradientState();
}

class _DriftingGradientState extends State<DriftingGradient>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MotionAccessibility.reduceMotion(context)) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.colors,
          ),
        ),
        child: widget.child,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = CurvedAnimation(
          parent: _controller,
          curve: AppCurves.ambient,
        ).value;
        final begin = Alignment(-1 + t * 0.4, -1 + t * 0.2);
        final end = Alignment(1 - t * 0.3, 1 - t * 0.4);
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: widget.colors,
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
