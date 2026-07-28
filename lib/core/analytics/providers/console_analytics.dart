import '../analytics.dart';

/// Debug sink — logs events in debug/profile builds only via assert.
class ConsoleAnalyticsService implements AnalyticsService {
  const ConsoleAnalyticsService();

  @override
  Future<void> identify(String? userId) async {
    assert(() {
      // ignore: avoid_print
      print('[analytics] identify=$userId');
      return true;
    }());
  }

  @override
  Future<void> track(
    String event, {
    Map<String, Object?> properties = const {},
  }) async {
    assert(() {
      // ignore: avoid_print
      print('[analytics] track=$event props=$properties');
      return true;
    }());
  }

  @override
  Future<void> screen(
    String name, {
    Map<String, Object?> properties = const {},
  }) async {
    assert(() {
      // ignore: avoid_print
      print('[analytics] screen=$name props=$properties');
      return true;
    }());
  }
}
