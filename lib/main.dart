import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Clean URLs on web (no hash routing).
  if (kIsWeb) {
    usePathUrlStrategy();
  }

  // Prefer light status bar icons on our light canvas when applicable.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(
    const ProviderScope(
      child: StepZeroApp(),
    ),
  );
}
