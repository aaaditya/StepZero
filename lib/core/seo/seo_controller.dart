import 'dart:convert';

import 'page_meta.dart';
import 'seo_document_stub.dart'
    if (dart.library.html) 'seo_document_web.dart' as seo_doc;

/// Applies document-level SEO for Flutter web (title, meta, OG, Twitter, JSON-LD).
abstract final class SeoController {
  static void apply(PageMeta meta) {
    seo_doc.applyDocumentMeta(
      title: meta.title,
      description: meta.description,
      canonicalUrl: meta.canonicalUrl,
      imageUrl: meta.imageUrl,
      type: meta.type,
      noIndex: meta.noIndex,
      jsonLd: meta.jsonLd == null ? null : jsonEncode(meta.jsonLd),
      siteName: BrandDefaults.name,
    );
  }

  static PageMeta forPath(String path) {
    final normalized = path.isEmpty ? '/' : path;

    final exact = _routes[normalized];
    if (exact != null) return exact;

    if (normalized.startsWith('/work/')) {
      return PageMeta(
        title: 'Case Study · StepZero',
        description:
            'Full transformation case study from StepZero — challenge, '
            'strategy, craft, and measurable outcomes.',
        path: normalized,
        type: 'article',
      );
    }
    if (normalized.startsWith('/articles/')) {
      return PageMeta(
        title: 'Insight · StepZero',
        description: BrandDefaults.defaultDescription,
        path: normalized,
        type: 'article',
      );
    }
    if (normalized.startsWith('/services/')) {
      return PageMeta(
        title: 'Service · StepZero',
        description: BrandDefaults.defaultDescription,
        path: normalized,
      );
    }
    if (normalized.startsWith('/industries/')) {
      return PageMeta(
        title: 'Industry · StepZero',
        description: BrandDefaults.defaultDescription,
        path: normalized,
      );
    }

    return PageMeta(
      title: BrandDefaults.defaultTitle,
      description: BrandDefaults.defaultDescription,
      path: normalized,
    );
  }

  static const Map<String, PageMeta> _routes = {
    '/': PageMeta(
      title: BrandDefaults.defaultTitle,
      description: BrandDefaults.defaultDescription,
      path: '/',
    ),
    '/services': PageMeta(
      title: 'Services — How we transform businesses · StepZero',
      description:
          'Brand, digital presence, automation, and growth systems for local '
          'businesses that want to feel premium.',
      path: '/services',
    ),
    '/work': PageMeta(
      title: 'Work — Transformations · StepZero',
      description:
          'Case studies told completely — challenge, judgment, craft, and '
          'measurable business change.',
      path: '/work',
    ),
    '/articles': PageMeta(
      title: 'Insights · StepZero',
      description:
          'Short essays for operators who want clarity — brand, digital, and '
          'automation thinking.',
      path: '/articles',
    ),
    '/testimonials': PageMeta(
      title: 'Testimonials · StepZero',
      description:
          'Operators, in their own words — proof as voice, not star ratings.',
      path: '/testimonials',
    ),
    '/team': PageMeta(
      title: 'Team · StepZero',
      description:
          'The people behind the craft — a small studio of senior operators.',
      path: '/team',
    ),
    '/faq': PageMeta(
      title: 'FAQ · StepZero',
      description:
          'Straight answers about engagements, timelines, and how StepZero works.',
      path: '/faq',
    ),
    '/pricing': PageMeta(
      title: 'Pricing · StepZero',
      description:
          'Clear engagement shapes — Foundation, Transformation, and Compound '
          'retainers.',
      path: '/pricing',
    ),
    '/industries': PageMeta(
      title: 'Industries · StepZero',
      description:
          'Built for restaurants, cafés, salons, clinics, gyms, retail, hotels, '
          'and real estate.',
      path: '/industries',
    ),
    '/about': PageMeta(
      title: 'About · StepZero',
      description:
          'A studio for operators who want to feel premium — strategy, branding, '
          'websites, AI, growth.',
      path: '/about',
    ),
    '/contact': PageMeta(
      title: 'Contact · StepZero',
      description: 'Book a discovery call with StepZero. hello@stepzero.studio',
      path: '/contact',
    ),
  };
}
