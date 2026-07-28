import 'package:flutter/material.dart';

import '../widgets/faq_section.dart';
import '../widgets/featured_work_section.dart';
import '../widgets/final_cta_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/industries_section.dart';
import '../widgets/insights_section.dart';
import '../widgets/process_section.dart';
import '../widgets/transformation_section.dart';
import '../widgets/what_we_build_section.dart';
import '../widgets/why_stepzero_section.dart';

/// StepZero homepage — hero + remaining product surfaces.
///
/// Each section is an independent premium module sharing the design system.
/// Footer lives in [PageShell].
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HeroSection(),
        TransformationSection(),
        WhatWeBuildSection(),
        FeaturedWorkSection(),
        IndustriesSection(),
        WhyStepZeroSection(),
        ProcessSection(),
        InsightsSection(),
        FaqSection(),
        FinalCtaSection(),
      ],
    );
  }
}
