# Folder structure

## Top level

| Path | Purpose |
|---|---|
| `lib/` | Application source |
| `web/` | Flutter web shell + SEO/PWA assets |
| `assets/` | Fonts, future images/icons |
| `test/` | Unit / widget / catalog tests |
| `docs/` | Architecture & product docs |
| `firebase.json` / `vercel.json` / `netlify.toml` | Host adapters |
| `.github/workflows/` | CI / GitHub Pages deploy |

## `lib/core`

Shared infrastructure. **Never** import a feature from here.

| Folder | Owns |
|---|---|
| `analytics/` | `AnalyticsService`, env config, web pixel adapters |
| `animations/` | Motion primitives + accessibility |
| `constants/` | Brand, layout, breakpoints, durations, curves |
| `extensions/` | Dart/Flutter sugar |
| `routing/` | GoRouter, `AppRoutes`, slug sanitize |
| `seo/` | Meta, document mutation, JSON-LD builders |
| `theme/` | Design tokens + `ThemeData` |
| `utils/` | Responsive, validators, `ExternalLink` |
| `widgets/` | Design-system components (document with dartdoc) |

## `lib/features/<name>`

| Layer | Owns |
|---|---|
| `domain/` | Entities, enums, repository interfaces |
| `data/` | Catalogs, DTOs, repository implementations |
| `presentation/pages/` | Route entry widgets |
| `presentation/providers/` | Riverpod wiring |
| `presentation/widgets/` | Feature-only UI |

### Active features

- `home` — homepage sections
- `work` — case study system
- `content` — services, articles, FAQ, pricing, team, industries, site config
- `contact` — lead form + repository
- `about` — studio story

## `lib/shared`

Cross-feature chrome only (`PageShell`, page body helpers). If a widget is used by one feature, keep it in that feature.

## `web/`

| File | Role |
|---|---|
| `index.html` | SEO shell, OG/Twitter, JSON-LD, skip link, splash |
| `manifest.json` | PWA |
| `robots.txt` / `sitemap.xml` | Crawl control |
| `_redirects` / `_headers` | SPA + security headers for static hosts |
| `icons/` / `favicon.png` / `og-image.png` | Brand assets |

## Adding a page

1. Add path to `AppRoutes`.
2. Register `GoRoute` in `app_router.dart` (sanitize slugs).
3. Add `PageMeta` entry in `SeoController` / sitemap.
4. Prefer catalog content over hardcoding copy.
5. Wrap with `SeoEffect` when page needs unique JSON-LD.
