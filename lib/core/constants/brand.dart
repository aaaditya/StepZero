/// Site SEO / social / performance constants.
abstract final class Brand {
  static const String name = 'StepZero';
  static const String legalName = 'StepZero';
  static const String tagline = 'We build businesses people trust.';
  static const String mission =
      'Helping local businesses become premium brands through '
      'strategy, branding, websites, AI automation, and digital growth.';

  /// Canonical production origin (no trailing slash).
  static const String siteUrl = 'https://stepzero.studio';

  /// Default share image (absolute URL for crawlers).
  static const String defaultOgImage = '$siteUrl/og-image.png';

  static const String defaultTitle =
      'StepZero — We build businesses people trust';

  static const String defaultDescription =
      'StepZero helps local businesses become premium brands through '
      'strategy, branding, websites, AI automation, and digital growth.';

  /// Primary CTA used across the product.
  static const String primaryCta = 'Start a project';

  /// Industries we intentionally serve — used for SEO + copy systems.
  static const List<String> targetClients = [
    'Restaurants',
    'Cafés',
    'Salons',
    'Clinics',
    'Gyms',
    'Retail Stores',
    'Real Estate',
    'Startups',
  ];
}
