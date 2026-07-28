import 'dart:ui';

import 'package:flutter/material.dart';

import '../animations/motion_accessibility.dart';
import '../constants/curves.dart';
import '../constants/durations.dart';
import '../theme/app_colors.dart';
import '../theme/app_elevation.dart';
import '../theme/app_radius.dart';

/// Glassmorphism floating card — reusable across marketing surfaces.
class FloatingGlassCard extends StatefulWidget {
  const FloatingGlassCard({
    required this.child,
    this.width,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
    this.float = true,
    this.floatOffset = 8,
    this.floatDuration = const Duration(milliseconds: 3200),
    this.floatDelay = Duration.zero,
    this.rotateAmplitude = 0.012,
    this.enableHoverLift = true,
    this.hoverScale = 1.03,
    this.blurSigma = 18,
    this.opacity = 0.72,
    this.onTap,
    super.key,
  });

  final Widget child;
  final double? width;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;
  final bool float;
  final double floatOffset;
  final Duration floatDuration;
  final Duration floatDelay;
  final double rotateAmplitude;
  final bool enableHoverLift;
  final double hoverScale;
  final double blurSigma;
  final double opacity;
  final VoidCallback? onTap;

  @override
  State<FloatingGlassCard> createState() => _FloatingGlassCardState();
}

class _FloatingGlassCardState extends State<FloatingGlassCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;
  bool _hovered = false;
  bool _floatArmed = false;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: widget.floatDuration,
    );
    _floatAnimation = CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOutSine,
    );

    if (widget.float) {
      Future<void>.delayed(widget.floatDelay, () {
        if (!mounted) return;
        _floatArmed = true;
        _maybeStartFloat();
      });
    }
  }

  void _maybeStartFloat() {
    if (!_floatArmed || !widget.float || !mounted) return;
    if (MotionAccessibility.reduceMotion(context)) {
      _floatController
        ..stop()
        ..value = 0;
      return;
    }
    if (!_floatController.isAnimating) {
      _floatController.repeat(reverse: true);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _maybeStartFloat();
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MotionAccessibility.reduceMotion(context);
    final radius = widget.borderRadius ?? AppRadius.lgAll;

    Widget card = ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: widget.blurSigma,
          sigmaY: widget.blurSigma,
        ),
        child: AnimatedContainer(
          duration: reduce ? Duration.zero : AppDurations.fast,
          curve: AppCurves.hover,
          width: widget.width,
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: radius,
            color: AppColors.surface.withValues(alpha: widget.opacity),
            border: Border.all(
              color: AppColors.surface.withValues(alpha: 0.85),
            ),
            boxShadow: _hovered ? AppElevation.medium : AppElevation.low,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surface.withValues(alpha: widget.opacity + 0.12),
                AppColors.surface.withValues(alpha: widget.opacity - 0.08),
              ],
            ),
          ),
          child: widget.child,
        ),
      ),
    );

    if (widget.onTap != null || widget.enableHoverLift) {
      card = MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedScale(
            scale: _hovered && widget.enableHoverLift && !reduce
                ? widget.hoverScale
                : 1,
            duration: reduce ? Duration.zero : AppDurations.fast,
            curve: AppCurves.hover,
            child: card,
          ),
        ),
      );
    }

    if (!widget.float || reduce) return card;

    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        final t = _floatAnimation.value;
        final dy = -widget.floatOffset * t;
        final angle = widget.rotateAmplitude * (t * 2 - 1);
        return Transform.translate(
          offset: Offset(0, dy),
          child: Transform.rotate(
            angle: angle,
            child: child,
          ),
        );
      },
      child: card,
    );
  }
}
