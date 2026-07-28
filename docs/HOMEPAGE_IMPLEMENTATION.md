# Homepage Implementation Notes

Production homepage composed from design-system primitives only.

## Stack

Flutter · Material 3 · Riverpod · GoRouter · Flutter Animate · Google Fonts (Inter)

## Chrome

| Piece | Implementation |
|---|---|
| Sticky glass navbar | `GlassAppBar` — blur + opacity elevates after scroll |
| Smooth scrolling | `AppScrollBehavior` + bouncing physics on `PageShell` |
| Footer | `AppFooter` in `PageShell` |

## Section modules (`features/home/presentation/widgets/`)

1. `HeroSection`
2. `TransformationSection`
3. `HowWeTransformSection`
4. `FeaturedWorkSection`
5. `IndustriesSection`
6. `WhyStepZeroSection`
7. `ProcessSection`
8. `InsightsSection`
9. `FaqSection`
10. `FinalCtaSection`

## Design-system primitives used

`SectionHeader` · `SectionContainer` · `SectionLandmark` · `Reveal` / `StaggeredReveal` · `ExpandableSurfaceCard` · `FloatingGlassCard` · `AnimatedCounter` · `AppButton` · `PillBadge` · `TrustIndicator` · `HeroCanvas` · `AppTextField` · `GlassAppBar`

## Motion

- Fade / slide via `Reveal` (honors reduced motion)
- Floating glass cards (hero dashboard)
- Staggered section entrances
- Metric counters (`AnimatedCounter`)
- Hover elevation (`ExpandableSurfaceCard`, case studies)
- Process line draw + sticky nav elevation

## Accessibility (WCAG AA targets)

- Semantic landmarks per section
- Header semantics on section titles
- Buttons expose `Semantics(button: …)`
- Focus rings on `AppButton`
- Contrast: primary `#111` / secondary `#6B7280` on `#FAFAF8`
- `MediaQuery.disableAnimations` short-circuits motion
- Labeled nav, menu, newsletter, social links

## Rebuild hygiene

- `const` constructors on section roots and static content
- Scroll-aware nav state isolated in `PageShell`
- Feature sections are leaf composers — no global setState
