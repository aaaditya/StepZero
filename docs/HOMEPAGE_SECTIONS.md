# Homepage Sections — UX & Architecture

Continuing the Hero’s visual language: off-white canvas, Inter, accent `#5B5FEF`, glass/surface cards, restrained motion, huge whitespace.

Each section is treated as an **independent premium product surface**, then composed on `HomePage`. Footer lives in `PageShell`.

---

## Shared primitives

| Widget | Role |
|---|---|
| `SectionHeader` | Eyebrow + title + subtitle (+ optional action) |
| `SectionContainer` / `MaxWidthBox` | Gutters, max width, optional band color |
| `ExpandableSurfaceCard` | Hover lift + scale for interactive cards |
| `AppButton` (+ `onDark`) | CTA consistency on light/dark bands |

---

## 1 — Business Transformation

**UX**  
Teaches order. Owners buy out of sequence; this section re-educates through an interactive spine.

**Layout** Desktop: timeline 5 / detail panel 4. Mobile: panel above, timeline below.  
**Grid** Single narrative column + sticky-feeling detail.  
**Spacing** Section 120 / 80 / 64; node vertical `md`.  
**Type** Section H ~48; node titles 18; panel title fluid 36→26.  
**Motion** Staggered node fade-up; panel `AnimatedSwitcher`; node glow on select.  
**Responsive** Split → stack.  
**Hierarchy** `TransformationSection` → `_Timeline` → `_TimelineNode` → `_ActivePanel` → `_JourneyIllustration`

---

## 2 — What We Build

**UX** Outcomes over SKUs. Four systems that together make a premium business.

**Layout** 2×2 editorial cards on muted band.  
**Grid** Wrap, 2-col desktop/tablet, 1-col mobile.  
**Spacing** Card gap `lg`; inner `xl` → `xxl` on hover.  
**Type** Card title 28; body 16.  
**Motion** Stagger entrance; hover expand via `ExpandableSurfaceCard`.  
**Hierarchy** `WhatWeBuildSection` → `_BuildCard`

---

## 3 — Featured Transformations

**UX** Trailer-quality case stories. Problem → Solution → Results + metrics + device cluster.

**Layout** Large horizontal case surfaces (not tile grids). Alternating copy/mockup.  
**Grid** 45/55 split; stack on mobile.  
**Spacing** Case padding `xxl`; gap between cases `xxl`.  
**Type** Name fluid 36→26; labels caption uppercase.  
**Motion** Card fade-up; mockups shift on hover.  
**Hierarchy** `FeaturedWorkSection` → `_CaseStudyCard` → `_CaseCopy` + `_DeviceCluster` (`_LaptopMock`, `_PhoneMock`)

---

## 4 — Industries

**UX** Instant category belonging with one insight line each.

**Layout** 4-col premium card grid (2 tablet / 1 mobile).  
**Spacing** Gap `md`; card padding `lg`.  
**Type** Name 18; insight caption.  
**Motion** Stagger + hover lift. Minimal icons only.  
**Hierarchy** `IndustriesSection` → `_IndustryCard`

---

## 5 — Why StepZero

**UX** Differentiation by contrast, not slogans.

**Layout** Comparison table-as-cards: Typical (struck) vs StepZero.  
**Spacing** Row padding `xl`/`lg`; centered header max 1100.  
**Type** Body 17; StepZero side semibold.  
**Motion** Row hover tint; staggered fade.  
**Hierarchy** `WhyStepZeroSection` → `_ComparisonRow`

---

## 6 — Process

**UX** Purchase-fear killer: named stages, durations, clear path.

**Layout** Horizontal numbered sequence + detail drawer. Animated accent line.  
**Spacing** Detail panel `xl`; node gaps via Expanded.  
**Type** Titles 15– bodyStrong; detail heading S.  
**Motion** Line draw 1100ms; node stagger; detail switch.  
**Responsive** Vertical list on mobile.  
**Hierarchy** `ProcessSection` → `_DesktopProcess` / `_MobileProcess` → `_ProcessNode` + `_ProcessDetail`

---

## 7 — Insights

**UX** Trust via POV. Magazine: one featured + latest stack.

**Layout** 7/5 split desktop; stack mobile.  
**Spacing** Featured radius `xxl`; rows `lg`.  
**Type** Featured title 26; rows 16.  
**Motion** Featured lift; gradient intensifies on hover.  
**Hierarchy** `InsightsSection` → `_FeaturedInsightCard` + `_InsightRow`

---

## 8 — FAQ

**UX** Straight answers; one open at a time.

**Layout** Narrow column max 800; accordion tiles.  
**Spacing** Tile gap `sm`; padding `xl`/`lg`.  
**Type** Question 17 strong; answer 16.  
**Motion** Cross-fade answer; `+` rotates to `×`.  
**Hierarchy** `FaqSection` → `_FaqTile`

---

## 9 — Final CTA

**UX** Inevitable close: leave Step Zero → book or see work.

**Layout** Centered dark gradient panel inside section.  
**Spacing** Vertical `section` / `xxxl`; text max 520.  
**Type** Fluid 56→32 inverse.  
**Motion** Block fade-up. Primary accent + `onDark` secondary.  
**Hierarchy** `FinalCtaSection`

---

## 10 — Footer

**UX** Colophon, not sitemap dump. Large wordmark as brand gravity.

**Layout** Giant logo → 3 columns (Navigate / Contact / Newsletter) → legal + social.  
**Spacing** Section Y; column stack on mobile.  
**Type** Logo up to 72; utility caption labels.  
**Motion** Link hover opacity only.  
**Hierarchy** `AppFooter` → `_FooterNav` / `_FooterContact` / `_FooterNewsletter` / `_SocialLinks`

---

## Compose order

```
Hero → Transformation → What We Build → Featured Work → Industries
→ Why StepZero → Process → Insights → FAQ → Final CTA → Footer
```

Conversation arc: belief → sequence → capabilities → proof → fit → difference → path → thinking → objections → ask → exit.
