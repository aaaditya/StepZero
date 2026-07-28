/// Canonical route path constants.
///
/// Never hardcode path strings in widgets — always reference [AppRoutes].
abstract final class AppRoutes {
  static const String home = '/';
  static const String services = '/services';
  static const String work = '/work';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String articles = '/articles';
  static const String testimonials = '/testimonials';
  static const String team = '/team';
  static const String faq = '/faq';
  static const String pricing = '/pricing';
  static const String industries = '/industries';

  static String caseStudy(String slug) => '/work/$slug';
  static String service(String slug) => '/services/$slug';
  static String article(String slug) => '/articles/$slug';
  static String industry(String slug) => '/industries/$slug';

  /// Accepts only URL-safe slugs — rejects path traversal / junk.
  static final RegExp slugPattern = RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$');

  static String? sanitizeSlug(String? raw) {
    if (raw == null) return null;
    final slug = raw.trim();
    if (slug.isEmpty || slug.length > 80) return null;
    if (!slugPattern.hasMatch(slug)) return null;
    return slug;
  }

  static const List<String> all = [
    home,
    services,
    work,
    articles,
    testimonials,
    team,
    faq,
    pricing,
    industries,
    about,
    contact,
  ];
}

/// Nav item metadata for chrome (header / mobile drawer).
///
/// Prefer [siteSettingsProvider] for live chrome; these remain as compile-time
/// fallbacks for non-Riverpod contexts.
class NavItem {
  const NavItem({
    required this.label,
    required this.path,
  });

  final String label;
  final String path;
}

abstract final class AppNav {
  static const List<NavItem> primary = [
    NavItem(label: 'Services', path: AppRoutes.services),
    NavItem(label: 'Work', path: AppRoutes.work),
    NavItem(label: 'Insights', path: AppRoutes.articles),
    NavItem(label: 'Pricing', path: AppRoutes.pricing),
    NavItem(label: 'About', path: AppRoutes.about),
    NavItem(label: 'Contact', path: AppRoutes.contact),
  ];
}
