# StepZero site (Next.js)

Marketing site lives at the **repo root** (hoisted from `site/`) so Vercel detects `next` in `package.json` without a Root Directory override.

Visual direction: **Utility modern** (paper background, deep teal accent, Source Serif 4 + IBM Plex Sans). Single page with Book Appointment, intake demo, Terms, and Privacy.

## Local

```bash
cp .env.example .env.local
# set NEXT_PUBLIC_WHATSAPP_E164=9198XXXXXXXX
# optional: NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX
npm install
npm run dev
```

## Vercel

Deploy from the repository root. Env vars:

| Variable | Required | Purpose |
| --- | --- | --- |
| `NEXT_PUBLIC_WHATSAPP_E164` | Recommended | Digits with country code, no `+`. Enables WhatsApp on Book Appointment. |
| `NEXT_PUBLIC_GA_ID` | Optional | Google Analytics measurement ID. Analytics scripts load only when set. |

Book Appointment opens WhatsApp (when env is set) and always starts a mailto to `info@thestepzero.in`.

## CDN / static assets

Hosted on **Vercel**, which serves `/_next/static/*`, optimized `next/image` output, and `public/` files from the edge CDN. No separate CDN config is required for SEO Site Checkup “use a CDN” checks — asset URLs on `thestepzero.in` are already CDN-backed.

## SEO surfaces

- `src/app/robots.ts` → `/robots.txt`
- `src/app/sitemap.ts` → `/sitemap.xml`
- JSON-LD Organization + WebSite + ProfessionalService in the root layout
- Custom `src/app/not-found.tsx` (404)
