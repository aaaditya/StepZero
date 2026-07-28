import 'package:flutter/material.dart';

import '../widgets/hero_section.dart';

/// Homepage — hero only for now; subsequent sections arrive later.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HeroSection(),
      ],
    );
  }
}
