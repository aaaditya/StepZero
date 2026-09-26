# SEO launch checklist (manual)

Do these after the multi-page site is live on **https://thestepzero.in**. This doc is intentional: Search Console, Bing, and Google Business Profile cannot be fully verified from CI or this agent.

## 1. Google Search Console — DNS verification (GoDaddy)

1. Open [Google Search Console](https://search.google.com/search-console) → **Add property** → choose **Domain** property: `thestepzero.in` (covers apex + www).
2. Copy the TXT record Google shows (looks like `google-site-verification=…`).
3. In **GoDaddy** → Domains → `thestepzero.in` → **DNS** → Add record:
   - Type: **TXT**
   - Name/Host: `@` (or blank, per GoDaddy’s UI)
   - Value: the full verification string
   - TTL: 1 hour (or default)
4. Save. Wait for DNS propagation (often minutes; can be up to 48h).
5. In Search Console, click **Verify**. If it fails, re-check the TXT with `dig TXT thestepzero.in +short` from any terminal.
6. Prefer the **Domain** property over URL-prefix alone so `https://thestepzero.in` and any residual `www` stay covered (www should already 301 to apex).

## 2. Submit the sitemap

1. In Search Console → property `thestepzero.in` → **Sitemaps**.
2. Submit: `https://thestepzero.in/sitemap.xml`
3. Confirm it reports success (discovered URLs should include `/`, `/services/*`, `/work/*`, `/blog/*`, `/contact`, etc.).
4. Spot-check `https://thestepzero.in/robots.txt` — it should allow `/` and reference the sitemap. There should be **no** `Host:` line.

## 3. Request indexing for money pages

In Search Console → **URL inspection**, request indexing for (at least):

1. `https://thestepzero.in/`
2. `https://thestepzero.in/services/custom-saas-development`
3. `https://thestepzero.in/services/mvp-development`
4. `https://thestepzero.in/services`
5. `https://thestepzero.in/contact`
6. `https://thestepzero.in/work`
7. `https://thestepzero.in/blog/why-custom-saas-beats-no-code-patchwork`
8. `https://thestepzero.in/blog/mvp-in-90-days-without-the-bloat`

Do not spam-request every URL daily; finish the sitemap first, then prioritize commercial pages.

## 4. Bing Webmaster Tools (import from Google)

1. Open [Bing Webmaster Tools](https://www.bing.com/webmasters).
2. Add `thestepzero.in` → choose **Import from Google Search Console** when offered (fastest if GSC is already verified).
3. Confirm sitemap `https://thestepzero.in/sitemap.xml` is listed.
4. Optionally submit the same money URLs via Bing’s URL submission / IndexNow if configured on the host.

## 5. Google Business Profile (if you have a public local presence)

1. Create or claim a [Google Business Profile](https://business.google.com/) only if you have a legitimate NAP (name, address/service area, phone) you are willing to show publicly.
2. Categories: prefer **Software company** / **Website designer** / similar — align with custom software, not unrelated categories.
3. Service area: **India** (and city if `NEXT_PUBLIC_CITY` is set and accurate).
4. Website field: `https://thestepzero.in`
5. Do **not** invent a storefront address. Use service-area business if you have no client-facing office.

## 6. Directories & citations (lightweight)

Submit or update consistent NAP + website on a short list (skip spammy directories):

1. Clutch / GoodFirms (if you want agency-style leads)
2. LinkedIn Company Page → Website = `https://thestepzero.in`
3. GitHub org/user (if public) → website field
4. Relevant India startup / SaaS directories you already trust

Use the same brand string: **StepZero**, email **info@thestepzero.in**, site **https://thestepzero.in**.

## 7. Founder posting (helps entity + keywords)

Weekly cadence, not a blast:

1. LinkedIn: 1 post or comment thread on custom SaaS / MVP tradeoffs; link to a blog or service URL.
2. Short case-style notes pointing at `/work/northside-clinic` or `/work/harbor-and-oak` (label as example engagements).
3. Answer 1–2 relevant Quora/Reddit/IndieHackers questions with substance + one link when appropriate.
4. Set env socials when profiles exist: `NEXT_PUBLIC_LINKEDIN_URL`, `NEXT_PUBLIC_GITHUB_URL`, `NEXT_PUBLIC_X_URL` (JSON-LD `sameAs` only includes non-empty values).

## 8. Post-launch smoke checks

1. `curl -I https://thestepzero.in` → HTTPS, security headers present (`strict-transport-security`, `x-content-type-options`, `referrer-policy`, `x-frame-options`).
2. Open Graph: share debugger / LinkedIn post inspector on `/` and one service URL; image should resolve via `/opengraph-image`.
3. 404 page should be crawlable as soft-404 with `noindex` in metadata (confirm via view-source on a bogus path).
4. Confirm WhatsApp CTA: set `NEXT_PUBLIC_WHATSAPP_E164` on Vercel; Book buttons should be real `<a href="https://wa.me/…">` links.

## 9. Vercel env reminder

| Variable | Purpose |
| --- | --- |
| `NEXT_PUBLIC_WHATSAPP_E164` | Digits with country code; enables WhatsApp booking links |
| `NEXT_PUBLIC_GA_ID` | Optional Analytics |
| `NEXT_PUBLIC_CITY` | Optional city for contact/local SEO |
| `NEXT_PUBLIC_LINKEDIN_URL` / `GITHUB` / `X` | Optional `sameAs` profiles |
