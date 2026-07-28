// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;

/// Web implementation — mutates document head for SEO / OG / Twitter / JSON-LD.
void applyDocumentMeta({
  required String title,
  required String description,
  required String canonicalUrl,
  required String imageUrl,
  required String type,
  required bool noIndex,
  required String siteName,
  String? jsonLd,
}) {
  html.document.title = title;

  _setMeta('name', 'description', description);
  _setMeta(
    'name',
    'robots',
    noIndex
        ? 'noindex, nofollow'
        : 'index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1',
  );

  _setLink('canonical', canonicalUrl);

  // Open Graph
  _setMeta('property', 'og:type', type);
  _setMeta('property', 'og:site_name', siteName);
  _setMeta('property', 'og:url', canonicalUrl);
  _setMeta('property', 'og:title', title);
  _setMeta('property', 'og:description', description);
  _setMeta('property', 'og:image', imageUrl);
  _setMeta('property', 'og:image:alt', title);

  // Twitter Cards
  _setMeta('name', 'twitter:card', 'summary_large_image');
  _setMeta('name', 'twitter:title', title);
  _setMeta('name', 'twitter:description', description);
  _setMeta('name', 'twitter:image', imageUrl);
  _setMeta('name', 'twitter:image:alt', title);

  if (jsonLd != null) {
    _setJsonLd(jsonLd);
  }
}

void _setMeta(String attr, String key, String content) {
  final head = html.document.head;
  if (head == null) return;

  html.Element? el = head.querySelector('meta[$attr="$key"]');
  if (el == null) {
    el = html.MetaElement()..setAttribute(attr, key);
    head.append(el);
  }
  el.setAttribute('content', content);
}

void _setLink(String rel, String href) {
  final head = html.document.head;
  if (head == null) return;

  html.Element? el = head.querySelector('link[rel="$rel"]');
  if (el == null) {
    el = html.LinkElement()..rel = rel;
    head.append(el);
  }
  el.setAttribute('href', href);
}

void _setJsonLd(String json) {
  final head = html.document.head;
  if (head == null) return;

  const id = 'stepzero-json-ld-dynamic';
  html.Element? el = head.querySelector('script#$id');
  if (el == null) {
    el = html.ScriptElement()
      ..id = id
      ..type = 'application/ld+json';
    head.append(el);
  }
  el.setInnerHtml(json, treeSanitizer: html.NodeTreeSanitizer.trusted);
}
