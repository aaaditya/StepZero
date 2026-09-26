# StepZero site (Next.js)

Marketing site at the **repo root** (Next.js App Router). Visual direction: **Utility modern** (paper background, deep teal accent, Source Serif 4 + IBM Plex Sans).

Multi-page SEO structure: home, services (incl. custom SaaS / MVP / automation / websites), work, products, about, contact, blog, terms, privacy. Shared `SiteHeader` + `SiteFooter`.

## Local

```bash
cp .env.example .env.local
# set NEXT_PUBLIC_WHATSAPP_E164=9198XXXXXXXX
# optional: NEXT_PUBLIC_GA_ID, NEXT_PUBLIC_CITY, social URLs
npm install
npm run dev
```

## Vercel env

| Variable | Required | Purpose |
| --- | --- | --- |
| `NEXT_PUBLIC_WHATSAPP_E164` | Recommended | Digits with country code. Book CTAs become `wa.me` links. |
| `NEXT_PUBLIC_GA_ID` | Optional | Google Analytics |
| `NEXT_PUBLIC_CITY` | Optional | City for contact / local SEO |
| `NEXT_PUBLIC_LINKEDIN_URL` | Optional | JSON-LD `sameAs` |
| `NEXT_PUBLIC_GITHUB_URL` | Optional | JSON-LD `sameAs` |
| `NEXT_PUBLIC_X_URL` | Optional | JSON-LD `sameAs` |

## SEO

- Config: `src/lib/site.ts`
- `robots.ts`, `sitemap.ts` (all routes, fixed dates)
- `opengraph-image.tsx` (1200×630)
- JSON-LD with logo/image, Country `areaServed`, India address
- Security headers in `next.config.ts`
- Manual launch steps: `docs/SEO_LAUNCH.md`
