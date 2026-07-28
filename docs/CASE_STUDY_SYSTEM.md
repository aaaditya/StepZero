# Case Study System — UX & Architecture

**Inspiration:** Stripe / Linear documentation × Apple product storytelling  
**Goal:** Prove business transformation with narrative + measurable outcomes — not a moodboard.

---

## Product principles

1. **Story before spectacle** — Images support claims; they never replace them.
2. **Operator empathy** — A clinic owner should recognize their own tension in the Challenge.
3. **Order of transformation** — Case studies mirror StepZero’s sequence (identity → presence → systems → growth).
4. **Measurable honesty** — Prefer a few hard metrics over vanity galleries.
5. **Docs-grade navigation** — Sticky TOC, deep links, calm typography (Linear/Stripe).
6. **Product-page presence** — Occasional full-bleed visual chapters (Apple) for Brand / Website / Mobile.

---

## Information architecture

### Routes

| Path | Purpose |
|---|---|
| `/work` | Index of transformations |
| `/work/:slug` | Full case study |

### Page anatomy (`/work/:slug`)

```
┌──────────────────────────────────────────────────────────┐
│ Sticky glass nav                                         │
├──────────────┬───────────────────────────────────────────┤
│ TOC (sticky) │ 01 Hero                                   │
│ desktop only │ 02 Client Overview                        │
│              │ 03 Challenge                              │
│              │ 04 Research                               │
│              │ 05 Strategy                               │
│              │ 06 Brand Identity        ← visual chapter │
│              │ 07 Website Design        ← visual chapter │
│              │ 08 Mobile Experience     ← visual chapter │
│              │ 09 Automation                             │
│              │ 10 Business Results                       │
│              │ 11 Gallery                                │
│              │ 12 Metrics                                │
│              │ 13 Client Testimonial                     │
│              │ 14 Tech Stack                             │
│              │ 15 Timeline                               │
│              │ 16 Lessons Learned                        │
│              │ 17 Next Project                           │
└──────────────┴───────────────────────────────────────────┘
```

Mobile: TOC becomes a compact “On this page” dropdown under the hero.

---

## Section design briefs

| # | Section | Job | Layout |
|---|---|---|---|
| 1 | **Hero** | Name the transformation in one breath | Full-width; industry pill; outcome line; primary metrics strip; CTA |
| 2 | **Client Overview** | Who + context | 2-col: prose + facts list (industry, location, size, engagement) |
| 3 | **Challenge** | Name the tension | Editorial callout — problem statement, not blame |
| 4 | **Research** | Show judgment | Insight cards (3–5 findings) |
| 5 | **Strategy** | The chosen order | Numbered principles tied to StepZero sequence |
| 6 | **Brand Identity** | Visual system as business asset | Apple-style chapter: narrative + palette/type/mark grid |
| 7 | **Website Design** | Trust → action | Split: decisions list + device frame |
| 8 | **Mobile Experience** | Pocket conversion | Phone cluster + flow captions |
| 9 | **Automation** | Systems that remove chaos | Capability rows (AI, WhatsApp, booking) |
| 10 | **Business Results** | Narrative of change | Before → after story, not just numbers |
| 11 | **Gallery** | Supporting evidence | Sparse, captioned, max 6 |
| 12 | **Metrics** | Proof | Large typographic counters + labels |
| 13 | **Testimonial** | Human trust | Single quote, attribution, role — no carousel |
| 14 | **Tech Stack** | Credibility for technical buyers | Quiet chip row |
| 15 | **Timeline** | How engagement felt | Horizontal (desktop) / vertical (mobile) |
| 16 | **Lessons Learned** | Intellectual honesty | 3 bullets — what we’d repeat / change |
| 17 | **Next Project** | Continue the journey | Preview card + link |

---

## Storytelling model

Every case study answers, in order:

1. Who were they?  
2. What was broken?  
3. What did we learn?  
4. What did we decide?  
5. What did we make?  
6. What changed in the business?  
7. What would we tell the next client?

---

## Visual language

- Same design tokens as homepage (Inter, `#FAFAF8`, accent `#5B5FEF`).
- Reading column ~680–720px for long prose; wider for visual chapters.
- Hairline dividers between chapters; no decorative card chrome for text.
- Metrics: oversized type, not colored chart junk.
- Gallery: captions mandatory; no lightbox-first UX.

---

## Component map

| Widget | Role |
|---|---|
| `CaseStudyHero` | Opening statement |
| `CaseStudyToc` | Sticky docs navigation |
| `CaseStudyChapter` | Labeled section shell + anchor id |
| `CaseStudyCallout` | Challenge / insight emphasis |
| `CaseStudyMetricGrid` | Animated counters |
| `CaseStudyGallery` | Captioned evidence |
| `CaseStudyTestimonial` | Single quote block |
| `CaseStudyTimeline` | Engagement phases |
| `CaseStudyNext` | Forward navigation |
| `WorkIndexCard` | Index listing |

---

## Data model (domain)

`CaseStudy` aggregates: identity, overview, challenge, research[], strategy[], brand, website, mobile, automation[], results, gallery[], metrics[], testimonial, techStack[], timeline[], lessons[], nextSlug.

Repository is in-memory for v1; swap to CMS later without touching presentation.

---

## Success criteria

- A stranger can retell the transformation after one scroll.
- Removing images still leaves a complete story.
- TOC deep-links work on web.
- Homepage “View case study” routes into this system.
