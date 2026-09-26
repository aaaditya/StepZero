# StepZero site (Next.js)

Marketing site lives at the **repo root** (hoisted from `site/`) so Vercel detects `next` in `package.json` without a Root Directory override.

Visual direction: **Utility modern** (paper background, deep teal accent, Source Serif 4 + IBM Plex Sans). Single page with Book Appointment, intake demo, Terms, and Privacy.

## Local

```bash
cp .env.example .env.local
# set NEXT_PUBLIC_WHATSAPP_E164=9198XXXXXXXX
npm install
npm run dev
```

## Vercel

Deploy from the repository root. Add env `NEXT_PUBLIC_WHATSAPP_E164` (digits with country code, no +).

Book Appointment opens WhatsApp (when env is set) and always starts a mailto to `info@thestepzero.in`.
