# Performance, SEO & Accessibility

Target: **Lighthouse Performance / Accessibility / Best Practices / SEO ≥ 95** on production web builds.

---

## Fast loading

| Technique | Implementation |
|---|---|
| Path URLs | `usePathUrlStrategy()` in `main.dart` |
| Self-hosted Inter | `assets/fonts/Inter-Variable.ttf` — no Google Fonts CDN on critical path |
| Boot splash | `web/index.html` loading shell removed on `flutter-first-frame` |
| Preload bootstrap | `<link rel="preload" href="flutter_bootstrap.js">` |
| Below-fold deferral | `LazySection` + `ShellScroll` on homepage |

### Build tips

```bash
flutter build web --release --tree-shake-icons
# Prefer hosting with Brotli/gzip + long-cache hashed assets
```

---

## Lazy loading

- Homepage: hero + transformation eager; remaining sections build when near viewport (`rootMargin: 600`).
- `OptimizedImage` only decodes when laid out; use for future media.
- Route transitions use short fades (avoid long main-thread work).

---

## Image optimization / responsive images

`OptimizedImage` (`lib/core/widgets/optimized_image.dart`):

- Layout-based `cacheWidth` / `cacheHeight` × device pixel ratio
- Cap decode width (`maxDecodeWidth`)
- Fixed `aspectRatio` to prevent CLS
- Fade-in without layout shift
- Semantic labels / `ExcludeSemantics` for decorative cases

Static share asset: `web/og-image.png` (1200×630).

---

## Accessibility

- `<html lang="en">` + skip link in `index.html`
- `SemanticsBinding.ensureSemantics()`
- `SectionLandmark` defaults `header: false`; titles use `SectionHeader` headers
- Decorative painters wrapped in `ExcludeSemantics`
- Buttons / nav / links expose `Semantics(button|link|selected)`
- Reduced-motion honored by `Reveal` / counters

---

## SEO / metadata

| Layer | Location |
|---|---|
| Static head | `web/index.html` — description, robots, canonical |
| Open Graph | `og:*` tags in `index.html` + per-route via `SeoController` |
| Twitter Cards | `twitter:card=summary_large_image` + title/description/image |
| Structured data | Organization / WebSite / ProfessionalService in HTML; FAQPage / Article / CaseStudy via `StructuredData` |
| Per-route titles | `SeoController.forPath` + `SeoEffect` on detail pages |
| Crawl map | `web/robots.txt`, `web/sitemap.xml` |
| Noscript body | Indexable fallback links in `index.html` |

Flutter canvas apps still benefit from a **static shell + JSON-LD + sitemap**. For fully crawlable body HTML at scale, add prerender/SSR later — the shell + noscript + structured data cover social/crawler baselines.

---

## Core Web Vitals mapping

| Metric | Mitigations |
|---|---|
| **LCP** | Splash → first frame; self-hosted font; eager hero |
| **INP** | Lazy sections; short transitions; avoid building full page upfront |
| **CLS** | Fixed image aspect ratios; reserved lazy placeholders; stable nav height |

---

## Semantic HTML (Flutter Web)

Flutter maps the semantics tree to ARIA on web. Patterns we use:

- Page landmarks via `Semantics(container, label)`
- Headings via `Semantics(header: true)` on section titles
- Images via `Semantics(image: true, label: …)`
- Skip link targets `#main-content` in the HTML shell

---

## Checklist before ship

1. `flutter build web --release --tree-shake-icons`
2. Lighthouse (mobile + desktop) on staging host with compression
3. Confirm `og-image.png`, `robots.txt`, `sitemap.xml` are served at site root
4. Spot-check Twitter Card Validator / Facebook Sharing Debugger
5. Keyboard: skip link, nav, FAQ accordion
