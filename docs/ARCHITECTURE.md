# StepZero Architecture

Production architecture for the StepZero marketing site — a Flutter web application
representing a premium business growth studio.

---

## Principles

1. **Feature-first Clean Architecture** — vertical slices own their data/domain/presentation.
2. **Single source of truth** — catalogs drive UI; no duplicated marketing copy.
3. **SOLID** — repositories behind interfaces; analytics/SEO behind controllers; widgets stay dumb.
4. **Web-native** — path URLs, document SEO, PWA, SPA fallbacks on every host.
5. **Accessibility by default** — semantics, focus, touch targets ≥ 48px, reduced motion.
6. **No secrets in source** — analytics IDs via `--dart-define` only.

---

## Stack

| Concern | Choice | Why |
|---|---|---|
| Framework | Flutter + Material 3 | Tokenized UI, one codebase, strong web story |
| State | Riverpod | Compile-safe DI, testable providers |
| Routing | GoRouter | URL-first, deep links, slug sanitization |
| Type | Self-hosted Inter | Zero Google Fonts runtime / privacy / CWV |
| Motion | flutter_animate + `core/animations` | Shared recipes, reduced-motion aware |
| Links | `url_launcher` + `ExternalLink` | Scheme allowlist, blank-target outbound |
| Analytics | `AnalyticsService` composite | GA / PostHog / Clarity / Meta / Hotjar ready |

---

## Folder architecture

```
lib/
  main.dart                 # Binding, path strategy, ProviderScope
  app.dart                  # MaterialApp.router
  core/
    analytics/              # Pluggable analytics (no hardcoded keys)
    animations/             # Magnetic, parallax, skeleton, a11y
    constants/              # Brand, layout, breakpoints, motion
    routing/                # GoRouter + AppRoutes + slug sanitize
    seo/                    # PageMeta, SeoController, JSON-LD
    theme/                  # Colors, type, spacing, radius, elevation
    utils/                  # Responsive, validators, ExternalLink
    widgets/                # Design-system primitives
  features/
    home|work|content|contact|about/
      data/                 # Catalogs + repository impls
      domain/               # Entities + repository contracts
      presentation/         # Pages, providers, feature widgets
  shared/layout/            # PageShell (nav + footer + scroll)
web/                        # SEO shell, PWA, robots, sitemap, SPA redirects
docs/                       # Living documentation
```

See [FOLDER_STRUCTURE.md](FOLDER_STRUCTURE.md) for file-level guidance.

---

## Dependency rules

```
presentation → domain ← data
      ↓
    core
```

- **presentation** may import domain + core (+ Riverpod).
- **domain** is pure Dart (no Flutter widgets).
- **data** implements domain contracts; catalogs are the CMS swap point.
- **core** never imports features.

---

## Design system

Tokens live under `core/theme` and `core/constants`:

| Token | File |
|---|---|
| Color | `app_colors.dart` |
| Type | `app_typography.dart` |
| Spacing | `app_spacing.dart` |
| Radius | `app_radius.dart` |
| Elevation | `app_elevation.dart` |
| Layout / a11y | `app_layout.dart` |
| Brand / SEO origin | `brand.dart` |

Magic numbers in UI are rejected in review — use tokens.

---

## Content & case studies

- Collections (services, articles, FAQs, …) → `features/content`
- Case studies → `features/work` (catalog is SSOT; homepage Featured Work reads providers)
- Site chrome (nav/footer/settings) → `SiteSettings` catalog

---

## Contact pipeline

```
ContactPage → AppValidators → ContactRepository → ContactSubmitResult
                     ↓
              AnalyticsEvents
```

`MockContactRepository` simulates latency / honeypot. Replace with HTTP/CRM in `ContactRepositoryImpl`.

---

## Analytics

```
AnalyticsConfig.fromEnvironment()
        ↓
CompositeAnalyticsService([WebPixel…, Console…])
        ↓
analyticsProvider (Riverpod)
```

Empty env → console-only (debug) / noop-safe. Never ship keys in git.

---

## SEO

- Static shell: `web/index.html` (OG, Twitter, JSON-LD, skip link, splash)
- Runtime: `SeoController` updates title/meta/canonical/JSON-LD per route
- Crawlers: `robots.txt`, `sitemap.xml`, absolute OG image

---

## Security

| Control | Implementation |
|---|---|
| External links | Scheme allowlist (`http`/`https`/`mailto`) |
| Forms | Validators + honeypot field |
| Routing | Slug regex sanitization; branded 404 |
| Headers | Host configs set `X-Frame-Options`, `nosniff`, referrer policy |

---

## Performance

- Lazy sections (`LazySection`) for below-fold content
- `RepaintBoundary` on heavy compositions (hero dashboard)
- Self-hosted fonts; no render-blocking webfont CSS
- Image helper with decode sizing (`OptimizedImage`)
- Const constructors preferred; reduce rebuilds via Riverpod select / Consumer scope

---

## Testing

```bash
flutter analyze
flutter test
```

Coverage includes content catalogs, case studies, SEO helpers, motion a11y, validators, contact repository.

---

## Deployment

Configs: `firebase.json`, `vercel.json`, `netlify.toml`, `web/_redirects`, `web/_headers`,
`.github/workflows/deploy-github-pages.yml`. Details in [DEPLOY.md](DEPLOY.md).
