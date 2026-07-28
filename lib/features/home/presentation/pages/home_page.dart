import 'package:flutter/material.dart';

import '../../../../core/widgets/lazy_section.dart';
import '../widgets/faq_section.dart';
import '../widgets/featured_work_section.dart';
import '../widgets/final_cta_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/how_we_transform_section.dart';
import '../widgets/industries_section.dart';
import '../widgets/insights_section.dart';
import '../widgets/process_section.dart';
import '../widgets/testimonials_section.dart';
import '../widgets/transformation_section.dart';
import '../widgets/trust_conviction_strip.dart';
import '../widgets/why_stepzero_section.dart';

/// Complete StepZero homepage — above-the-fold eager, below-fold lazy.
///
/// Narrative arc: belief → convictions → method → systems → proof →
/// domain fit → differentiation → process → objections → authority → invite.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeroSection(),
        LazySection(
          eager: true,
          builder: (_) => const TrustConvictionStrip(),
        ),
        LazySection(
          eager: true,
          builder: (_) => const TransformationSection(),
        ),
        LazySection(
          placeholderHeight: 720,
          builder: (_) => const HowWeTransformSection(),
        ),
        LazySection(
          placeholderHeight: 900,
          builder: (_) => const FeaturedWorkSection(),
        ),
        LazySection(
          placeholderHeight: 640,
          builder: (_) => const IndustriesSection(),
        ),
        LazySection(
          placeholderHeight: 720,
          builder: (_) => const WhyStepZeroSection(),
        ),
        LazySection(
          placeholderHeight: 640,
          builder: (_) => const ProcessSection(),
        ),
        LazySection(
          placeholderHeight: 560,
          builder: (_) => const TestimonialsSection(),
        ),
        LazySection(
          placeholderHeight: 640,
          builder: (_) => const FaqSection(),
        ),
        LazySection(
          placeholderHeight: 720,
          builder: (_) => const InsightsSection(),
        ),
        LazySection(
          placeholderHeight: 480,
          builder: (_) => const FinalCtaSection(),
        ),
      ],
    );
  }
}
