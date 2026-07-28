# StepZero

Official website for **StepZero** — a premium business growth studio.

> We don't sell websites. We build businesses people trust.

## Status

This repository currently contains the **production-ready Flutter foundation**:

- Feature-first Clean Architecture
- Complete design system (color, type, spacing, radius, elevation, motion)
- Material 3 theme + ThemeExtension tokens
- Riverpod + GoRouter app shell
- Responsive desktop-first utilities
- Reusable UI primitives (buttons, cards, fields, badges, layout)

Marketing page sections are **not** built yet by design.

## Architecture

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for every structural decision.

## Homepage UX

See [docs/HOMEPAGE_UX_BLUEPRINT.md](docs/HOMEPAGE_UX_BLUEPRINT.md) for the full information architecture, user journey, and wireframe blueprint (no UI code).

## Hero

The homepage hero is implemented. Design rationale: [docs/HERO_DESIGN_DECISIONS.md](docs/HERO_DESIGN_DECISIONS.md).

## Stack

- Flutter (stable) · Material 3
- Riverpod · GoRouter · Google Fonts (Inter) · flutter_animate

## Project layout

```
lib/
  core/        # Design system, routing, shared primitives
  features/    # home · services · work · about · contact
  shared/      # Site chrome (nav, footer, page shell)
```

## Getting started

```bash
flutter pub get
flutter run -d chrome
```

```bash
flutter analyze
flutter test
```

## Brand tokens (excerpt)

| Token | Value |
|---|---|
| Background | `#FAFAF8` |
| Surface | `#FFFFFF` |
| Text | `#111111` |
| Secondary text | `#6B7280` |
| Border | `#ECECEC` |
| Accent | `#5B5FEF` |
