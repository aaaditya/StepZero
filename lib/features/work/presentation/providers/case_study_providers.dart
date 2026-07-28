import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/case_study_catalog.dart';
import '../../domain/case_study.dart';

final caseStudiesProvider = Provider<List<CaseStudy>>((ref) {
  return CaseStudyCatalog.all;
});

final caseStudyProvider = Provider.family<CaseStudy?, String>((ref, slug) {
  return CaseStudyCatalog.bySlug(slug);
});
