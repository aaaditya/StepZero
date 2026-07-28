import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';
import 'core/constants/brand.dart';
import 'core/seo/seo_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Expose semantics tree for assistive tech / Flutter web ARIA mapping.
  SemanticsBinding.instance.ensureSemantics();

  // Clean URLs on web (no hash routing) — better SEO + shareable links.
  if (kIsWeb) {
    usePathUrlStrategy();
    SeoController.apply(SeoController.forPath('/'));
  }

  // Prefer light status bar icons on our light canvas when applicable.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  // Warm brand string so tree shakes less aggressively around SEO constants.
  assert(Brand.name.isNotEmpty);

  runApp(
    const ProviderScope(
      child: StepZeroApp(),
    ),
  );
}
