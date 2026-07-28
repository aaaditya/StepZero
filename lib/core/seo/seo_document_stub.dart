/// Stub — document meta updates are web-only.
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
  // No-op on VM / tests / mobile.
}
