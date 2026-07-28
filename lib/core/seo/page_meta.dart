import '../constants/brand.dart';

/// Page-level SEO / Open Graph / Twitter Card metadata.
class PageMeta {
  const PageMeta({
    required this.title,
    required this.description,
    required this.path,
    this.imageUrl = Brand.defaultOgImage,
    this.type = 'website',
    this.noIndex = false,
    this.jsonLd,
  });

  final String title;
  final String description;
  final String path;
  final String imageUrl;
  final String type;
  final bool noIndex;
  final Map<String, Object?>? jsonLd;

  String get canonicalUrl => '${Brand.siteUrl}$path';

  PageMeta copyWith({
    String? title,
    String? description,
    String? path,
    String? imageUrl,
    String? type,
    bool? noIndex,
    Map<String, Object?>? jsonLd,
  }) {
    return PageMeta(
      title: title ?? this.title,
      description: description ?? this.description,
      path: path ?? this.path,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      noIndex: noIndex ?? this.noIndex,
      jsonLd: jsonLd ?? this.jsonLd,
    );
  }
}

/// SEO-facing aliases over [Brand] — keep crawler code stable.
abstract final class BrandDefaults {
  static const String siteUrl = Brand.siteUrl;
  static const String ogImage = Brand.defaultOgImage;
  static const String name = Brand.name;
  static const String defaultTitle = Brand.defaultTitle;
  static const String defaultDescription = Brand.defaultDescription;
}
