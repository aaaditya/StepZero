import 'package:flutter/widgets.dart';

import 'page_meta.dart';
import 'seo_controller.dart';

/// Applies [meta] to the document head whenever this widget mounts or updates.
class SeoEffect extends StatefulWidget {
  const SeoEffect({
    required this.meta,
    required this.child,
    super.key,
  });

  final PageMeta meta;
  final Widget child;

  @override
  State<SeoEffect> createState() => _SeoEffectState();
}

class _SeoEffectState extends State<SeoEffect> {
  @override
  void initState() {
    super.initState();
    SeoController.apply(widget.meta);
  }

  @override
  void didUpdateWidget(covariant SeoEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.meta.title != widget.meta.title ||
        oldWidget.meta.path != widget.meta.path ||
        oldWidget.meta.description != widget.meta.description) {
      SeoController.apply(widget.meta);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Common JSON-LD builders for marketing surfaces.
abstract final class StructuredData {
  static Map<String, Object?> organization() => {
        '@context': 'https://schema.org',
        '@type': 'Organization',
        'name': BrandDefaults.name,
        'url': BrandDefaults.siteUrl,
        'logo': '${BrandDefaults.siteUrl}/icons/Icon-512.png',
        'email': 'hello@stepzero.studio',
      };

  static Map<String, Object?> article({
    required String title,
    required String description,
    required String path,
    String? datePublished,
  }) =>
      {
        '@context': 'https://schema.org',
        '@type': 'Article',
        'headline': title,
        'description': description,
        'mainEntityOfPage': '${BrandDefaults.siteUrl}$path',
        'author': {
          '@type': 'Organization',
          'name': BrandDefaults.name,
        },
        'publisher': {
          '@type': 'Organization',
          'name': BrandDefaults.name,
          'url': BrandDefaults.siteUrl,
          'logo': '${BrandDefaults.siteUrl}/icons/Icon-512.png',
        },
        if (datePublished != null) 'datePublished': datePublished,
        'image': [BrandDefaults.ogImage],
      };

  static Map<String, Object?> faq(List<({String q, String a})> items) => {
        '@context': 'https://schema.org',
        '@type': 'FAQPage',
        'mainEntity': [
          for (final item in items)
            {
              '@type': 'Question',
              'name': item.q,
              'acceptedAnswer': {
                '@type': 'Answer',
                'text': item.a,
              },
            },
        ],
      };

  static Map<String, Object?> caseStudy({
    required String name,
    required String headline,
    required String path,
    required String industry,
  }) =>
      {
        '@context': 'https://schema.org',
        '@type': 'CaseStudy',
        'name': name,
        'headline': headline,
        'about': industry,
        'url': '${BrandDefaults.siteUrl}$path',
        'author': {
          '@type': 'Organization',
          'name': BrandDefaults.name,
        },
        'image': BrandDefaults.ogImage,
      };
}
