/// Analytics provider contracts — keys come from compile-time / remote config.
///
/// Never hardcode API keys or measurement IDs in presentation widgets.
library;

/// Event names used across marketing surfaces.
abstract final class AnalyticsEvents {
  static const String pageView = 'page_view';
  static const String ctaClick = 'cta_click';
  static const String navClick = 'nav_click';
  static const String contactSubmit = 'contact_submit';
  static const String contactSuccess = 'contact_success';
  static const String contactError = 'contact_error';
  static const String newsletterSubmit = 'newsletter_submit';
  static const String caseStudyView = 'case_study_view';
  static const String outboundLink = 'outbound_link';
}

/// Opaque analytics sink — swap implementations without touching UI.
abstract class AnalyticsService {
  Future<void> identify(String? userId);

  Future<void> track(
    String event, {
    Map<String, Object?> properties = const {},
  });

  Future<void> screen(
    String name, {
    Map<String, Object?> properties = const {},
  });
}

/// No-op default — used until providers are configured.
class NoopAnalyticsService implements AnalyticsService {
  const NoopAnalyticsService();

  @override
  Future<void> identify(String? userId) async {}

  @override
  Future<void> track(
    String event, {
    Map<String, Object?> properties = const {},
  }) async {}

  @override
  Future<void> screen(
    String name, {
    Map<String, Object?> properties = const {},
  }) async {}
}

/// Multiplexes to GA / PostHog / Clarity / Meta / Hotjar adapters.
class CompositeAnalyticsService implements AnalyticsService {
  CompositeAnalyticsService(this._delegates);

  final List<AnalyticsService> _delegates;

  @override
  Future<void> identify(String? userId) async {
    for (final d in _delegates) {
      await d.identify(userId);
    }
  }

  @override
  Future<void> track(
    String event, {
    Map<String, Object?> properties = const {},
  }) async {
    for (final d in _delegates) {
      await d.track(event, properties: properties);
    }
  }

  @override
  Future<void> screen(
    String name, {
    Map<String, Object?> properties = const {},
  }) async {
    for (final d in _delegates) {
      await d.screen(name, properties: properties);
    }
  }
}

/// Compile-time / env configuration — empty means provider disabled.
class AnalyticsConfig {
  const AnalyticsConfig({
    this.googleAnalyticsId,
    this.posthogKey,
    this.posthogHost,
    this.clarityId,
    this.metaPixelId,
    this.hotjarId,
  });

  /// From `--dart-define=GA_MEASUREMENT_ID=G-XXXX`
  factory AnalyticsConfig.fromEnvironment() {
    return AnalyticsConfig(
      googleAnalyticsId: _env('GA_MEASUREMENT_ID'),
      posthogKey: _env('POSTHOG_KEY'),
      posthogHost: _env('POSTHOG_HOST'),
      clarityId: _env('CLARITY_ID'),
      metaPixelId: _env('META_PIXEL_ID'),
      hotjarId: _env('HOTJAR_ID'),
    );
  }

  final String? googleAnalyticsId;
  final String? posthogKey;
  final String? posthogHost;
  final String? clarityId;
  final String? metaPixelId;
  final String? hotjarId;

  bool get hasAny =>
      googleAnalyticsId != null ||
      posthogKey != null ||
      clarityId != null ||
      metaPixelId != null ||
      hotjarId != null;

  static String? _env(String key) {
    const map = <String, String>{
      'GA_MEASUREMENT_ID': String.fromEnvironment('GA_MEASUREMENT_ID'),
      'POSTHOG_KEY': String.fromEnvironment('POSTHOG_KEY'),
      'POSTHOG_HOST': String.fromEnvironment('POSTHOG_HOST'),
      'CLARITY_ID': String.fromEnvironment('CLARITY_ID'),
      'META_PIXEL_ID': String.fromEnvironment('META_PIXEL_ID'),
      'HOTJAR_ID': String.fromEnvironment('HOTJAR_ID'),
    };
    final value = map[key];
    if (value == null || value.isEmpty) return null;
    return value;
  }
}
