# Deployment guide

Build once, deploy the `build/web` artifact to any static host.

```bash
flutter pub get
flutter build web --release
# optional analytics defines — see README
```

Flutter copies everything under `web/` into `build/web`, including `_redirects` and `_headers`.

---

## Firebase Hosting

```bash
npm i -g firebase-tools
firebase login
# edit .firebaserc project id
flutter build web --release
firebase deploy --only hosting
```

Config: `firebase.json` (SPA rewrite + cache/security headers).

---

## Cloudflare Pages

1. Connect the repo.
2. Build command: install Flutter in CI, then `flutter build web --release`.
3. Output directory: `build/web`.
4. SPA: `web/_redirects` (`/* /index.html 200`).

See `cloudflare-pages.md`.

---

## Vercel

1. Build in CI (or a custom install script that installs Flutter).
2. Output: `build/web`.
3. `vercel.json` provides SPA rewrites + cache headers.

If using Vercel’s UI only, set **Output Directory** to `build/web` after a CI artifact upload, or use a Docker/Flutter install build step.

---

## Netlify

`netlify.toml`:

- Build: `flutter build web --release` (ensure Flutter is on the image / plugin)
- Publish: `build/web`
- SPA: `/* → /index.html` 200
- Security + cache headers included

---

## GitHub Pages

Workflow: `.github/workflows/deploy-github-pages.yml`

- Builds with `--base-href "/<repo>/"` for project pages.
- For a custom domain / user site (`username.github.io`), change base-href to `/`.

Enable **Pages → GitHub Actions** in repo settings.

---

## Checklist after deploy

- [ ] `/` loads with correct title / OG tags (View Source)
- [ ] Deep link `/work/<slug>` works on hard refresh
- [ ] `robots.txt` and `sitemap.xml` reachable
- [ ] `manifest.json` + icons load
- [ ] Contact form submits (mock or live)
- [ ] Lighthouse: Performance / Accessibility / SEO ≥ target

---

## Security headers

All host configs aim for:

- `X-Frame-Options: SAMEORIGIN`
- `X-Content-Type-Options: nosniff`
- `Referrer-Policy: strict-origin-when-cross-origin`
- `Permissions-Policy` camera/mic/geo disabled
- Short cache on `index.html`, long cache on hashed assets
