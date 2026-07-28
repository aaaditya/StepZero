# Enterprise audit — Apple-grade weaknesses & remediations

Senior review notes for the StepZero marketing site. Weaknesses listed first;
remediations shipped in the enterprise upgrade unless marked **deferred**.

## Product feel

| Weakness | Fix |
|---|---|
| Contact was a stub — premium studios never dead-end intent | Production form: validation, honeypot, loading/success/error, mailto fallback |
| Inert footer socials / newsletter | ExternalLink + validated newsletter with success state |
| Hero dashboard overflow on small phones | LayoutBuilder + FittedBox + RepaintBoundary |
| Featured Work duplicated case study data | Reads `caseStudiesProvider` (catalog SSOT) |
| Emoji in hero pill felt consumer/app-store | Replaced with intentional icon |
| Final CTA caption low contrast on dark wash | Raised opacity for AA-ish readability |
| Touch targets under 48px on nav/footer | `AppLayout.minTouchTarget` constraints |

## Engineering

| Weakness | Fix |
|---|---|
| Magic layout numbers | `AppLayout` constants |
| Brand URL duplicated | `BrandDefaults` aliases `Brand` |
| No analytics architecture | Pluggable composite + dart-define config |
| No deploy adapters | Firebase / Vercel / Netlify / Cloudflare / GH Pages |
| Stale README / architecture docs | Rewritten + SETUP / DEPLOY / CONTRIBUTING / ROADMAP |
| Unguarded slugs | `AppRoutes.sanitizeSlug` |

## Deferred (intentional)

- Live CRM/email backend (mock ready to swap)
- Real social `sameAs` profiles
- Full visual regression suite
- Service worker aggressive caching (Flutter web nuance)
