import '../../../core/routing/routes.dart';
import '../domain/site_config.dart';

/// Default site settings — Navigation, Footer, brand chrome.
///
/// Swap this catalog for remote config / CMS without touching chrome widgets.
abstract final class SiteConfigCatalog {
  static const settings = SiteSettings(
    siteName: 'StepZero',
    legalName: 'StepZero',
    tagline: 'We build businesses people trust.',
    mission:
        'Helping local businesses become premium brands through '
        'strategy, branding, websites, AI automation, and digital growth.',
    primaryCtaLabel: 'Start a project',
    primaryCtaPath: AppRoutes.contact,
    contactEmail: 'hello@stepzero.studio',
    navigation: NavigationConfig(
      primary: [
        NavLink(label: 'Services', path: AppRoutes.services),
        NavLink(label: 'Work', path: AppRoutes.work),
        NavLink(label: 'Insights', path: AppRoutes.articles),
        NavLink(label: 'Pricing', path: AppRoutes.pricing),
        NavLink(label: 'About', path: AppRoutes.about),
        NavLink(label: 'Contact', path: AppRoutes.contact),
      ],
      utility: [
        NavLink(label: 'Industries', path: AppRoutes.industries),
        NavLink(label: 'Team', path: AppRoutes.team),
        NavLink(label: 'Testimonials', path: AppRoutes.testimonials),
        NavLink(label: 'FAQ', path: AppRoutes.faq),
      ],
    ),
    footer: FooterConfig(
      columns: [
        FooterColumn(
          title: 'Navigate',
          links: [
            NavLink(label: 'Services', path: AppRoutes.services),
            NavLink(label: 'Work', path: AppRoutes.work),
            NavLink(label: 'Insights', path: AppRoutes.articles),
            NavLink(label: 'Pricing', path: AppRoutes.pricing),
            NavLink(label: 'About', path: AppRoutes.about),
            NavLink(label: 'Contact', path: AppRoutes.contact),
          ],
        ),
        FooterColumn(
          title: 'Explore',
          links: [
            NavLink(label: 'Industries', path: AppRoutes.industries),
            NavLink(label: 'Team', path: AppRoutes.team),
            NavLink(label: 'Testimonials', path: AppRoutes.testimonials),
            NavLink(label: 'FAQ', path: AppRoutes.faq),
          ],
        ),
      ],
      contactBlurb: 'Book a discovery call',
      newsletterTitle: 'Newsletter',
      newsletterBlurb: 'Operator notes. No spam.',
      socials: [
        SocialLink(label: 'Instagram', url: 'https://instagram.com'),
        SocialLink(label: 'LinkedIn', url: 'https://linkedin.com'),
        SocialLink(label: 'X', url: 'https://x.com'),
      ],
    ),
  );
}
