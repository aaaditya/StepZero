/// Canonical route path constants.
///
/// Never hardcode path strings in widgets — always reference [AppRoutes].
abstract final class AppRoutes {
  static const String home = '/';
  static const String services = '/services';
  static const String work = '/work';
  static const String about = '/about';
  static const String contact = '/contact';

  static String caseStudy(String slug) => '/work/$slug';

  static const List<String> all = [
    home,
    services,
    work,
    about,
    contact,
  ];
}

/// Nav item metadata for chrome (header / mobile drawer).
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
    NavItem(label: 'About', path: AppRoutes.about),
    NavItem(label: 'Contact', path: AppRoutes.contact),
  ];
}
