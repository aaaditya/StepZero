# StepZero

Official website for **StepZero** — a premium business growth studio.

> We don't sell websites. We build businesses people trust.

## Stack

| Layer | Choice |
|---|---|
| Framework | Flutter (stable) · Material 3 |
| State | Riverpod |
| Routing | GoRouter (path URL strategy) |
| Motion | flutter_animate + custom motion system |
| Typography | Self-hosted Inter variable |
| Analytics | Pluggable (GA / PostHog / Clarity / Meta / Hotjar) via `--dart-define` |

## Architecture

Feature-first Clean Architecture. See:

- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) — decisions & boundaries
- [docs/FOLDER_STRUCTURE.md](docs/FOLDER_STRUCTURE.md) — where code lives
- [docs/CONTENT_SYSTEM.md](docs/CONTENT_SYSTEM.md) — CMS-ready catalogs
- [docs/CASE_STUDY_SYSTEM.md](docs/CASE_STUDY_SYSTEM.md) — work storytelling
- [docs/PERFORMANCE_SEO.md](docs/PERFORMANCE_SEO.md) — web vitals & SEO
- [docs/MOTION.md](docs/MOTION.md) — interaction language
- [docs/DEPLOY.md](docs/DEPLOY.md) — hosting targets
- [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) — engineering standards
- [docs/ROADMAP.md](docs/ROADMAP.md) — what comes next

## Setup

```bash
# Flutter stable ≥ 3.32
flutter pub get
flutter run -d chrome
```

Quality gates:

```bash
flutter analyze
flutter test
flutter build web --release
```

### Analytics (optional)

Keys are **never** hardcoded. Pass at build time:

```bash
flutter build web --release \
  --dart-define=GA_MEASUREMENT_ID=G-XXXX \
  --dart-define=POSTHOG_KEY=phc_xxxx \
  --dart-define=POSTHOG_HOST=https://app.posthog.com \
  --dart-define=CLARITY_ID=xxxx \
  --dart-define=META_PIXEL_ID=xxxx \
  --dart-define=HOTJAR_ID=xxxx
```

## Project layout

```
lib/
  core/           # Design system, SEO, analytics, routing, shared widgets
  features/       # home · work · content · contact · about · …
  shared/         # Page shell (nav + footer)
web/              # index.html, PWA, robots, sitemap, SPA redirects
docs/             # Architecture & product documentation
```

## Brand tokens

| Token | Value |
|---|---|
| Background | `#FAFAF8` |
| Surface | `#FFFFFF` |
| Text | `#111111` |
| Secondary text | `#6B7280` |
| Border | `#ECECEC` |
| Accent | `#5B5FEF` |

## Contact

Production form at `/contact` — validation, honeypot spam placeholder, loading / success / error states, analytics events. Swap `MockContactRepository` for your CRM/API when ready.

## License

Proprietary — StepZero. All rights reserved.
