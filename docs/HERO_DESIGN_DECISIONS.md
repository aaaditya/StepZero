# Hero Section — Design Decisions

**Scope:** Homepage hero only. No subsequent sections.

## Answers the four questions

| Question | How the hero answers |
|---|---|
| Who is StepZero? | Headline: “Every Great Business Starts at **StepZero.**” — brand as origin, not a vendor. |
| Who is it for? | Pill: “Helping Local Businesses Grow” + subhead naming branding / sites / AI / growth. |
| Why trust? | Living growth-stack dashboard (site, reviews, QR, AI, WhatsApp, metrics) + Strategy / AI / Growth micro-trust. |
| What next? | Primary: Book a Discovery Call · Secondary: View Our Work |

## Why this composition

### Full-viewport (100vh) + overlay nav
First impression owns the entire screen. Nav fades in over the canvas so the hero isn’t “content under a bar” — it is the product surface.

### 45 / 55 split
Left is editorial (read). Right is proof-of-system (feel). Slightly heavier visual column matches Linear/Vercel heroes where the product metaphor outweighs copy width.

### No stock photography
A photo of a café is interchangeable. A glassmorphism **business operating system** of overlapping cards is ownable IP and communicates transformation outcomes without a case-study library.

### Glass cards with float + hover lift
Depth and continuous micro-motion create presence (Awwwards-level polish) without loud Lottie chaos. Hover lift rewards desktop exploration.

### Off-white + dot grid + radial glow
Quiet canvas. Grid adds texture at near-threshold visibility. Accent radial sits *behind* the dashboard only — atmosphere, not decoration everywhere.

### Motion budget &lt; 1200ms
Nav → badge → staggered headline → sub → CTAs → trust → dashboard. Entrance completes inside ~1.2s so the page feels decisive, not theatrical.

### Typography
Inter w700, aggressive negative tracking, 3-line break. “StepZero.” in accent so the brand is the last beat of the sentence.

## Widget architecture

```
core/widgets/
  floating_glass_card.dart   # reusable glass + float + hover
  pill_badge.dart            # reusable editorial pill
  trust_indicator.dart       # check + label row
  hero_canvas.dart           # grid + radial glow canvas

features/home/presentation/widgets/
  hero_section.dart          # 100vh composer (desktop/tablet/mobile)
  hero_copy_column.dart      # left narrative + CTAs + trust
  hero_dashboard.dart        # right card constellation
```

CTAs reuse `AppButton` from the design system.

## Responsive

| Breakpoint | Behavior |
|---|---|
| Desktop ≥1024 | 45/55 row, full dashboard, large type |
| Tablet | Compact dashboard; narrow tablets stack |
| Mobile | Copy first, full-width CTAs, dashboard below, type 36 |

## Explicit non-goals (this pass)

- Other homepage sections
- Real analytics data wiring
- Lottie / Rive
- Dark mode
