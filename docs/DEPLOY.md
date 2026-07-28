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

### Why builds fail on `main`

`main` must contain `pubspec.yaml` and the Flutter app. If Vercel clones an
empty / README-only commit, you will see:

```text
Expected to find project root in current working directory.
```

**Fix:** merge a feature PR into `main`, or in Vercel → Settings → Git set
**Production Branch** to a branch that has the app (e.g. `cursor/stepzero-foundation-9169`).

### Project settings

| Setting | Value |
|---|---|
| Framework Preset | Other |
| Build Command | `bash scripts/vercel-build.sh` (also in `vercel.json`) |
| Output Directory | `build/web` |
| Install Command | leave empty / ignore (Flutter installs in the build script) |
| Root Directory | `.` (repo root) |

`scripts/vercel-build.sh` clones Flutter stable, enables web, runs
`flutter pub get` and `flutter build web --release`.

`vercel.json` also sets SPA rewrites so deep links work on refresh.

### Optional analytics env vars

Add in Vercel → Settings → Environment Variables, then extend the build script
or append `--dart-define=...` flags.

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
