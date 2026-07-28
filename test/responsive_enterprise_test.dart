import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stepzero/features/home/presentation/widgets/featured_work_section.dart';
import 'package:stepzero/features/home/presentation/widgets/hero_dashboard.dart';
import 'package:stepzero/features/work/presentation/providers/case_study_providers.dart';

void main() {
  testWidgets('FeaturedWorkSection renders catalog case studies', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: FeaturedWorkSection(),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    final container = ProviderContainer();
    addTearDown(container.dispose);
    final studies = container.read(caseStudiesProvider);
    expect(studies, isNotEmpty);
    expect(find.textContaining('Proof that order beats tactics'), findsOneWidget);
  });

  testWidgets('HeroDashboard fits narrow mobile width without overflow',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(
          size: Size(320, 640),
          disableAnimations: true,
        ),
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: HeroDashboard(compact: true),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.byType(HeroDashboard), findsOneWidget);
    expect(find.byType(FittedBox), findsWidgets);
    expect(find.byType(RepaintBoundary), findsWidgets);
  });
}
