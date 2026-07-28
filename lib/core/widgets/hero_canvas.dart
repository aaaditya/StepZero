import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Subtle dot grid painter for premium off-white canvases.
class DotGridPainter extends CustomPainter {
  const DotGridPainter({
    this.spacing = 28,
    this.radius = 0.9,
    this.color = const Color(0x14000000),
  });

  final double spacing;
  final double radius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final cols = (size.width / spacing).ceil() + 1;
    final rows = (size.height / spacing).ceil() + 1;

    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < cols; col++) {
        final dx = col * spacing;
        final dy = row * spacing;
        canvas.drawCircle(Offset(dx, dy), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DotGridPainter oldDelegate) {
    return oldDelegate.spacing != spacing ||
        oldDelegate.radius != radius ||
        oldDelegate.color != color;
  }
}

/// Soft radial glow used behind compositional focal points (e.g. dashboard).
class RadialGlow extends StatelessWidget {
  const RadialGlow({
    this.color = AppColors.accent,
    this.opacity = 0.14,
    this.size = 520,
    super.key,
  });

  final Color color;
  final double opacity;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: opacity),
              color.withValues(alpha: opacity * 0.35),
              color.withValues(alpha: 0),
            ],
            stops: const [0.0, 0.45, 1.0],
          ),
        ),
      ),
    );
  }
}

/// Hero canvas: off-white + dot grid + optional positioned glow.
class HeroCanvas extends StatelessWidget {
  const HeroCanvas({
    required this.child,
    this.showGrid = true,
    this.glowAlignment = const Alignment(0.55, 0.1),
    this.glowSize = 560,
    super.key,
  });

  final Widget child;
  final bool showGrid;
  final Alignment glowAlignment;
  final double glowSize;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: Stack(
        children: [
          if (showGrid)
            const Positioned.fill(
              child: CustomPaint(painter: DotGridPainter()),
            ),
          Positioned.fill(
            child: Align(
              alignment: glowAlignment,
              child: Transform.rotate(
                angle: -math.pi / 12,
                child: RadialGlow(size: glowSize),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
