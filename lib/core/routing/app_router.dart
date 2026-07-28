import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/about/presentation/pages/about_page.dart';
import '../../features/contact/presentation/pages/contact_page.dart';
import '../../features/content/presentation/pages/articles_page.dart';
import '../../features/content/presentation/pages/faq_page.dart';
import '../../features/content/presentation/pages/industries_page.dart';
import '../../features/content/presentation/pages/pricing_page.dart';
import '../../features/content/presentation/pages/services_page.dart';
import '../../features/content/presentation/pages/team_page.dart';
import '../../features/content/presentation/pages/testimonials_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/work/presentation/pages/case_study_page.dart';
import '../../features/work/presentation/pages/work_page.dart';
import '../../shared/layout/page_shell.dart';
import '../constants/curves.dart';
import '../constants/durations.dart';
import 'routes.dart';

/// Root navigator key — required for dialogs / snackbars outside the route tree.
final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// GoRouter provider — swap later for auth redirects without touching UI.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: false,
    routes: [
      ShellRoute(
        builder: (context, state, child) => PageShell(
          location: state.uri.path,
          child: child,
        ),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const HomePage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.services,
            name: 'services',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const ServicesPage(),
            ),
            routes: [
              GoRoute(
                path: ':slug',
                name: 'service',
                pageBuilder: (context, state) {
                  final slug =
                      AppRoutes.sanitizeSlug(state.pathParameters['slug']);
                  return _fadePage(
                    state: state,
                    child: slug == null
                        ? const _NotFoundView(uri: 'Invalid service')
                        : ServiceDetailPage(slug: slug),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.work,
            name: 'work',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const WorkPage(),
            ),
            routes: [
              GoRoute(
                path: ':slug',
                name: 'case-study',
                pageBuilder: (context, state) {
                  final slug =
                      AppRoutes.sanitizeSlug(state.pathParameters['slug']);
                  return _fadePage(
                    state: state,
                    child: slug == null
                        ? const _NotFoundView(uri: 'Invalid case study')
                        : CaseStudyPage(slug: slug),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.articles,
            name: 'articles',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const ArticlesPage(),
            ),
            routes: [
              GoRoute(
                path: ':slug',
                name: 'article',
                pageBuilder: (context, state) {
                  final slug =
                      AppRoutes.sanitizeSlug(state.pathParameters['slug']);
                  return _fadePage(
                    state: state,
                    child: slug == null
                        ? const _NotFoundView(uri: 'Invalid article')
                        : ArticleDetailPage(slug: slug),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.testimonials,
            name: 'testimonials',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const TestimonialsPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.team,
            name: 'team',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const TeamPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.faq,
            name: 'faq',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const FaqPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.pricing,
            name: 'pricing',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const PricingPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.industries,
            name: 'industries',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const IndustriesPage(),
            ),
            routes: [
              GoRoute(
                path: ':slug',
                name: 'industry',
                pageBuilder: (context, state) {
                  final slug =
                      AppRoutes.sanitizeSlug(state.pathParameters['slug']);
                  return _fadePage(
                    state: state,
                    child: slug == null
                        ? const _NotFoundView(uri: 'Invalid industry')
                        : IndustryDetailPage(slug: slug),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.about,
            name: 'about',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const AboutPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.contact,
            name: 'contact',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const ContactPage(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => PageShell(
      location: state.uri.path,
      child: _NotFoundView(uri: state.uri.toString()),
    ),
  );
});

CustomTransitionPage<void> _fadePage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    name: state.name,
    child: child,
    transitionDuration: AppDurations.page,
    reverseTransitionDuration: AppDurations.pageReverse,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final reduce = MediaQuery.disableAnimationsOf(context);
      if (reduce) return child;

      final curved = CurvedAnimation(
        parent: animation,
        curve: AppCurves.page,
        reverseCurve: AppCurves.exit,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.012),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _NotFoundView extends StatelessWidget {
  const _NotFoundView({required this.uri});

  final String uri;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '404',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 12),
            Text(
              'This page does not exist.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => GoRouter.of(context).go(AppRoutes.home),
              child: const Text('Back home'),
            ),
          ],
        ),
      ),
    );
  }
}
