import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stepzero/app.dart';
import 'package:stepzero/core/constants/brand.dart';
import 'package:stepzero/core/seo/page_meta.dart';
import 'package:stepzero/core/seo/seo_controller.dart';
import 'package:stepzero/core/theme/app_colors.dart';
import 'package:stepzero/core/theme/app_spacing.dart';
import 'package:stepzero/core/theme/app_typography.dart';
import 'package:stepzero/core/widgets/lazy_section.dart';
import 'package:stepzero/features/home/presentation/widgets/hero_section.dart';
import 'package:stepzero/features/home/presentation/widgets/transformation_section.dart';

void main() {
  testWidgets('StepZero homepage boots critical path sections', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: StepZeroApp(),
      ),
    );

    // Advance past entrance budget; do not pumpAndSettle — cards float forever.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1300));

    expect(find.text(Brand.name), findsWidgets);
    expect(find.textContaining('Every Great Business'), findsOneWidget);
    expect(find.text('Book a Discovery Call'), findsOneWidget);
    expect(find.text('View Our Work'), findsOneWidget);

    // Above-the-fold / eager sections are in the tree immediately.
    expect(find.byType(HeroSection), findsOneWidget);
    expect(find.byType(TransformationSection), findsOneWidget);
    expect(find.byType(LazySection), findsWidgets);
  });

  test('design tokens match brand specification', () {
    expect(AppColors.background, const Color(0xFFFAFAF8));
    expect(AppColors.surface, const Color(0xFFFFFFFF));
    expect(AppColors.textPrimary, const Color(0xFF111111));
    expect(AppColors.textSecondary, const Color(0xFF6B7280));
    expect(AppColors.border, const Color(0xFFECECEC));
    expect(AppColors.accent, const Color(0xFF5B5FEF));
    expect(AppColors.success, const Color(0xFF22C55E));
    expect(AppColors.error, const Color(0xFFEF4444));

    expect(AppTypography.hero, 80);
    expect(AppTypography.fontFamily, 'Inter');
    expect(AppSpacing.section, 120);
  });

  test('SEO controller resolves route metadata', () {
    final home = SeoController.forPath('/');
    expect(home.title, contains('StepZero'));
    expect(home.canonicalUrl, 'https://stepzero.studio/');
    expect(home.imageUrl, BrandDefaults.ogImage);

    final work = SeoController.forPath('/work');
    expect(work.title.toLowerCase(), contains('work'));

    final study = SeoController.forPath('/work/northside-clinic');
    expect(study.type, 'article');
    expect(study.path, '/work/northside-clinic');
  });

  test('PageMeta builds absolute canonical URLs', () {
    const meta = PageMeta(
      title: 'Test',
      description: 'Desc',
      path: '/pricing',
    );
    expect(meta.canonicalUrl, 'https://stepzero.studio/pricing');
  });
}
