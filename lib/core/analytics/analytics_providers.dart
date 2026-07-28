import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'analytics.dart';
import 'providers/console_analytics.dart';
import 'providers/web_pixel_analytics.dart';

final analyticsConfigProvider = Provider<AnalyticsConfig>(
  (ref) => AnalyticsConfig.fromEnvironment(),
);

/// Application-wide analytics — composite of configured providers.
final analyticsProvider = Provider<AnalyticsService>((ref) {
  final config = ref.watch(analyticsConfigProvider);
  final delegates = <AnalyticsService>[
    if (config.hasAny) WebPixelAnalyticsService(config),
    // Debug console in profile/debug — never ships keys.
    const ConsoleAnalyticsService(),
  ];
  if (delegates.isEmpty) return const NoopAnalyticsService();
  return CompositeAnalyticsService(delegates);
});
