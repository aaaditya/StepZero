/// Canonical brand copy and identity for StepZero.
///
/// Keep product voice centralized so marketing pages, SEO metadata,
/// and shared chrome never drift.
abstract final class Brand {
  static const String name = 'StepZero';
  static const String legalName = 'StepZero';
  static const String tagline = 'We build businesses people trust.';
  static const String mission =
      'Helping local businesses become premium brands through '
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
