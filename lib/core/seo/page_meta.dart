/// Page-level SEO / Open Graph / Twitter Card metadata.
class PageMeta {
  const PageMeta({
    required this.title,
    required this.description,
    required this.path,
    this.imageUrl = BrandDefaults.ogImage,
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

  String get canonicalUrl => '${BrandDefaults.siteUrl}$path';

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

/// Mirrors [Brand] constants without importing Flutter.
abstract final class BrandDefaults {
  static const String siteUrl = 'https://stepzero.studio';
  static const String ogImage = '$siteUrl/og-image.png';
  static const String name = 'StepZero';
  static const String defaultTitle =
      'StepZero — We build businesses people trust';
  static const String defaultDescription =
      'StepZero helps local businesses become premium brands through '
      'strategy, branding, websites, AI automation, and digital growth.';
}
