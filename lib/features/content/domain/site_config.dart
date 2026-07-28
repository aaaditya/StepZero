/// Site chrome configuration — Navigation, Footer, Settings.
library;

class NavLink {
  const NavLink({
    required this.label,
    required this.path,
  });

  final String label;
  final String path;
}

class FooterColumn {
  const FooterColumn({
    required this.title,
    required this.links,
  });

  final String title;
  final List<NavLink> links;
}

class SocialLink {
  const SocialLink({
    required this.label,
    required this.url,
  });

  final String label;
  final String url;
}

class NavigationConfig {
  const NavigationConfig({
    required this.primary,
    this.utility = const [],
  });

  final List<NavLink> primary;
  final List<NavLink> utility;
}

class FooterConfig {
  const FooterConfig({
    required this.columns,
    required this.contactBlurb,
    required this.newsletterTitle,
    required this.newsletterBlurb,
    required this.socials,
    this.showNewsletter = true,
  });

  final List<FooterColumn> columns;
  final String contactBlurb;
  final String newsletterTitle;
  final String newsletterBlurb;
  final List<SocialLink> socials;
  final bool showNewsletter;
}

/// Global site settings — single source for brand chrome + CTAs.
class SiteSettings {
  const SiteSettings({
    required this.siteName,
    required this.legalName,
    required this.tagline,
    required this.mission,
    required this.primaryCtaLabel,
    required this.primaryCtaPath,
    required this.contactEmail,
    required this.navigation,
    required this.footer,
  });

  final String siteName;
  final String legalName;
  final String tagline;
  final String mission;
  final String primaryCtaLabel;
  final String primaryCtaPath;
  final String contactEmail;
  final NavigationConfig navigation;
  final FooterConfig footer;
}
