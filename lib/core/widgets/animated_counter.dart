import 'package:flutter/material.dart';

import '../constants/curves.dart';
import '../constants/durations.dart';
import '../theme/app_typography.dart';

/// Animates a numeric value with optional prefix/suffix (e.g. `+142%`).
///
/// Respects [MediaQuery.disableAnimations] for WCAG / reduced-motion.
class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    required this.value,
    this.prefix = '',
    this.suffix = '',
    this.duration = const Duration(milliseconds: 1200),
    this.curve = AppCurves.enter,
    this.style,
    this.decimalPlaces = 0,
    this.semanticLabel,
    super.key,
  });

  final double value;
  final String prefix;
  final String suffix;
  final Duration duration;
  final Curve curve;
  final TextStyle? style;
  final int decimalPlaces;
  final String? semanticLabel;

  /// Parses strings like `+142%`, `-38%`, `4.9` into an [AnimatedCounter].
  factory AnimatedCounter.fromMetricString(
    String raw, {
    Key? key,
    TextStyle? style,
    String? semanticLabel,
  }) {
    final match = RegExp(r'^([^0-9\-]*)(-?\d+(?:\.\d+)?)(.*)$').firstMatch(raw);
    if (match == null) {
      return AnimatedCounter(
        key: key,
        value: 0,
        prefix: raw,
        style: style,
        semanticLabel: semanticLabel ?? raw,
      );
    }
    final number = double.tryParse(match.group(2)!) ?? 0;
    final decimals = match.group(2)!.contains('.')
        ? match.group(2)!.split('.').last.length
        : 0;
    return AnimatedCounter(
      key: key,
      value: number,
      prefix: match.group(1) ?? '',
      suffix: match.group(3) ?? '',
      decimalPlaces: decimals,
      style: style,
      semanticLabel: semanticLabel ?? raw,
    );
  }

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller
        ..duration = widget.duration
        ..forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final style = widget.style ?? AppTypography.headingSStyle;

    if (reduceMotion) {
      return Semantics(
        label: widget.semanticLabel,
        child: Text(_format(widget.value), style: style),
      );
    }

    return Semantics(
      label: widget.semanticLabel,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          final current = widget.value * _animation.value;
          return Text(_format(current), style: style);
        },
      ),
    );
  }

  String _format(double value) {
    if (widget.decimalPlaces <= 0) {
      return '${widget.prefix}${value.round()}${widget.suffix}';
    }
    return '${widget.prefix}${value.toStringAsFixed(widget.decimalPlaces)}${widget.suffix}';
  }
}

/// Convenience duration alias used by metric chips.
abstract final class CounterDurations {
  static const Duration standard = Duration(milliseconds: 1200);
  static const Duration quick = AppDurations.slow;
}
