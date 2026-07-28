import 'package:flutter_test/flutter_test.dart';

import 'package:stepzero/core/routing/routes.dart';
import 'package:stepzero/features/content/data/content_catalog.dart';
import 'package:stepzero/features/content/data/site_config_catalog.dart';

void main() {
  group('content catalogs', () {
    test('projects expose case studies', () {
      expect(ContentCatalog.projects, isNotEmpty);
      expect(ContentCatalog.projectBySlug('northside-clinic'), isNotNull);
    });

    test('services cover four transformation systems', () {
      expect(ContentCatalog.services.length, 4);
      expect(ContentCatalog.serviceBySlug('brand')?.title, 'Brand');
    });

    test('testimonials include featured operators', () {
      expect(ContentCatalog.featuredTestimonials, isNotEmpty);
      expect(ContentCatalog.testimonials.first.quote, isNotEmpty);
    });

    test('articles are slug-addressable', () {
      expect(ContentCatalog.articleBySlug('brand-before-traffic'), isNotNull);
      expect(ContentCatalog.articles.any((a) => a.featured), isTrue);
    });

    test('team members have roles', () {
      expect(ContentCatalog.team.length, greaterThanOrEqualTo(3));
      expect(ContentCatalog.team.every((m) => m.role.isNotEmpty), isTrue);
    });

    test('faqs include featured homepage set', () {
      expect(ContentCatalog.featuredFaqs.length, greaterThanOrEqualTo(5));
    });

    test('pricing plans include a highlighted option', () {
      expect(ContentCatalog.pricing.any((p) => p.highlighted), isTrue);
    });

    test('industries are slug-addressable', () {
      expect(ContentCatalog.industryBySlug('clinics')?.name, 'Clinics');
      expect(ContentCatalog.industries.length, 8);
    });
  });

  group('site settings', () {
    test('navigation primary includes core destinations', () {
      final nav = SiteConfigCatalog.settings.navigation.primary;
      final paths = nav.map((e) => e.path).toSet();
      expect(paths.contains(AppRoutes.services), isTrue);
      expect(paths.contains(AppRoutes.work), isTrue);
      expect(paths.contains(AppRoutes.contact), isTrue);
    });

    test('footer columns and socials are configured', () {
      final footer = SiteConfigCatalog.settings.footer;
      expect(footer.columns, isNotEmpty);
      expect(footer.socials, isNotEmpty);
      expect(SiteConfigCatalog.settings.contactEmail, contains('@'));
    });
  });
}
