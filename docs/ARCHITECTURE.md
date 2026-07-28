# StepZero Architecture

Official website foundation for **StepZero** — a premium business growth studio.

This document explains every architectural decision in the Flutter project.
Marketing page sections are intentionally **not** built yet; only the production-ready substrate is.

---

## Stack

| Concern | Choice | Why |
|---|---|---|
| Framework | Flutter (stable) + Material 3 | Single codebase for web-first marketing with mobile reach; M3 gives tokenized theming without fighting the framework |
| State | Riverpod (`flutter_riverpod`) | Compile-safe DI, testable providers, no `BuildContext` gymnastics for services/router |
| Routing | GoRouter | URL-first navigation required for a public website (SEO paths, deep links, browser back) |
| Type | Google Fonts → Inter | Spec-mandated; swap to self-hosted assets later without API changes |
| Motion | flutter_animate | Declarative effects with shared recipes; no deprecated animation packages |

---

## Folder architecture

```
lib/
  main.dart                 # Bootstrap only (binding, URL strategy, ProviderScope)
  app.dart                  # MaterialApp.router + theme + router wiring
  core/                     # Framework-agnostic-to-UI primitives shared by all features
    theme/                  # Colors, type, spacing, radius, elevation, ThemeData
    constants/              # Brand, breakpoints, durations, curves
    extensions/             # Context / TextStyle / num / Widget sugar
    animations/             # Motion recipes + hover primitives
    widgets/                # Design-system components (Button, Card, Field, …)
    routing/                # GoRouter + path constants
    utils/                  # Responsive helpers
  features/                 # Feature-first vertical slices
    home|services|work|about|contact/
      data/                 # Repositories, DTOs, remote/local sources (future)
      domain/               # Entities, use-cases, pure business rules (future)
      presentation/
        pages/              # Route entry widgets
        widgets/            # Feature-only UI pieces
  shared/                   # Cross-feature chrome (nav, footer, page shell)
```

### Why feature-first?

Agency sites grow by **section**, not by layer. Putting `home`, `work`, and `contact` in separate vertical slices means:

1. A designer/engineer can ship Work without touching Contact.
2. Domain models (case studies, service catalog) stay next to their UI.
3. We never need a big-bang refactor when the site gains a blog, careers, or CMS.

`core/` holds only things that are **stable across features**. If a widget is only used on Home, it belongs in `features/home/presentation/widgets/`.

### Clean Architecture inside features

Each feature reserves `data/` → `domain/` → `presentation/`:

- **presentation** may depend on domain (and core).
- **domain** depends on nothing Flutter-specific.
- **data** implements domain contracts.

Today those layers are empty placeholders (`.gitkeep`) because there is no CMS yet. The folders exist so the next engineer does not invent a second structure.

---

## Design system

### Tokens over magic numbers

Every visual decision is a named token:

| Token file | Responsibility |
|---|---|
| `app_colors.dart` | Surfaces, text, border, accent, semantic |
| `app_typography.dart` | Inter scale (Hero 80 → Caption 14) |
| `app_spacing.dart` | 4–120 spacing + semantic gutters |
| `app_radius.dart` | 12 / 16 / 20 / 24 / 32 (+ pill for badges only) |
| `app_elevation.dart` | Soft single-layer shadows + focus rings |
| `durations.dart` / `curves.dart` | Motion consistency |
| `breakpoints.dart` | Desktop-first responsive thresholds |

### Theme assembly

`AppTheme.light` maps tokens into Material 3 `ThemeData` and registers `StepZeroTheme` as a `ThemeExtension` for values Material does not model (content max-width, hover duration, accent subtle, etc.).

Access patterns:

```dart
context.sz.cardRadius          // ThemeExtension
AppColors.accent               // Direct token
AppTypography.headingLStyle    // Direct type token
Responsive.pageGutter(context) // Layout utility
```

### Why not Theme-only?

Marketing sites often need tokens **outside** widgets (static configs, tests, SEO). Direct `AppColors` / `AppSpacing` imports stay valid. Theme exists so Material widgets inherit the same look without re-styling.

### Components (foundation)

| Widget | Role |
|---|---|
| `AppButton` | Primary / secondary / ghost / dark CTAs with hover + focus rings |
| `AppCard` | Interactive containers only (not decorative boxes) |
| `AppBadge` | Taxonomy / status chips |
| `AppTextField` | Labeled inputs wired to input theme |
| `AppText` | Semantic type wrappers + fluid hero |
| `MaxWidthBox` / `SectionContainer` | Layout rhythm for every section |
| `ResponsiveBuilder` | Desktop / tablet / mobile trees |
| `FadeUp` / `HoverScale` | Shared motion primitives |

---

## Responsive strategy

**Desktop-first.** Primary design target is `≥ 1024px`.

| Breakpoint | Width |
|---|---|
| mobile | `< 768` |
| tablet | `768–1023` |
| desktop | `1024–1279` |
| desktopLarge | `≥ 1280` |
| max content | `1200` |
| max hero | `1400` |

Gutters and section padding scale via `Responsive` — never hardcode page padding in feature widgets.

Typography fluid scaling: Hero 80 → 56 (tablet) → 40 (mobile).

---

## Routing

- `ShellRoute` wraps every page in `PageShell` (nav + footer).
- Feature pages are **content-only**; they do not rebuild chrome.
- Soft fade transitions (`CustomTransitionPage`) keep navigation premium without theatrical page curls.
- Path constants live in `AppRoutes` — no stringly-typed `context.go('/…')` in UI.

Riverpod exposes `appRouterProvider` so future auth/CMS redirects inject without rewriting `MaterialApp`.

---

## What this foundation deliberately does *not* include

- Full marketing sections / case studies / pricing
- CMS / backend integration
- Dark mode (one decisive light brand first)
- Localization (structure can accept it later via `easy_localization` or Flutter l10n)
- Analytics / SEO meta widgets (add under `shared/` when content ships)

These are product features, not substrate. Shipping them now would force redesign once the visual language is set.

---

## How to add a new section safely

1. Create widgets under the owning feature (`features/home/presentation/widgets/…`).
2. Compose them inside the feature page.
3. Use `SectionContainer` + `AppText` + spacing tokens — never raw paddings/colors.
4. If a widget is reused by two features, promote it to `shared/` or `core/widgets/`.
5. If it needs data, add a domain entity + repository under that feature first.

No core refactor required.

---

## Run

```bash
flutter pub get
flutter run -d chrome
flutter analyze
flutter test
```
