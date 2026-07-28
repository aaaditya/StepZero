# StepZero Homepage — UX Blueprint & Wireframe

**Role:** Senior UX Architect / Product Designer  
**Scope:** Information architecture + section wireframes only  
**Out of scope:** Flutter UI, visual polish, component code  

**Emotional north star:**  
> When a visitor lands, they should think:  
> *"These people understand business."* → *"I trust them."* → *"I want to work with them."*

The homepage is a **conversation**, not a brochure. Each section answers one unspoken question, then earns the right to ask for the next minute of attention.

---

## Document map

1. [Global experience principles](#1-global-experience-principles)
2. [Information architecture](#2-information-architecture)
3. [User journey (section-by-section)](#3-user-journey-section-by-section)
4. [Full-page wireframe (desktop)](#4-full-page-wireframe-desktop)
5. [Responsive wireframe notes](#5-responsive-wireframe-notes)
6. [Content inventory checklist](#6-content-inventory-checklist)
7. [Success criteria](#7-success-criteria)

---

## 1. Global experience principles

### Conversation model

| Scroll depth | Visitor’s inner question | Homepage’s answer |
|---|---|---|
| 0–20% | Who are these people? | Brand + point of view |
| 20–40% | Do they get my world? | Philosophy + outcomes |
| 40–65% | Can they prove it? | Work + industries + process |
| 65–85% | Why them, not someone else? | Differentiation + proof substitutes |
| 85–100% | What do I do now? | Soft close → clear CTA |

### Layout rules (site-wide)

- **One job per section.** One headline. One supporting sentence. Then content.
- **Huge whitespace.** Prefer 120px section padding on desktop; never crowd.
- **Editorial typography.** Hierarchy does the selling; icons do not.
- **No decorative cards** unless the card is an interactive container (work piece, insight link).
- **Desktop-first**, intentional collapse on tablet/mobile — not a shrunk desktop.
- **Motion is presence**, not noise: fade-up 12–20px, soft opacity, staggered reveals.

### Brand voice on page

- Speak like a partner who has sat in the owner’s chair.
- Avoid agency jargon (“synergy”, “full-funnel”, “best-in-class”).
- Prefer verbs of transformation: *become, compound, earn trust, scale*.

---

## 2. Information architecture

### Primary navigation (sticky)

```
[ StepZero ]     Services   Work   Process   Insights   About   Contact     [ Start a project ]
```

| Item | Exists because… |
|---|---|
| **Logo** | Instant brand recognition; home escape hatch; trust anchor in every viewport. |
| **Services** | Answers “what do you actually do?” without forcing a full scroll. |
| **Work** | Proof-seeking visitors skip straight to evidence. |
| **Process** | Risk-averse owners (clinics, real estate, retail) buy *how* before *what*. |
| **Insights** | Positions StepZero as a thinking partner, not a vendor; SEO + trust over time. |
| **About** | Humans buy from humans; philosophy and standards live here. |
| **Contact** | Low-friction path for ready buyers who already decided. |
| **Primary CTA** (“Start a project”) | Conversion always visible; removes hunting for next step. |

**Nav psychology:** Minimal item count signals confidence. Sticky behavior says “we’re still with you” without shouting.

**Not in nav:** Pricing (too early, too varied), Blog-as-word (use Insights), Testimonials (earned later in scroll).

### Page section sequence (canonical)

```
01  Navigation (persistent)
02  Hero
03  Trust (new-agency proof system)
04  Business Transformation (philosophy spine)
05  Services as Outcomes
06  Featured Work
07  Industries
08  Process
09  Why StepZero
10  Social Proof Alternatives (until testimonials exist)
11  Insights
12  Final CTA
13  Footer
```

### Sitemap (homepage-adjacent)

```
Home
├── Services (detail / outcome pages later)
├── Work (index + case studies)
├── Process (can be deep-link to homepage section or dedicated page)
├── Insights (articles / notes)
├── About
└── Contact / Start a project
```

Homepage sections may deep-link (`#process`, `#work`) while dedicated pages exist for SEO depth.

---

## 3. User journey (section-by-section)

---

### 01 — Navigation

**Purpose**  
Orient, reduce anxiety, keep conversion one click away.

**User psychology**  
Visitors scan for familiarity first. A calm, sparse nav reads as premium. Overstuffed navs read as desperate.

**Recommended layout**  
- Full-width bar, ~72px tall, translucent warm background (`#FAFAF8` @ ~92%), 1px bottom border.  
- Left: wordmark. Center-right: text links. Far right: primary CTA button.  
- Mobile: wordmark + menu trigger; sheet/drawer with same items + full-width CTA.

**Content hierarchy**  
1. Brand name  
2. Section links  
3. Primary CTA label

**Visual hierarchy**  
Wordmark slightly heavier than links; CTA is the only filled accent element in the chrome.

**Spacing**  
Link gap 24–32px. CTA separated by ≥32px from last link. Horizontal gutter matches page (64 / 32 / 16).

**Desktop** Sticky; links visible; CTA always shown.  
**Tablet** Sticky; may compress link spacing; keep CTA.  
**Mobile** Sticky; hamburger / sheet; CTA inside sheet + optional compact CTA in bar if space allows.

**Animation**  
Bar gains subtle border/shadow after 8–16px scroll. Link hover: opacity or color shift only — no underlines that feel retail.

---

### 02 — Hero

**Purpose**  
Establish brand gravity and the thesis in one breath. First viewport = one composition.

**Emotional goal**  
Confidence without arrogance. “You’re in capable hands.”

**Problem it solves**  
Local business owners feel stuck between freelancers (cheap, chaotic) and big agencies (expensive, impersonal). Hero names the gap and claims it.

**Recommended copy direction**

| Element | Recommendation |
|---|---|
| **Brand** | **StepZero** as hero-level signal (not an eyebrow chip). |
| **Headline** | *We build businesses people trust.* |
| **Subheadline** | Helping local businesses become premium brands — through strategy, branding, websites, AI automation, and growth. |
| **Primary CTA** | Start a project |
| **Secondary CTA** | See our process *(or See the work)* |

**Why this headline**  
It sells the outcome (trust), not the deliverable (websites). It matches the brand manifesto.

**Visual direction**  
- Full-bleed atmospheric visual plane (edge-to-edge): real business context — a refined café interior, salon at golden hour, clinic reception with quiet luxury — **not** abstract gradients, stock handshakes, or floating device mockups as the main idea.  
- Typography sits in a clear left (or center-left) reading column; image is the dominant plane, not an inset card.  
- **No** floating badges, promo stickers, stat pills, or overlays on the hero media.  
- Hero budget only: brand, one headline, one short supporting sentence, one CTA group, one dominant visual.

**Layout (desktop)**  
```
┌─────────────────────────────────────────────────────────────┐
│  [Nav]                                                      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   StepZero                                                  │
│                                                             │
│   We build businesses                                       │
│   people trust.                                             │
│                                                             │
│   Helping local businesses become premium brands…           │
│                                                             │
│   [ Start a project ]    See our process →                  │
│                                                             │
│              ══════════ full-bleed visual plane ══════════  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```
Preferred: text over / within a full-bleed photographic field with restrained gradient scrim **only for legibility**, not as decoration.

**Content hierarchy**  
Brand → Headline → Subhead → CTAs → Visual atmosphere

**Visual hierarchy**  
Headline is large but must not overpower the brand wordmark. Subhead in secondary text color. Primary CTA accent; secondary is text link.

**Spacing**  
Top: generous (80–120px below nav). Stack gaps: 16–24 between brand and headline; 24–32 headline→sub; 32–40 sub→CTAs. Bottom of hero: enough air before next section (80–120px).

**Desktop** ~90–100vh composition; max text width ~560–640px.  
**Tablet** Headline scales (~56); visual remains full-bleed; CTAs stack if needed.  
**Mobile** Brand + headline + sub + CTAs first; visual remains full-bleed below or as background with stronger scrim; no side-by-side split that creates a “card.”

**Animation**  
1. Brand fades in.  
2. Headline fades/rises 16px.  
3. Sub + CTAs follow (+80ms stagger).  
4. Optional ultra-slow ken-burns on photo (scale 1.0→1.04 over 12s) — barely perceptible.

---

### 03 — Trust Section (new agency, no logo wall)

**Purpose**  
Earn credibility without pretending we have Fortune-500 logos we don’t have.

**User psychology**  
Fake logo walls destroy trust. Smart buyers smell vapor. New studios must prove **judgment, standards, and specificity**.

**Better trust builders (use 2–3, not all)**

| Mechanism | Why it works |
|---|---|
| **Point-of-view strip** | 3 short convictions (“We don’t sell websites.” / “Brand before traffic.” / “Automation after clarity.”) — shows spine. |
| **Standards, not clients** | “Every engagement starts with diagnosis.” / “We take limited projects per quarter.” — scarcity + rigor. |
| **Founder / operator signal** | One line of relevant lived context (operator mindset, local commerce focus) — human, not résumé dump. |
| **Outcome framing metrics (honest)** | Prefer process metrics over vanity: “12-week brand systems”, “Single source of truth for every asset” — only if true. |
| **Target-world specificity** | Name the businesses we serve (restaurants, clinics…) as *domain literacy*, not a client list. |

**Avoid:** Greyed fake logos, “Trusted by” with no names, 500+ projects inflated counts, generic award badges.

**Recommended layout**  
Horizontal conviction row (desktop) or stacked statements (mobile). Optional thin divider above/below. No cards.

```
────────────────────────────────────────────────────────
  We don’t sell websites.     Brand before traffic.     Limited projects / quarter.
────────────────────────────────────────────────────────
```

**Content hierarchy**  
Optional micro-label (“How we work”) → 3 convictions → optional one-line proof of focus.

**Visual hierarchy**  
Equal-weight statements; typography does the work. Accent used sparingly (e.g., one word or the middle period).

**Spacing**  
Compact section (64–80px vertical) — a breath, not a chapter. Item gaps 32–48px desktop.

**Desktop** 3 columns, hairline separators optional.  
**Tablet** 3 columns compressed or 2+1 wrap.  
**Mobile** Vertical stack, left-aligned, generous leading.

**Animation**  
Simultaneous soft fade; no counting animations.

---

### 04 — Business Transformation Section

**Purpose**  
Teach the StepZero philosophy: transformation is a sequence, not a shopping list.

**User psychology**  
Owners often buy out of order (website before brand, ads before offer). This section re-educates gently and positions StepZero as the guide who knows the order.

**Philosophy spine**

```
No Identity
    ↓
Brand
    ↓
Website
    ↓
Automation
    ↓
Growth
    ↓
Scale
```

**Narrative**  
Businesses don’t fail from lack of tools. They stall from lack of **identity clarity**. StepZero starts at zero — the step before the first public move — and compounds upward.

**Visual presentation (recommended)**  
**Vertical editorial spine** (not a cheesy funnel infographic):

```
┌──────────────────────────────────────────────┐
│  Business starts here.                       │
│  A short paragraph on identity → scale.      │
│                                              │
│   ○  No Identity     ← quiet, muted          │
│   │                                          │
│   ●  Brand           ← first solid node      │
│   │                                          │
│   ●  Website                                 │
│   │                                          │
│   ●  Automation                              │
│   │                                          │
│   ●  Growth                                  │
│   │                                          │
│   ●  Scale           ← strongest weight      │
│                                              │
│   Active node expands a one-line definition  │
│   on the right (desktop) / below (mobile).   │
└──────────────────────────────────────────────┘
```

- Desktop: spine left (~40%), definition panel right (~60%).  
- Hover/focus a node → definition updates (conversation, not dump-all).  
- Mobile: vertical stepper; tap to expand one definition at a time (accordion without looking like Bootstrap).

**Content hierarchy**  
Section title → one thesis sentence → interactive spine → per-stage one-liner.

**Suggested stage one-liners (draft)**

| Stage | One-liner |
|---|---|
| No Identity | Unclear offer, inconsistent presence, trust leaks. |
| Brand | Positioning, voice, visual system — the reason to choose you. |
| Website | A premium digital storefront that converts trust into action. |
| Automation | AI + systems that remove busywork without removing the human. |
| Growth | Acquisition that compounds because the brand can hold it. |
| Scale | Repeatable excellence across locations, offers, or teams. |

**Visual hierarchy**  
Title strong; spine is the hero of the section; definitions quieter. Accent marks only the active node.

**Spacing**  
Section Y 120px. Spine node spacing 28–36px. Definition max-width ~420px.

**Desktop** Split spine + definition; sticky definition while scrolling the spine optional.  
**Tablet** Same split with tighter columns.  
**Mobile** Single column stepper.

**Animation**  
Active node crossfade; line draw optional once on enter (once, subtle). Avoid perpetual looping.

---

### 05 — Services (as business outcomes)

**Purpose**  
Translate capabilities into outcomes owners care about. Do **not** list service SKUs.

**User psychology**  
Owners don’t wake up wanting “a logo package.” They wake up wanting more bookings, higher ticket size, less chaos, a brand that feels expensive.

**Outcome groups (recommended)**

| Outcome group | What it means | Underlying capabilities (never primary labels) |
|---|---|---|
| **Become unmistakable** | Category position + identity system so you’re not “another café/clinic.” | Brand strategy, naming (if needed), visual identity, voice |
| **Look premium online** | Digital presence that matches the quality of the business in real life. | Website, UX, photography direction, conversion paths |
| **Run smoother** | Operations that don’t depend on the owner remembering everything. | AI automation, booking/CRM flows, internal tools |
| **Grow on purpose** | Demand generation that fits the brand — not random ads. | Content, funnels, local SEO, campaigns, retention |

**Layout**  
Four editorial blocks in a 2×2 grid (desktop), not icon grids.

```
┌─────────────────────┐  ┌─────────────────────┐
│  01                 │  │  02                 │
│  Become             │  │  Look premium       │
│  unmistakable       │  │  online             │
│  Short paragraph…   │  │  Short paragraph…   │
│  Learn more →       │  │  Learn more →       │
└─────────────────────┘  └─────────────────────┘
┌─────────────────────┐  ┌─────────────────────┐
│  03                 │  │  04                 │
│  Run smoother       │  │  Grow on purpose    │
│  …                  │  │  …                  │
└─────────────────────┘  └─────────────────────┘
```

Borders optional as hairlines; prefer whitespace separation over card chrome. “Learn more” links to Services page anchors.

**Content hierarchy**  
Section label → headline (“What changes when we work together”) → outcome title → 2–3 line body → text link.

**Visual hierarchy**  
Numbers quiet (`01`); titles loud; body secondary. No icon row.

**Spacing**  
Grid gap 48–64px. Section intro max-width 560px above grid.

**Desktop** 2×2.  
**Tablet** 2×2 tighter or 1×4 if needed for reading.  
**Mobile** Single column stack.

**Animation**  
Staggered fade-up per cell (80ms). Hover: slight opacity or translate on “Learn more” only.

---

### 06 — Featured Work

**Purpose**  
Show taste, thinking, and business impact — even if early case studies are thin.

**User psychology**  
Work is the strongest trust proxy. Presentation quality signals delivery quality.

**How projects should be presented**

**Story model per project (mini case):**  
1. **Business** — who they are (type + aspiration)  
2. **Tension** — what was broken or limiting growth  
3. **Move** — what StepZero changed (brand / site / system)  
4. **Shift** — qualitative or quantitative outcome (honest)  
5. **Artifacts** — 1 dominant visual + optional 2 detail crops  

**On homepage (featured):** Show **2–3** projects max. Depth lives on Work pages.

**Information on each featured piece**

| Field | Required? | Notes |
|---|---|---|
| Project / business name | Yes | Or anonymized (“Northside Clinic”) if needed |
| Industry tag | Yes | One badge max |
| One-line outcome | Yes | “From invisible to booked-out weekends” |
| Tension (1 sentence) | Optional on hover/expand | Keeps grid clean |
| Primary visual | Yes | Full-bleed image in the tile — interactive container OK |
| CTA | Yes | “View project” |

**Storytelling**  
Homepage = **trailer**. Case study page = **film**. Don’t dump process timelines on the homepage grid.

**If work is early:**  
- Publish **speculative case studies** clearly labeled as “Concept” *or*  
- “Selected explorations” with real redesigns of anonymized local businesses *or*  
- Deep dive on **one** live pilot with radical honesty  

Never pad with Dribbble-style decoys that didn’t ship.

**Layout**  
Asymmetric editorial: one large feature + one/two secondary.

```
┌──────────────────────────────┬──────────────┐
│                              │  Project B   │
│       Project A (large)      │              │
│       Name · Industry        ├──────────────┤
│       Outcome line           │  Project C   │
│                              │              │
└──────────────────────────────┴──────────────┘
         [ View all work → ]
```

**Content hierarchy**  
Section title → featured grid → view-all link.

**Visual hierarchy**  
Image dominates; type is quiet overlay or caption below (prefer caption below to avoid sticker overlays).

**Spacing**  
Gap 16–24px between tiles; section air 120px.

**Desktop** Asymmetric bento.  
**Tablet** Large on top, two below.  
**Mobile** Vertical stack, 4:5 or 16:10 images.

**Animation**  
Image scale 1.0→1.03 on hover; caption fade. Page enter: cascade.

---

### 07 — Industries

**Purpose**  
Signal “we understand your world” to restaurants, cafés, salons, clinics, gyms, retail, real estate, startups.

**User psychology**  
Category recognition creates instant belonging. A restaurant owner should feel seen in under one second.

**Best layout recommendation: Horizontal editorial index (not logo clouds, not icon grids)**

**Why this layout**  
- Icon grids feel template-agency.  
- Card grids create false equality and clutter.  
- An **editorial list / marquee of categories with one rotating contextual line** feels premium and specific.  
- Alternative A+: **split panel** — list of industries left; right side shows one atmospheric photo + one insight line that changes with selection.

**Recommended: Interactive index (desktop)**

```
┌────────────────────┬─────────────────────────────────┐
│  Built for         │                                 │
│  local businesses  │     [ Atmospheric photo ]       │
│  that want to feel │                                 │
│  premium.          │     “For clinics, trust is      │
│                    │      the product.”              │
│  Restaurants  →    │                                 │
│  Cafés             │                                 │
│  Salons            │                                 │
│  Clinics   (active)│                                 │
│  Gyms              │                                 │
│  Retail            │                                 │
│  Real Estate       │                                 │
│  Startups          │                                 │
└────────────────────┴─────────────────────────────────┘
```

**Why best:** Conversation metaphor (select → respond). Shows domain literacy without fake case studies per vertical.

**Content hierarchy**  
Headline → industry list → contextual insight + image.

**Visual hierarchy**  
Active industry = primary text weight; inactive = secondary. Image quiet, insight line medium.

**Spacing**  
List item height ~44–52px for easy pointing. Panel padding 32–48.

**Desktop** Split interactive index.  
**Tablet** Same or stacked (list then image).  
**Mobile** Vertical list; tap expands insight inline; shared image above or below.

**Animation**  
Crossfade image + insight on selection (200–280ms). No bouncing tabs.

---

### 08 — Process

**Purpose**  
Replace fear of ambiguity with a clear, premium path. Confidence > cleverness.

**User psychology**  
Buying creative/strategy work feels risky. A named process reduces perceived risk and sets professional boundaries (what happens when, who decides, how long).

**Recommended process (5 stages)**

| Stage | Name | Client confidence it creates |
|---|---|---|
| 01 | **Diagnose** | “They’ll understand my business before designing.” |
| 02 | **Define** | “We’ll agree on positioning and success before pixels.” |
| 03 | **Design** | “Craft is intentional, not random moodboards.” |
| 04 | **Build** | “Systems and site are engineered to last.” |
| 05 | **Compound** | “Launch isn’t the end — growth loops start.” |

Each stage: **name + one sentence + typical duration band** (e.g., “1–2 weeks”) + **client involvement** (“2 workshops”).

**Layout**  
Horizontal numbered sequence on desktop; vertical on mobile. Not chevron clip-art.

```
01 Diagnose —— 02 Define —— 03 Design —— 04 Build —— 05 Compound
   short copy     short        short        short       short
```

Optional: connecting hairline. Selected stage expands detail in a drawer beneath the row.

**Content hierarchy**  
Section title (“A calm path from unclear to unmistakable”) → stages → optional “What we need from you” note.

**Visual hierarchy**  
Numbers large/light; names medium; body small. Duration as caption.

**Spacing**  
Equal columns; 24–32px between; detail panel 32px below.

**Desktop** 5-up sequence.  
**Tablet** 3+2 wrap or horizontal scroll with snap (use sparingly).  
**Mobile** Vertical timeline.

**Animation**  
Line progresses as section enters viewport once; stage hover reveals detail.

---

### 09 — Why StepZero

**Purpose**  
Differentiate without slamming competitors or using generic agency promises.

**User psychology**  
Buyers compare silently: freelancer vs studio vs big agency. We name the wedge: **business transformation with premium craft**, for local operators.

**Differentiation pillars (not “promises”)**

| Pillar | Meaning | Anti-generic test |
|---|---|---|
| **Business-first, not deliverable-first** | We start with identity and economics, not a page count. | Would a template agency say this? Only if they lie. |
| **Order matters** | Brand → site → automation → growth — we refuse out-of-order chaos. | Specific operating principle. |
| **Local premium** | We know the difference between a salon and a SaaS landing page. | Audience-specific. |
| **Limited capacity** | Quality requires constraint; we don’t factory-farm websites. | Signals selectivity. |
| **Systems, not one-offs** | Assets, automations, and voice that compound. | Future-facing. |

**Layout**  
Editorial split: left sticky thesis (“Why businesses choose StepZero”), right stacked pillars with hairline dividers — **no icon park**.

```
┌──────────────────┬─────────────────────────────┐
│  Why StepZero    │  Business-first             │
│                  │  short paragraph            │
│  One sharp       │  ─────────────────────────  │
│  paragraph       │  Order matters              │
│                  │  …                          │
│                  │  ─────────────────────────  │
│                  │  Local premium              │
└──────────────────┴─────────────────────────────┘
```

**Content hierarchy**  
Thesis → 3–4 pillars (max). Cut ruthlessly.

**Visual hierarchy**  
Thesis largest; pillar titles next; body secondary.

**Spacing**  
Pillar stack gap 32–40; section 120.

**Desktop** Sticky left / scroll right.  
**Tablet** Stack thesis then pillars.  
**Mobile** Full stack.

**Animation**  
Pillars fade-up on enter; sticky thesis stays put on desktop.

---

### 10 — Testimonials (alternatives while new)

**Purpose**  
Keep social proof without fabricating reviews.

**User psychology**  
Empty testimonial carousels are worse than none. Silence + substance > fake 5-star quotes.

**Alternatives until real reviews exist**

| Alternative | How to present | When to graduate |
|---|---|---|
| **Founder note** | Short signed letter: standards, who we take, who we don’t | Always useful; keep even later |
| **Pilot diary** | “Week 3 with a café owner” — process transparency | During first clients |
| **Principle quotes** | Attribute to *internal doctrine*, clearly labeled — not fake clients | Early only |
| **Workshop / waitlist proof** | “12 owners on the spring cohort waitlist” if true | If numbers are real |
| **Before/after narrative** | Single anonymized transformation story | As soon as one exists |
| **Video of process** | 60s studio/process film | Strong mid-term |

**Recommended homepage choice now:**  
**Founder note + one anonymized transformation narrative** (or process diary). Skip carousel UI entirely.

**Layout**  
Single-column editorial pull-quote / letter format. Wide margins. Signature line.

```
┌────────────────────────────────────────────┐
│  “We started StepZero because local        │
│   businesses deserve the same craft as     │
│   global brands — without the circus.”     │
│                                            │
│  — Name, Founder                           │
└────────────────────────────────────────────┘
```

**Content hierarchy**  
Optional label (“A note from the founder”) → quote → attribution.

**Visual hierarchy**  
Quote is the section; nothing competes.

**Spacing**  
Max text width ~640–720px; section padding 96–120.

**Desktop / tablet / mobile** Same structure; type scales down.

**Animation**  
Simple fade-up once. No auto-rotating slideshow.

---

### 11 — Insights

**Purpose**  
Demonstrate ongoing thinking; attract inbound; compound SEO and trust.

**Why content builds trust**  
- Proves you understand the buyer’s daily problems.  
- Lets skeptical visitors “try before they buy” intellectually.  
- Separates studios with a POV from order-takers.  
- Gives sales conversations shared language (“as in our note on brand before ads…”).

**Homepage treatment**  
Show **3 insights max** — quality over magazine density.

Each item: **title**, **1-line dek**, **reading time**, **topic tag** (optional).

Topics that fit StepZero: brand before traffic, local SEO myths, automation that doesn’t feel robotic, photography for clinics, menu design as conversion, etc.

**Layout**  
Horizontal trio (desktop); list on mobile. Prefer text-forward rows over thumbnail grids (thumbnails OK if photographic and restrained).

```
Insights                         View all →
────────────────────────────────────────────
Title one                         4 min
Dek…
────────────────────────────────────────────
Title two                         6 min
…
────────────────────────────────────────────
Title three                       5 min
…
```

**Content hierarchy**  
Section title + view all → entries (title → dek → meta).

**Visual hierarchy**  
Titles primary; deks secondary; meta caption.

**Spacing**  
Row padding 24–32; hairline dividers.

**Desktop** 3 columns or 3 stacked rows (rows feel more editorial). **Prefer stacked rows** for premium feel.  
**Tablet** Stacked rows.  
**Mobile** Stacked rows.

**Animation**  
Row hover: title color → accent or slight translate. No card lift.

---

### 12 — Final CTA

**Purpose**  
Convert earned trust into a conversation. The ending should feel inevitable, not pushy.

**Emotional goal**  
Calm invitation: “When you’re ready.”

**Recommended structure**

| Element | Content direction |
|---|---|
| Headline | *Ready to become the brand people trust?* |
| Supporting | Tell us where you are — identity, website, growth, or chaos. We’ll tell you the honest next step. |
| Primary CTA | Start a project |
| Secondary | Book an intro call *(or Email us)* |
| Reassurance | “Limited projects each quarter. Serious inquiries only.” |

**Layout**  
Centered editorial block on warm background shift (surface or muted) — still not a loud banner.

```
┌─────────────────────────────────────────────┐
│                                             │
│     Ready to become the brand               │
│     people trust?                           │
│                                             │
│     Short supporting sentence.              │
│                                             │
│     [ Start a project ]   Book an intro →   │
│                                             │
│     Limited projects each quarter.          │
│                                             │
└─────────────────────────────────────────────┘
```

**Content hierarchy**  
Headline → support → CTAs → micro-reassurance.

**Visual hierarchy**  
Headline dominant; reassurance caption-level.

**Spacing**  
Section 120–160px vertical; text max-width 640px; CTA gap 16–24.

**Desktop** Centered.  
**Tablet** Centered, slightly tighter.  
**Mobile** Full-width CTAs stacked.

**Animation**  
Fade-up of block as a whole; CTA hover states from design system.

---

### 13 — Footer

**Purpose**  
Utility + quiet brand close. No sitemap dump.

**User psychology**  
Premium footers feel like a colophon — complete, not cluttered.

**Recommended content**

```
StepZero
We build businesses people trust.

Services    Work    Process    Insights    About    Contact

© 2026 StepZero
```

Optional: email, Instagram/LinkedIn as text links (not icon rows).  
Avoid: newsletter bloating, random partner logos, chat widgets.

**Layout**  
Top: brand + tagline. Middle: single link row. Bottom: copyright. Hairline top border. Surface white on `#FAFAF8` page optional.

**Spacing**  
Vertical 48–64; link gap 24.

**Desktop** One row links.  
**Tablet** Same.  
**Mobile** Brand stack; links wrap 2×N; copyright last.

**Animation**  
None required.

---

## 4. Full-page wireframe (desktop)

```
╔══════════════════════════════════════════════════════════════════╗
║  StepZero     Services  Work  Process  Insights  About  Contact  ║
║                                              [ Start a project ] ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║  HERO (full-bleed visual)                                        ║
║  StepZero                                                        ║
║  We build businesses people trust.                               ║
║  Subhead…                                                        ║
║  [ Start a project ]   See our process →                         ║
║                                                                  ║
╠══════════════════════════════════════════════════════════════════╣
║  TRUST — three convictions in one quiet row                      ║
╠══════════════════════════════════════════════════════════════════╣
║  TRANSFORMATION — title + thesis                                      ║
║  spine: No Identity → Brand → Website → Automation → Growth →    ║
║         Scale   |   definition panel                             ║
╠══════════════════════════════════════════════════════════════════╣
║  OUTCOMES — intro                                                ║
║  ┌──────────────┐ ┌──────────────┐                               ║
║  │ Unmistakable │ │ Premium web  │                               ║
║  └──────────────┘ └──────────────┘                               ║
║  ┌──────────────┐ ┌──────────────┐                               ║
║  │ Run smoother │ │ Grow on      │                               ║
║  └──────────────┘ │ purpose      │                               ║
║                   └──────────────┘                               ║
╠══════════════════════════════════════════════════════════════════╣
║  WORK — asymmetric 1 large + 2 small   View all →                ║
╠══════════════════════════════════════════════════════════════════╣
║  INDUSTRIES — list  |  photo + insight                           ║
╠══════════════════════════════════════════════════════════════════╣
║  PROCESS — 01 02 03 04 05 + detail                               ║
╠══════════════════════════════════════════════════════════════════╣
║  WHY — sticky thesis | pillars                                   ║
╠══════════════════════════════════════════════════════════════════╣
║  PROOF ALT — founder note                                        ║
╠══════════════════════════════════════════════════════════════════╣
║  INSIGHTS — 3 editorial rows   View all →                        ║
╠══════════════════════════════════════════════════════════════════╣
║  FINAL CTA — centered invitation                                 ║
╠══════════════════════════════════════════════════════════════════╣
║  FOOTER — brand · links · ©                                      ║
╚══════════════════════════════════════════════════════════════════╝
```

### Scroll conversation (one-liner per beat)

1. **Nav** — You’re oriented.  
2. **Hero** — Here’s our belief.  
3. **Trust** — Here’s our spine.  
4. **Transform** — Here’s how businesses actually level up.  
5. **Outcomes** — Here’s what changes for you.  
6. **Work** — Here’s our taste.  
7. **Industries** — We know your world.  
8. **Process** — Here’s how engagement feels.  
9. **Why** — Here’s why we’re different.  
10. **Note** — Here’s a human you can trust.  
11. **Insights** — Here’s how we think ongoing.  
12. **CTA** — When you’re ready.  
13. **Footer** — Quiet exit.

---

## 5. Responsive wireframe notes

| Section | Desktop | Tablet | Mobile |
|---|---|---|---|
| Nav | Full links + CTA | Full or slightly compressed | Menu sheet |
| Hero | Full-bleed composition ~100vh | Scale type; keep bleed | Stack; stronger scrim |
| Trust | 3-up | 3-up / wrap | Stack |
| Transform | Spine + panel | Spine + panel tight | Accordion stepper |
| Outcomes | 2×2 | 2×2 or stack | Stack |
| Work | Bento | Large + 2 | Stack |
| Industries | Split interactive | Split or stack | List + expand |
| Process | 5-up | Wrap / snap | Vertical timeline |
| Why | Sticky split | Stack | Stack |
| Proof alt | Centered letter | Same | Same |
| Insights | 3 rows | 3 rows | 3 rows |
| Final CTA | Centered | Centered | Stacked CTAs |
| Footer | Single link row | Wrap | Stack |

---

## 6. Content inventory checklist

Before UI build, copy deck should lock:

- [ ] Final hero headline / sub / CTAs  
- [ ] 3 trust convictions  
- [ ] 6 transformation stage one-liners  
- [ ] 4 outcome group blurbs + destinations  
- [ ] 2–3 featured projects (or early-proof plan)  
- [ ] 8 industry insight lines + image set  
- [ ] 5 process stage copy + durations  
- [ ] 3–4 Why pillars  
- [ ] Founder note  
- [ ] 3 insight titles + deks  
- [ ] Final CTA + reassurance line  
- [ ] Footer links + legal  

Imagery: one hero atmosphere; industry set (8); work artifacts; optional process stills. Prefer real or commissioned photography over generic stock.

---

## 7. Success criteria

The blueprint succeeds if:

1. A stranger can retell StepZero’s philosophy after one scroll.  
2. No section feels like a rented agency template.  
3. A café owner and a clinic owner both feel “this is for me.”  
4. The primary CTA is never more than one intentional action away.  
5. Removing any one mid-page section would leave a hole in the conversation (each section earns its place).  
6. Engineers can implement section-by-section from this doc without inventing IA.

---

## Appendix A — Section purpose cheat sheet

| # | Section | Single job |
|---|---|---|
| 1 | Nav | Orient + convert access |
| 2 | Hero | State the belief |
| 3 | Trust | Show spine without fake logos |
| 4 | Transform | Teach the order of growth |
| 5 | Outcomes | Map help to business change |
| 6 | Work | Prove taste |
| 7 | Industries | Prove domain fit |
| 8 | Process | Reduce purchase fear |
| 9 | Why | Differentiate with principles |
| 10 | Proof alt | Human trust while new |
| 11 | Insights | Ongoing authority |
| 12 | Final CTA | Invite the next step |
| 13 | Footer | Close with elegance |

---

## Appendix B — Explicit non-goals for v1 homepage

- Pricing tables  
- Fake logo walls / fake testimonials  
- Chatbots in the hero  
- Stat counters (“500+ projects”)  
- Multi-offer promo banners  
- Icon-heavy service grids  
- Autoplay video with sound  

---

*End of UX blueprint. Next step (separate task): visual design / high-fidelity mock direction, then Flutter section implementation against this IA.*
