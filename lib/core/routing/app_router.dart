import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/about/presentation/pages/about_page.dart';
import '../../features/contact/presentation/pages/contact_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/services/presentation/pages/services_page.dart';
import '../../features/work/presentation/pages/work_page.dart';
import '../../shared/layout/page_shell.dart';
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
          ),
          GoRoute(
            path: AppRoutes.work,
            name: 'work',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const WorkPage(),
            ),
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
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ),
        child: child,
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
