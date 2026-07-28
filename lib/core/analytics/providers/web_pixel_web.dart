// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:js' as js;

import '../analytics.dart';

Future<void> bootstrapPixels(AnalyticsConfig config) async {
  if (config.googleAnalyticsId != null) {
    _injectScript(
      'https://www.googletagmanager.com/gtag/js?id=${config.googleAnalyticsId}',
      async: true,
    );
    js.context.callMethod('eval', [
      '''
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', '${config.googleAnalyticsId}', { send_page_view: false });
      ''',
    ]);
  }

  if (config.posthogKey != null) {
    final host = config.posthogHost ?? 'https://us.i.posthog.com';
    js.context.callMethod('eval', [
      '''
      !function(t,e){var o,n,p,r;e.__SV||(window.posthog=e,e._i=[],e.init=function(i,s,a){function g(t,e){var o=e.split(".");2==o.length&&(t=t[o[0]],e=o[1]),t[e]=function(){t.push([e].concat(Array.prototype.slice.call(arguments,0)))}}(p=t.createElement("script")).type="text/javascript",p.async=!0,p.src=s.api_host+"/static/array.js",(r=t.getElementsByTagName("script")[0]).parentNode.insertBefore(p,r);var u=e;for(void 0!==a?u=e[a]=[]:a="posthog",u.people=u.people||[],u.toString=function(t){var e="posthog";return"posthog"!==a&&(e+="."+a),t||(e+=" (stub)"),e},u.people.toString=function(){return u.toString(1)+".people (stub)"},o="capture identify alias people.set people.set_once".split(" "),n=0;n<o.length;n++)g(u,o[n]);e._i.push([i,s,a])},e.__SV=1)}(document,window.posthog||[]);
      posthog.init('${config.posthogKey}',{api_host:'$host',capture_pageview:false});
      ''',
    ]);
  }

  if (config.clarityId != null) {
    js.context.callMethod('eval', [
      '''
      (function(c,l,a,r,i,t,y){c[a]=c[a]||function(){(c[a].q=c[a].q||[]).push(arguments)};t=l.createElement(r);t.async=1;t.src="https://www.clarity.ms/tag/"+i;y=l.getElementsByTagName(r)[0];y.parentNode.insertBefore(t,y);})(window, document, "clarity", "script", "${config.clarityId}");
      ''',
    ]);
  }

  if (config.metaPixelId != null) {
    js.context.callMethod('eval', [
      '''
      !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window, document,'script','https://connect.facebook.net/en_US/fbevents.js');
      fbq('init', '${config.metaPixelId}');
      ''',
    ]);
  }

  if (config.hotjarId != null) {
    js.context.callMethod('eval', [
      '''
      (function(h,o,t,j,a,r){h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};h._hjSettings={hjid:${config.hotjarId},hjsv:6};a=o.getElementsByTagName('head')[0];r=o.createElement('script');r.async=1;r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;a.appendChild(r);})(window,document,'https://static.hotjar.com/c/hotjar-','.js?sv=');
      ''',
    ]);
  }
}

Future<void> identify(String? userId) async {
  if (userId == null) return;
  try {
    js.context.callMethod('eval', [
      "if(window.posthog){posthog.identify('${_esc(userId)}');}",
    ]);
  } catch (_) {}
}

Future<void> track(String event, Map<String, Object?> properties) async {
  final props = _jsObjectLiteral(properties);
  try {
    js.context.callMethod('eval', [
      '''
      if(window.gtag){gtag('event','${_esc(event)}',$props);}
      if(window.posthog){posthog.capture('${_esc(event)}',$props);}
      if(window.fbq){fbq('trackCustom','${_esc(event)}',$props);}
      ''',
    ]);
  } catch (_) {}
}

Future<void> screen(String name, Map<String, Object?> properties) async {
  final merged = {...properties, 'page_title': name};
  await track('page_view', merged);
  try {
    js.context.callMethod('eval', [
      "if(window.gtag){gtag('event','page_view',{page_title:'${_esc(name)}'});}",
    ]);
  } catch (_) {}
}

void _injectScript(String src, {bool async = true}) {
  final el = html.ScriptElement()
    ..src = src
    ..async = async;
  html.document.head?.append(el);
}

String _esc(String value) => value.replaceAll("'", r"\'");

String _jsObjectLiteral(Map<String, Object?> map) {
  final parts = map.entries.map((e) {
    final v = e.value;
    if (v == null) return "'${_esc(e.key)}':null";
    if (v is num || v is bool) return "'${_esc(e.key)}':$v";
    return "'${_esc(e.key)}':'${_esc(v.toString())}'";
  });
  return '{${parts.join(',')}}';
}
