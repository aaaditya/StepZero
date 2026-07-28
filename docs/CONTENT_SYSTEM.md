# Content System — CMS-ready collections

**Inspiration:** Stripe dashboard clarity × Linear docs calm × Apple product restraint  
**Goal:** One source of truth for marketing content — swap in-memory catalogs for a CMS without touching presentation.

---

## Collections

| Collection | Route(s) | Job |
|---|---|---|
| **Projects** | `/work`, `/work/:slug` | Case studies (existing storytelling system) |
| **Services** | `/services`, `/services/:slug` | Transformation systems, not SKU menus |
| **Testimonials** | `/testimonials` | Social proof as operator voice |
| **Articles** | `/articles`, `/articles/:slug` | Insights / essays |
| **Team** | `/team` | People behind the craft |
| **FAQs** | `/faq` | Purchase-anxiety answers |
| **Pricing** | `/pricing` | Transparent engagement shapes |
| **Industries** | `/industries`, `/industries/:slug` | Category literacy |
| **Navigation** | (chrome) | Primary + utility links from config |
| **Footer** | (chrome) | Colophon columns from config |
| **Settings** | (site) | Brand CTAs, contact, newsletter, social |

---

## Architecture

```
features/content/
  domain/          # Pure models (no Flutter icons)
  data/            # In-memory catalogs (CMS swap point)
  presentation/
    providers/     # Riverpod list + bySlug
    pages/         # Public index + detail surfaces
    widgets/       # Shared content chrome
features/work/     # Projects remain their own storytelling feature
shared/layout/     # PageShell reads Navigation + Footer from Settings
```

### Principles

1. **Catalogs own copy** — homepage teasers and full pages read the same providers.
2. **Settings own chrome** — nav labels, CTA, footer columns, socials never hardcode in widgets.
3. **Slug-first URLs** — every detail page is deep-linkable.
4. **Story over inventory** — list pages lead with transformation language, not card dumps.

---

## Settings model

`SiteSettings` aggregates:

- Brand display name / tagline / mission
- Primary CTA label + path
- Contact email / discovery CTA
- Newsletter enabled + blurb
- Social links
- `NavigationConfig` (primary items)
- `FooterConfig` (columns + legal)

---

## Success criteria

- Changing a FAQ in the catalog updates homepage + `/faq`.
- Changing primary nav in settings updates glass bar + mobile sheet.
- Adding a service requires catalog entry only — page grid renders it.
- `flutter analyze` / tests stay green.
