# Motion System

Premium motion language for StepZero — Linear / Framer / Apple restraint.

**Principles:** elegant · minimal · purposeful · 60 FPS · reduced-motion aware.

Layouts are not redesigned here — motion elevates existing surfaces.

---

## Tokens

### Durations (`AppDurations`)

| Token | ms | Use |
|---|---|---|
| `instant` | 100 | Press scale, focus flicker |
| `fast` | 180 | Hover color / lift |
| `normal` | 280 | Card morph, default UI |
| `slow` | 420 | Section reveal |
| `dramatic` | 700 | Hero entrances |
| `ambient` | 4200 | Float / pulse loops |
| `magnetic` | 220 | Pointer follow catch-up |
| `indicator` | 320 | Nav underline |
| `counter` | 1200 | Metric count-up |
| `stagger` | 80 | Sibling reveal delay |
| `staggerTight` | 48 | Headline line stagger |
| `page` / `pageReverse` | 320 / 240 | Route transitions |

### Curves (`AppCurves`)

| Token | Curve | Use |
|---|---|---|
| `standard` | easeOutCubic | Default UI |
| `enter` | easeOutQuart | Reveals settle |
| `exit` | easeInCubic | Departures |
| `hover` | easeOut | Pointer feedback |
| `emphasis` | easeOutExpo | Hero |
| `page` | easeInOutCubic | Routes |
| `ambient` | easeInOutSine | Loops |
| `magnetic` | easeOutCubic | Magnetic CTA |
| `indicator` | easeInOutCubic | Nav underline |

---

## Primitives (`lib/core/animations/`)

| Widget / API | Job |
|---|---|
| `Reveal` / `StaggeredReveal` / `FadeUp` / `FadeScale` | Scroll / mount entrance |
| `LazySection` | Lazy reveal (build when near viewport) |
| `Magnetic` | Desktop CTA pointer attraction |
| `SoftPulse` | Soft ambient glow pulse |
| `PressableScale` | Button press feedback |
| `ParallaxLayer` | Scroll + pointer depth |
| `DriftingGradient` | Slow atmospheric gradient |
| `HoverScale` / `HoverOpacity` / `CursorAwareHover` | Desktop hover |
| `NavUnderline` | Active nav indicator |
| `MotionSkeleton` / `ProgressiveReveal` | Loading / progressive media |
| `ExpandableSurfaceCard` / `HoverZoomMedia` | Card lift, tilt, glow, zoom |
| `FloatingGlassCard` | Continuous float (reduced-motion safe) |
| `AnimatedCounter` | Metric count-up |
| `AppButton` (`magnetic`, `pulse`) | CTA glow + magnetic + press |

`MotionAccessibility.reduceMotion(context)` gates continuous / pointer motion.

---

## Surface choreography

| Surface | Motion |
|---|---|
| **Splash** | Logo breathe + wordmark rise → fade on `flutter-first-frame` |
| **Navbar** | Transparent → glass blur; shrink height; underline indicator; CTA magnetic + pulse |
| **Hero** | Staggered copy; floating glass cards; parallax glow + pointer; magnetic primary CTA |
| **Timeline** | Staggered nodes; selected milestone glow |
| **Service cards** | Elevation, tilt, accent border, soft glow |
| **Case studies** | Hover zoom media; counters; lift |
| **Final CTA** | Drifting gradient; magnetic + pulse primary |
| **Routes** | Fade + micro-slide (`AppCurves.page`) |

---

## Performance rules

1. Prefer one shared controller per ambient loop — dispose on unmount.
2. No bounce / spring for marketing chrome.
3. Cap transforms to translate / scale / opacity / tiny rotate.
4. Never animate layout size for text blocks when CLS-sensitive.
5. Always branch on `MediaQuery.disableAnimationsOf`.

---

## Usage

```dart
AppButton(
  label: 'Book a Discovery Call',
  magnetic: true,
  pulse: true,
  onPressed: ...,
);

ParallaxLayer(
  scrollFactor: 0.08,
  pointerFactor: 12,
  child: dashboard,
);

ExpandableSurfaceCard(
  enableTilt: true,
  glowOnHover: true,
  child: ...,
);
```
