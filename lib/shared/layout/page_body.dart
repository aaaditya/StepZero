import 'package:flutter/material.dart';

/// Clears the overlay navbar for non-immersive pages.
class PageBody extends StatelessWidget {
  const PageBody({
    required this.child,
    this.navHeight = 72,
    super.key,
  });

  final Widget child;
  final double navHeight;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top + navHeight;
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: child,
    );
  }
}
