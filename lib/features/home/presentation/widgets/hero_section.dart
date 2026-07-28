import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/breakpoints.dart';
import '../../../../core/constants/curves.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/hero_canvas.dart';
import '../../../../core/widgets/responsive_builder.dart';
import '../../../../core/widgets/reveal.dart';
import 'hero_copy_column.dart';
import 'hero_dashboard.dart';

/// StepZero homepage hero — full-viewport opening statement.
///
/// ## Design decisions
///
/// **Who is StepZero?** The headline lands the brand as origin
/// ("Starts at StepZero") — not a service menu.
///
/// **Who is it for?** The pill badge names local businesses immediately;
/// subhead lists the transformation stack without SKU clutter.
///
/// **Why trust?** Micro-trust row (Strategy / AI / Growth) + a living
/// product metaphor on the right (growth operating system of glass cards)
/// proves capability without fake client logos.
///
/// **What next?** Primary CTA books a discovery call (conversation),
/// secondary routes to work (evidence). Dual path for ready vs curious.
///
/// **Why a dashboard, not a photo?** Stock photography is generic.
/// A composed system of site / reviews / QR / AI / WhatsApp / metrics
/// shows the *outcome surface* of working with StepZero — premium,
/// specific, and ownable IP.
///
/// **Layout:** 45/55 split, 1440 max, vertically centered — editorial
/// reading column + visual gravity. Mobile stacks copy → dashboard.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  static const double maxWidth = 1440;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final topInset = MediaQuery.paddingOf(context).top + 72;
    final width = MediaQuery.sizeOf(context).width;
    final stacked = Responsive.isMobile(context) ||
        (Responsive.isTablet(context) && width < Breakpoints.tablet + 80);

    final content = Padding(
      padding: EdgeInsets.fromLTRB(
        Responsive.pageGutter(context),
        topInset + AppSpacing.lg,
        Responsive.pageGutter(context),
        AppSpacing.xxl,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxWidth),
        child: ResponsiveBuilder(
          desktop: (_) => const _DesktopHero(),
          tablet: (_) => const _TabletHero(),
          mobile: (_) => const _MobileHero(),
        ),
      ),
    );

    final canvas = HeroCanvas(
      glowAlignment: Responsive.isDesktop(context)
          ? const Alignment(0.65, 0.05)
          : const Alignment(0, 0.55),
      glowSize: Responsive.isDesktop(context) ? 580 : 380,
      child: stacked
          ? content
          : SizedBox(
              height: screenHeight,
              width: double.infinity,
              child: Center(child: content),
            ),
    );

    return SectionLandmark(
      label: 'Hero',
      child: (stacked
              ? ConstrainedBox(
                  constraints: BoxConstraints(minHeight: screenHeight),
                  child: SizedBox(width: double.infinity, child: canvas),
                )
              : canvas)
          .animate()
          .fadeIn(duration: 400.ms, curve: AppCurves.enter),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  const _DesktopHero();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 45,
          child: HeroCopyColumn(),
        ),
        SizedBox(width: AppSpacing.xl),
        Expanded(
          flex: 55,
          child: Align(
            alignment: Alignment.center,
            child: _AnimatedDashboard(),
          ),
        ),
      ],
    );
  }
}

class _TabletHero extends StatelessWidget {
  const _TabletHero();

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= Breakpoints.tablet + 80;

    if (wide) {
      return const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 48,
            child: HeroCopyColumn(),
          ),
          SizedBox(width: AppSpacing.lg),
          Expanded(
            flex: 52,
            child: Align(
              alignment: Alignment.center,
              child: _AnimatedDashboard(compact: true),
            ),
          ),
        ],
      );
    }

    return const _MobileHero();
  }
}

class _MobileHero extends StatelessWidget {
  const _MobileHero();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroCopyColumn(expandButtons: true),
        SizedBox(height: AppSpacing.xxl),
        Center(child: _AnimatedDashboard(compact: true)),
      ],
    );
  }
}

class _AnimatedDashboard extends StatelessWidget {
  const _AnimatedDashboard({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return HeroDashboard(compact: compact)
        .animate()
        .fadeIn(
          delay: 280.ms,
          duration: 700.ms,
          curve: AppCurves.enter,
        )
        .moveY(
          begin: 24,
          end: 0,
          delay: 280.ms,
          duration: 750.ms,
          curve: AppCurves.enter,
        )
        .scale(
          begin: const Offset(0.96, 0.96),
          end: const Offset(1, 1),
          delay: 280.ms,
          duration: 750.ms,
          curve: AppCurves.enter,
        );
  }
}
