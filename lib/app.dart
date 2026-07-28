import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/brand.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

/// Root application widget.
///
/// Owns theme + router only. Feature UI lives under `features/`.
class StepZeroApp extends ConsumerWidget {
  const StepZeroApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: Brand.name,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
