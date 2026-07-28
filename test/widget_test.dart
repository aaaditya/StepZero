import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stepzero/app.dart';
import 'package:stepzero/core/constants/brand.dart';
import 'package:stepzero/core/theme/app_colors.dart';
import 'package:stepzero/core/theme/app_spacing.dart';
import 'package:stepzero/core/theme/app_typography.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('StepZero hero boots with brand and primary CTA', (tester) async {
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
    expect(AppTypography.headingXl, 56);
    expect(AppTypography.headingL, 48);
    expect(AppTypography.headingM, 36);
    expect(AppTypography.headingS, 28);
    expect(AppTypography.bodyLarge, 20);
    expect(AppTypography.body, 18);
    expect(AppTypography.small, 16);
    expect(AppTypography.caption, 14);

    expect(AppSpacing.xxs, 4);
    expect(AppSpacing.section, 120);
  });
}
