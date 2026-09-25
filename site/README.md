# StepZero site (Next.js)

Single-page marketing site. Brutal industrial layout. No Flutter.

## Local

```bash
cd site
cp .env.example .env.local
# set NEXT_PUBLIC_WHATSAPP_E164=9198XXXXXXXX
npm install
npm run dev
```

## Vercel

Set **Root Directory** to `site` in the Vercel project settings so the Next.js app is detected cleanly. Add env `NEXT_PUBLIC_WHATSAPP_E164` (digits with country code, no +).

Book Appointment opens WhatsApp (when env is set) and always starts a mailto to `info@thestepzero.in`.
