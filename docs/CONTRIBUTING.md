# Contributing

## Mindset

Treat this as a **production premium agency site**. Prefer restraint, clarity, and maintainability over novelty.

## Branching

- Branch from `main`
- Name: `cursor/<short-description>` or `feat/<short-description>`
- Open a PR; keep description focused on user-visible impact

## Code standards

1. **Feature-first** — new UI goes in the owning feature, not `core/` unless reused ≥ 2 features.
2. **Tokens over magic numbers** — use `AppColors`, `AppSpacing`, `AppLayout`, `AppDurations`.
3. **Const** — prefer `const` constructors; avoid needless rebuilds.
4. **Accessibility** — semantics labels, ≥ 48px targets, focus rings, respect `disableAnimations`.
5. **No hardcoded secrets** — analytics via `--dart-define`.
6. **Catalogs for copy** — marketing content belongs in content/work catalogs.
7. **Document** reusable widgets with dartdoc (`///`).

## PR checklist

- [ ] `flutter analyze` clean
- [ ] `flutter test` green
- [ ] Responsive check: 1440 / 1024 / 768 / 390 / 320
- [ ] Keyboard + screen reader spot-check on touched flows
- [ ] SEO path added to sitemap / `SeoController` if new route
- [ ] No brand identity drift (tokens + existing visual language)

## Commit messages

Imperative, descriptive:

```
Elevate contact form with production validation and analytics hooks
```

## Design language

Do **not** restyle the brand. Extend existing patterns (glass nav, soft surfaces, Inter, accent `#5B5FEF`, warm off-white canvas).
