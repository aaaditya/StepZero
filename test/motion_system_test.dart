import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stepzero/core/animations/app_animations.dart';
import 'package:stepzero/core/animations/hover_effects.dart';
import 'package:stepzero/core/animations/magnetic.dart';
import 'package:stepzero/core/animations/skeleton.dart';
import 'package:stepzero/core/constants/curves.dart';
import 'package:stepzero/core/constants/durations.dart';
import 'package:stepzero/core/widgets/app_button.dart';

void main() {
  test('motion duration tokens stay premium-calm', () {
    expect(AppDurations.fast.inMilliseconds, lessThan(AppDurations.normal.inMilliseconds));
    expect(AppDurations.stagger.inMilliseconds, 80);
    expect(AppDurations.page.inMilliseconds, 320);
    expect(AppDurations.ambient.inMilliseconds, greaterThan(3000));
  });

  test('animation recipes produce fade + move', () {
    final effects = AppAnimations.fadeUp(offset: 12);
    expect(effects.length, 2);
    expect(AppAnimations.staggerDelay(2).inMilliseconds, 160);
  });

  testWidgets('magnetic is a no-op under reduced motion', (tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: MaterialApp(
          home: Scaffold(
            body: Magnetic(
              child: Container(width: 120, height: 48, color: Colors.blue),
            ),
          ),
        ),
      ),
    );
    expect(find.byType(Magnetic), findsOneWidget);
    expect(find.byType(AnimatedContainer), findsNothing);
  });

  testWidgets('AppButton supports magnetic and pulse flags', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            label: 'Book',
            magnetic: true,
            pulse: true,
            onPressed: () {},
          ),
        ),
      ),
    );
    expect(find.text('Book'), findsOneWidget);
    expect(find.byType(SoftPulse), findsOneWidget);
  });

  testWidgets('NavUnderline animates width when active', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NavUnderline(active: true),
        ),
      ),
    );
    final box = tester.renderObject<RenderBox>(find.byType(AnimatedContainer));
    expect(box.size.width, greaterThan(0));
  });

  testWidgets('MotionSkeleton renders', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MotionSkeleton(width: 200, height: 20),
        ),
      ),
    );
    expect(find.byType(MotionSkeleton), findsOneWidget);
  });

  test('page curve is defined for route transitions', () {
    expect(AppCurves.page, isNotNull);
    expect(AppCurves.magnetic, isNotNull);
  });
}
