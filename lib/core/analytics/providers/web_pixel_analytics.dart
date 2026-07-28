import '../analytics.dart';
import 'web_pixel_stub.dart'
    if (dart.library.html) 'web_pixel_web.dart' as pixel;

/// Injects / calls browser pixels when IDs are present via dart-define.
class WebPixelAnalyticsService implements AnalyticsService {
  WebPixelAnalyticsService(this.config);

  final AnalyticsConfig config;

  bool _bootstrapped = false;

  Future<void> _ensureBootstrapped() async {
    if (_bootstrapped) return;
    _bootstrapped = true;
    await pixel.bootstrapPixels(config);
  }

  @override
  Future<void> identify(String? userId) async {
    await _ensureBootstrapped();
    await pixel.identify(userId);
  }

  @override
  Future<void> track(
    String event, {
    Map<String, Object?> properties = const {},
  }) async {
    await _ensureBootstrapped();
    await pixel.track(event, properties);
  }

  @override
  Future<void> screen(
    String name, {
    Map<String, Object?> properties = const {},
  }) async {
    await _ensureBootstrapped();
    await pixel.screen(name, properties);
  }
}
