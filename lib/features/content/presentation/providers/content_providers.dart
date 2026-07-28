import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../work/domain/case_study.dart';
import '../../data/content_catalog.dart';
import '../../data/site_config_catalog.dart';
import '../../domain/models.dart';
import '../../domain/site_config.dart';

final siteSettingsProvider = Provider<SiteSettings>(
  (ref) => SiteConfigCatalog.settings,
);

final projectsProvider = Provider<List<CaseStudy>>(
  (ref) => ContentCatalog.projects,
);

final servicesProvider = Provider<List<ServiceOffering>>(
  (ref) => ContentCatalog.services,
);

final serviceProvider = Provider.family<ServiceOffering?, String>(
  (ref, slug) => ContentCatalog.serviceBySlug(slug),
);

final testimonialsProvider = Provider<List<Testimonial>>(
  (ref) => ContentCatalog.testimonials,
);

final featuredTestimonialsProvider = Provider<List<Testimonial>>(
  (ref) => ContentCatalog.featuredTestimonials,
);

final articlesProvider = Provider<List<Article>>(
  (ref) => ContentCatalog.articles,
);

final articleProvider = Provider.family<Article?, String>(
  (ref, slug) => ContentCatalog.articleBySlug(slug),
);

final teamProvider = Provider<List<TeamMember>>(
  (ref) => ContentCatalog.team,
);

final faqsProvider = Provider<List<FaqItem>>(
  (ref) => ContentCatalog.faqs,
);

final featuredFaqsProvider = Provider<List<FaqItem>>(
  (ref) => ContentCatalog.featuredFaqs,
);

final pricingProvider = Provider<List<PricingPlan>>(
  (ref) => ContentCatalog.pricing,
);

final industriesProvider = Provider<List<Industry>>(
  (ref) => ContentCatalog.industries,
);

final industryProvider = Provider.family<Industry?, String>(
  (ref, slug) => ContentCatalog.industryBySlug(slug),
);
