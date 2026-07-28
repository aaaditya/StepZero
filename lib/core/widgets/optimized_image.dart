import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Responsive, decode-aware image for Core Web Vitals-friendly media.
///
/// - Chooses layout-based [cacheWidth]/[cacheHeight] to avoid oversized decode
/// - Prefers fade-in without layout shift (fixed aspect)
/// - Supports semantic labels for accessibility
/// - Works with asset or network sources
class OptimizedImage extends StatelessWidget {
  const OptimizedImage({
    required this.aspectRatio,
    this.assetPath,
    this.networkUrl,
    this.semanticLabel,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderColor,
    this.fadeDuration = const Duration(milliseconds: 240),
    this.maxDecodeWidth = 1600,
    super.key,
  }) : assert(
          assetPath != null || networkUrl != null,
          'Provide assetPath or networkUrl',
        );

  final double aspectRatio;
  final String? assetPath;
  final String? networkUrl;
  final String? semanticLabel;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? placeholderColor;
  final Duration fadeDuration;
  final int maxDecodeWidth;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final dpr = MediaQuery.devicePixelRatioOf(context);
          final targetW = (constraints.maxWidth * dpr).round();
          final cacheW = math.min(targetW, maxDecodeWidth);
          final cacheH = (cacheW / aspectRatio).round();

          final image = networkUrl != null
              ? Image.network(
                  networkUrl!,
                  fit: fit,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  cacheWidth: cacheW > 0 ? cacheW : null,
                  cacheHeight: cacheH > 0 ? cacheH : null,
                  filterQuality: FilterQuality.medium,
                  gaplessPlayback: true,
                  semanticLabel: semanticLabel,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return _Placeholder(color: placeholderColor);
                  },
                  errorBuilder: (context, error, stack) =>
                      _Placeholder(color: placeholderColor),
                  frameBuilder: (context, child, frame, wasSync) {
                    if (wasSync || frame != null) {
                      return AnimatedOpacity(
                        opacity: 1,
                        duration: fadeDuration,
                        child: child,
                      );
                    }
                    return _Placeholder(color: placeholderColor);
                  },
                )
              : Image.asset(
                  assetPath!,
                  fit: fit,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  cacheWidth: cacheW > 0 ? cacheW : null,
                  cacheHeight: cacheH > 0 ? cacheH : null,
                  filterQuality: FilterQuality.medium,
                  gaplessPlayback: true,
                  semanticLabel: semanticLabel,
                  errorBuilder: (context, error, stack) =>
                      _Placeholder(color: placeholderColor),
                  frameBuilder: (context, child, frame, wasSync) {
                    if (wasSync || frame != null) {
                      return AnimatedOpacity(
                        opacity: 1,
                        duration: fadeDuration,
                        child: child,
                      );
                    }
                    return _Placeholder(color: placeholderColor);
                  },
                );

          final clipped = borderRadius != null
              ? ClipRRect(borderRadius: borderRadius!, child: image)
              : image;

          if (semanticLabel == null) {
            return ExcludeSemantics(child: clipped);
          }
          return Semantics(
            image: true,
            label: semanticLabel,
            child: clipped,
          );
        },
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color ?? const Color(0xFFF3F4F6),
      child: const SizedBox.expand(),
    );
  }
}
