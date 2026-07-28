import 'package:flutter_test/flutter_test.dart';

import 'package:stepzero/features/work/data/case_study_catalog.dart';
import 'package:stepzero/features/work/domain/case_study.dart';

void main() {
  test('case study catalog exposes complete storytelling fields', () {
    const study = CaseStudyCatalog.northside;

    expect(study.slug, 'northside-clinic');
    expect(study.research, isNotEmpty);
    expect(study.strategy, isNotEmpty);
    expect(study.automation, isNotEmpty);
    expect(study.metrics.length, greaterThanOrEqualTo(3));
    expect(study.timeline, isNotEmpty);
    expect(study.lessons.length, 3);
    expect(CaseStudyCatalog.bySlug(study.nextSlug), isNotNull);
    expect(CaseStudy.toc.length, 16);
  });

  test('case study lookup by slug', () {
    expect(CaseStudyCatalog.bySlug('oven-and-oak')?.name, 'Oven & Oak');
    expect(CaseStudyCatalog.bySlug('missing'), isNull);
  });
}
