import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stepzero/core/seo/seo_effect.dart';
import 'package:stepzero/core/widgets/lazy_section.dart';

void main() {
  test('structured data FAQ shape', () {
    final json = StructuredData.faq([
      (q: 'Do you only build websites?', a: 'No.'),
    ]);
    expect(json['@type'], 'FAQPage');
    final entities = json['mainEntity'] as List<dynamic>;
    expect(entities, hasLength(1));
  });

  test('structured data article shape', () {
    final json = StructuredData.article(
      title: 'Brand before traffic',
      description: 'Why ads fail unclear businesses',
      path: '/articles/brand-before-traffic',
      datePublished: '2026-05-12',
    );
    expect(json['@type'], 'Article');
    expect(json['headline'], contains('Brand'));
  });

  test('structured data case study shape', () {
    final json = StructuredData.caseStudy(
      name: 'Northside Clinic',
      headline: 'From missed calls to booked care',
      path: '/work/northside-clinic',
      industry: 'Healthcare',
    );
    expect(json['@type'], 'CaseStudy');
    expect(json['about'], 'Healthcare');
  });

  testWidgets('LazySection eager builds immediately', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ShellScroll(
          controller: ScrollController(),
          child: ListView(
            children: [
              LazySection(
                eager: true,
                builder: (_) => const Text('Eager child'),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Eager child'), findsOneWidget);
  });
}
