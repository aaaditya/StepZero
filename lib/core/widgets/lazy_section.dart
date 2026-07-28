import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Provides the shell [ScrollController] to descendants for lazy loading.
class ShellScroll extends InheritedWidget {
  const ShellScroll({
    required this.controller,
    required super.child,
    super.key,
  });

  final ScrollController controller;

  static ScrollController? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShellScroll>()?.controller;
  }

  @override
  bool updateShouldNotify(ShellScroll oldWidget) =>
      controller != oldWidget.controller;
}

/// Defers building [builder] until the section is near the viewport.
///
/// Keeps a lightweight placeholder to preserve scroll extent estimates and
/// improves TTI / INP on long marketing pages (Core Web Vitals).
class LazySection extends StatefulWidget {
  const LazySection({
    required this.builder,
    this.placeholderHeight = 480,
    this.eager = false,
    this.rootMargin = 600,
    this.placeholder,
    super.key,
  });

  final WidgetBuilder builder;
  final double placeholderHeight;
  final bool eager;
  final double rootMargin;
  final Widget? placeholder;

  @override
  State<LazySection> createState() => _LazySectionState();
}

class _LazySectionState extends State<LazySection> {
  bool _loaded = false;
  ScrollController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.eager) {
      _loaded = true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => _evaluate());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final next = ShellScroll.maybeOf(context);
    if (next != _controller) {
      _controller?.removeListener(_evaluate);
      _controller = next;
      _controller?.addListener(_evaluate);
      WidgetsBinding.instance.addPostFrameCallback((_) => _evaluate());
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_evaluate);
    super.dispose();
  }

  void _evaluate() {
    if (!mounted || _loaded) return;

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _evaluate());
      return;
    }

    final viewport = RenderAbstractViewport.maybeOf(renderObject);
    if (viewport == null) {
      setState(() => _loaded = true);
      return;
    }

    final offsetToReveal = viewport.getOffsetToReveal(renderObject, 0).offset;
    final vpOffset = _controller?.hasClients == true
        ? _controller!.offset
        : 0.0;
    final vpHeight = viewport.paintBounds.height;
    final top = offsetToReveal;
    final bottom = top + renderObject.size.height;
    final visibleTop = vpOffset - widget.rootMargin;
    final visibleBottom = vpOffset + vpHeight + widget.rootMargin;

    final near = bottom >= visibleTop && top <= visibleBottom;
    if (near) {
      setState(() => _loaded = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loaded) {
      return widget.builder(context);
    }

    return widget.placeholder ??
        SizedBox(
          height: widget.placeholderHeight,
          child: const ColoredBox(color: Color(0x00000000)),
        );
  }
}
