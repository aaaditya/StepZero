import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Safe external navigation — scheme allowlist + new-tab on web.
abstract final class ExternalLink {
  static const _allowedSchemes = {'http', 'https', 'mailto'};

  static Future<bool> open(
    String url, {
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    final trimmed = url.trim();
    if (trimmed.isEmpty || trimmed.length > 2048) return false;

    final uri = Uri.tryParse(trimmed);
    if (uri == null || !uri.hasScheme) return false;
    if (!_allowedSchemes.contains(uri.scheme.toLowerCase())) return false;

    // Block credentials / userinfo surprises in http(s) links.
    if ((uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.userInfo.isNotEmpty) {
      return false;
    }

    try {
      if (await canLaunchUrl(uri)) {
        return launchUrl(
          uri,
          mode: mode,
          webOnlyWindowName: kIsWeb ? '_blank' : null,
        );
      }
    } catch (_) {
      return false;
    }
    return false;
  }

  static Future<bool> mailto(String email, {String? subject, String? body}) {
    final cleaned = email.trim();
    if (cleaned.isEmpty || cleaned.contains(RegExp(r'[\s<>]'))) {
      return Future.value(false);
    }
    final params = <String, String>{
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
    };
    final query = params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
    final url = query.isEmpty ? 'mailto:$cleaned' : 'mailto:$cleaned?$query';
    return open(url, mode: LaunchMode.platformDefault);
  }
}
