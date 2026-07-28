# Roadmap

## Near-term

- [ ] Wire `ContactRepository` to Formspree / custom API / CRM
- [ ] Production newsletter backend (double opt-in)
- [ ] Real social profile URLs + `sameAs` in JSON-LD
- [ ] CMS adapter (Contentful / Sanity / Notion) behind existing catalogs
- [ ] Playwright / integration smoke for critical paths
- [ ] Lighthouse CI budget in GitHub Actions

## Product

- [ ] Blog article MDX/markdown pipeline (keep Flutter reader)
- [ ] Localized copy (EN first, then regional)
- [ ] Client portal teaser / gated case metrics
- [ ] Booking calendar embed (Cal.com) behind feature flag

## Platform

- [ ] Service worker caching strategy (carefully — Flutter web)
- [ ] Image CDN for future photography (still prefer art-directed assets)
- [ ] Error monitoring (Sentry) via dart-define DSN
- [ ] A/B experiment hooks on primary CTA

## Quality bar

Remain Apple-grade: calm motion, zero overflow at 320px, WCAG AA contrast,
predictable architecture, deployable to any static host in one command.
