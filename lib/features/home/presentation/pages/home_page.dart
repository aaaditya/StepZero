import 'package:flutter/material.dart';

import '../widgets/faq_section.dart';
import '../widgets/featured_work_section.dart';
import '../widgets/final_cta_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/how_we_transform_section.dart';
import '../widgets/industries_section.dart';
import '../widgets/insights_section.dart';
import '../widgets/process_section.dart';
import '../widgets/transformation_section.dart';
import '../widgets/why_stepzero_section.dart';

/// Complete StepZero homepage — composed exclusively from design-system
/// primitives and feature section modules.
///
/// Footer lives in [PageShell] (sticky glass nav + smooth scroll).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HeroSection(),
        TransformationSection(),
        HowWeTransformSection(),
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
