import '../domain/case_study.dart';

/// In-memory case studies — swap for CMS without touching presentation.
abstract final class CaseStudyCatalog {
  static const northside = CaseStudy(
    slug: 'northside-clinic',
    name: 'Northside Clinic',
    headline: 'From interchangeable to the clinic patients trust first.',
    outcomeLine:
        'A healthcare practice that finally looks as careful online as it feels in the room.',
    accent: 0xFF5B5FEF,
    heroMetrics: [
      CaseStudyMetric(label: 'Bookings', value: '+142%'),
      CaseStudyMetric(label: 'No-shows', value: '-38%'),
      CaseStudyMetric(label: 'Rating', value: '4.9'),
    ],
    overview: CaseStudyOverview(
      summary:
          'Northside Clinic is a multi-physician practice serving families across '
          'two neighborhoods. Excellent care — invisible brand. Patients discovered '
          'them through referrals, then bounced between phone tag and a dated site.',
      industry: 'Healthcare',
      location: 'Austin, TX',
      companySize: '18 staff · 4 physicians',
      engagement: '12-week transformation + growth retainer',
      services: [
        'Brand strategy',
        'Visual identity',
        'Website',
        'AI intake',
        'WhatsApp follow-ups',
      ],
    ),
    challenge:
        'Northside looked like every other clinic online. Booking lived in phone '
        'tag. Reviews were scattered. The front desk spent mornings re-answering '
        'the same five questions — while serious patients quietly chose competitors '
        'with clearer digital trust signals.',
    research: [
      CaseStudyInsight(
        title: 'Trust is the product',
        body:
            'Prospects decided in under 12 seconds whether the clinic felt safe. '
            'Photography and voice mattered more than feature lists.',
      ),
      CaseStudyInsight(
        title: 'Phone was a bottleneck, not a channel',
        body:
            '68% of missed inquiries happened outside desk hours. Automation had '
            'to feel clinical — never chatty.',
      ),
      CaseStudyInsight(
        title: 'Identity leaked across touchpoints',
        body:
            'Cards, Google profile, and site each told a different story. '
            'Inconsistency read as risk.',
      ),
    ],
    strategy: [
      CaseStudyStrategyItem(
        title: 'Brand before booking UI',
        body:
            'Clarify positioning for families seeking calm, modern primary care — '
            'then express it everywhere.',
      ),
      CaseStudyStrategyItem(
        title: 'Self-qualify before the call',
        body:
            'Let the site and AI intake answer routine questions so the desk '
            'handles only high-intent conversations.',
      ),
      CaseStudyStrategyItem(
        title: 'Compound reviews + WhatsApp',
        body:
            'Close the loop after visits so reputation and retention reinforce '
            'each other.',
      ),
    ],
    brand: CaseStudyBrandChapter(
      narrative:
          'We built a quiet, confident identity: soft clinical blues, generous '
          'whitespace, and typography that feels more private practice than '
          'hospital portal. The mark is a precise N-path — care with direction.',
      principles: [
        'Calm over clinical coldness',
        'Clarity over cleverness',
        'Human photography, never stock smiles',
      ],
      paletteLabels: ['Ink', 'Porcelain', 'Care Blue', 'Signal'],
    ),
    website: CaseStudyProductChapter(
      narrative:
          'The site is a conversion instrument: condition clarity, physician '
          'credibility, and a booking path that doesn’t require a phone tree.',
      decisions: [
        'Hero speaks to anxious first-time patients, not internal jargon',
        'Services organized by life moment, not department codes',
        'Proof (reviews, credentials) adjacent to every CTA',
      ],
    ),
    mobile: CaseStudyProductChapter(
      narrative:
          'Most discovery happened on phones in parking lots and school pickups. '
          'Mobile wasn’t a breakpoint — it was the primary product.',
      decisions: [
        'Sticky “Book visit” within thumb reach',
        'One-tap call + WhatsApp for urgency paths',
        'Compressed physician cards with availability signals',
      ],
    ),
    automation: [
      CaseStudyAutomation(
        title: 'AI intake',
        body:
            'After-hours assistant collects symptoms, insurance basics, and '
            'preferred times — then hands a clean brief to the desk.',
      ),
      CaseStudyAutomation(
        title: 'WhatsApp confirmations',
        body:
            'Visit reminders and prep instructions reduced no-shows without '
            'sounding like spam.',
      ),
      CaseStudyAutomation(
        title: 'Review routing',
        body:
            'Happy visits gently prompted Google reviews within 24 hours.',
      ),
    ],
    resultsNarrative:
        'Within one quarter, Northside stopped competing on who answered the '
        'phone first. Bookings rose as the brand earned trust earlier in the '
        'journey. The desk reported fewer repetitive calls and more prepared patients. '
        'No-shows dropped as confirmations became a habit — not a hope.',
    gallery: [
      CaseStudyGalleryItem(
        label: 'Identity',
        caption: 'Mark, wordmark, and care-blue system on porcelain.',
        tone: 0xFF5B5FEF,
      ),
      CaseStudyGalleryItem(
        label: 'Website',
        caption: 'Desktop homepage — calm hero, proof adjacent to CTA.',
        tone: 0xFF312E81,
      ),
      CaseStudyGalleryItem(
        label: 'Mobile',
        caption: 'Thumb-first booking and physician availability.',
        tone: 0xFF1D4ED8,
      ),
      CaseStudyGalleryItem(
        label: 'Automation',
        caption: 'Intake conversation that stays clinical.',
        tone: 0xFF0F766E,
      ),
    ],
    metrics: [
      CaseStudyMetric(
        label: 'Online bookings',
        value: '+142%',
        caption: '90 days post-launch vs prior quarter',
      ),
      CaseStudyMetric(
        label: 'No-show rate',
        value: '-38%',
        caption: 'After WhatsApp confirmation loop',
      ),
      CaseStudyMetric(
        label: 'Google rating',
        value: '4.9',
        caption: 'From 4.2 with 3× review velocity',
      ),
      CaseStudyMetric(
        label: 'Desk call volume',
        value: '-27%',
        caption: 'Routine questions deflected to AI intake',
      ),
    ],
    testimonial: CaseStudyTestimonial(
      quote:
          'StepZero didn’t give us a prettier website. They gave us a system '
          'that makes mornings quieter and patients more sure.',
      name: 'Dr. Maya Chen',
      role: 'Managing Physician, Northside Clinic',
    ),
    techStack: [
      'Flutter Web',
      'Headless CMS',
      'AI intake agent',
      'WhatsApp Business API',
      'Google Business Profile',
      'Analytics',
    ],
    timeline: [
      CaseStudyTimelinePhase(
        title: 'Discover',
        duration: 'Week 1',
        body: 'Stakeholder interviews, desk shadowing, review audit.',
      ),
      CaseStudyTimelinePhase(
        title: 'Define',
        duration: 'Weeks 2–3',
        body: 'Positioning, success metrics, transformation sequence.',
      ),
      CaseStudyTimelinePhase(
        title: 'Design',
        duration: 'Weeks 4–6',
        body: 'Identity system + site experience.',
      ),
      CaseStudyTimelinePhase(
        title: 'Build',
        duration: 'Weeks 7–10',
        body: 'Site, intake, WhatsApp, review routing.',
      ),
      CaseStudyTimelinePhase(
        title: 'Launch & compound',
        duration: 'Weeks 11–12+',
        body: 'Training, QA, growth loops.',
      ),
    ],
    lessons: [
      'In healthcare, tone calibration is a conversion problem — not a copy preference.',
      'Automation only works after identity is clear; otherwise you scale confusion.',
      'Measure desk calm as seriously as bookings — operators feel the win there first.',
    ],
    nextSlug: 'oven-and-oak',
  );

  static const ovenAndOak = CaseStudy(
    slug: 'oven-and-oak',
    name: 'Oven & Oak',
    headline: 'A dining room people already loved — finally matched online.',
    outcomeLine:
        'Weeknight covers filled when brand, menu, and discovery finally agreed.',
    accent: 0xFF0F766E,
    heroMetrics: [
      CaseStudyMetric(label: 'Covers', value: '+87%'),
      CaseStudyMetric(label: 'Orders', value: '+164%'),
      CaseStudyMetric(label: 'Search', value: 'Top 3'),
    ],
    overview: CaseStudyOverview(
      summary:
          'Oven & Oak is a neighborhood restaurant with chef-driven plates and a '
          'warm room — undermined by a forgettable site, PDF menu friction, and '
          'inconsistent Google presence.',
      industry: 'Restaurant',
      location: 'Portland, OR',
      companySize: '32 staff · 1 location',
      engagement: '10-week transformation',
      services: [
        'Brand refresh',
        'Website + QR menu',
        'Local SEO',
        'Review engine',
      ],
    ),
    challenge:
        'Walk-ins knew the magic. The internet didn’t. Midweek tables sat empty '
        'while tourists booked louder competitors. The QR menu was a PDF that '
        'broke the mood the room worked so hard to create.',
    research: [
      CaseStudyInsight(
        title: 'Atmosphere is a digital promise',
        body:
            'Guests decided “is this worth a weeknight?” from three photos and '
            'a menu interaction — not from the chef’s bio.',
      ),
      CaseStudyInsight(
        title: 'PDF menus tax desire',
        body:
            'Pinch-zoom friction killed impulse orders. Mobile menu UX was the '
            'revenue surface.',
      ),
      CaseStudyInsight(
        title: 'Reviews lagged reality',
        body:
            'Great service nights didn’t convert into Google proof. Reputation '
            'was stuck in 2022.',
      ),
    ],
    strategy: [
      CaseStudyStrategyItem(
        title: 'Refresh identity without erasing soul',
        body: 'Sharpen the oak-and-fire story — don’t reinvent a beloved room.',
      ),
      CaseStudyStrategyItem(
        title: 'Treat the menu as a product',
        body: 'QR menu as branded conversion UI, not a file download.',
      ),
      CaseStudyStrategyItem(
        title: 'Own local discovery',
        body: 'Photography, SEO, and review loops aimed at weeknight intent.',
      ),
    ],
    brand: CaseStudyBrandChapter(
      narrative:
          'We deepened the existing warmth: charcoal, ember, and cream. Typography '
          'got quieter; photography got closer to the plate. The wordmark feels '
          'carved, not templated.',
      principles: [
        'Heat without gimmick',
        'Craft visible in every type size',
        'Hospitality in microcopy',
      ],
      paletteLabels: ['Charcoal', 'Ember', 'Cream', 'Leaf'],
    ),
    website: CaseStudyProductChapter(
      narrative:
          'The site sells the weeknight decision: mood, menu path, reservation, '
          'and proof — in that order.',
      decisions: [
        'Hero is the room at golden hour — not a logo lockup',
        'Menu and reservations elevated above about-us mythology',
        'Events and private dining as secondary, not competing, stories',
      ],
    ),
    mobile: CaseStudyProductChapter(
      narrative:
          'QR-to-order and reserve flows were designed as one continuous gesture '
          'from table to kitchen.',
      decisions: [
        'Sectioned menu with dietary filters that don’t feel sterile',
        'One-tap reserve + call for walk-in questions',
        'Shareable dish cards for social proof loops',
      ],
    ),
    automation: [
      CaseStudyAutomation(
        title: 'QR menu system',
        body: 'Always-current menu with photography and allergen clarity.',
      ),
      CaseStudyAutomation(
        title: 'Review engine',
        body: 'Post-dining prompts timed for peak satisfaction.',
      ),
      CaseStudyAutomation(
        title: 'Local SEO cadence',
        body: 'Weekly Google profile posts tied to real specials.',
      ),
    ],
    resultsNarrative:
        'Weeknight covers climbed as search and brand finally matched the room. '
        'Online orders more than doubled once the menu stopped being a PDF. '
        'Oven & Oak now shows up where hungry neighbors actually look — and the '
        'digital experience no longer apologizes for the dining room.',
    gallery: [
      CaseStudyGalleryItem(
        label: 'Brand',
        caption: 'Wordmark and ember system on charcoal.',
        tone: 0xFF0F766E,
      ),
      CaseStudyGalleryItem(
        label: 'Website',
        caption: 'Homepage selling the weeknight decision.',
        tone: 0xFF134E4A,
      ),
      CaseStudyGalleryItem(
        label: 'QR Menu',
        caption: 'Productized menu — not a PDF.',
        tone: 0xFFB45309,
      ),
      CaseStudyGalleryItem(
        label: 'Mobile',
        caption: 'Reserve + order in one thumb path.',
        tone: 0xFF7C2D12,
      ),
    ],
    metrics: [
      CaseStudyMetric(
        label: 'Weeknight covers',
        value: '+87%',
        caption: 'Tue–Thu average, 60 days post-launch',
      ),
      CaseStudyMetric(
        label: 'Online orders',
        value: '+164%',
        caption: 'QR menu vs prior PDF period',
      ),
      CaseStudyMetric(
        label: 'Local pack',
        value: 'Top 3',
        caption: 'Primary cuisine + neighborhood queries',
      ),
      CaseStudyMetric(
        label: 'Review velocity',
        value: '4×',
        caption: 'Monthly Google reviews',
      ),
    ],
    testimonial: CaseStudyTestimonial(
      quote:
          'Guests used to say the food was incredible and the website was '
          'whatever. Now the whole thing feels like one restaurant.',
      name: 'Jordan Hale',
      role: 'Owner-Chef, Oven & Oak',
    ),
    techStack: [
      'Flutter Web',
      'QR menu platform',
      'Reservations API',
      'Google Business Profile',
      'Review automation',
      'Analytics',
    ],
    timeline: [
      CaseStudyTimelinePhase(
        title: 'Discover',
        duration: 'Week 1',
        body: 'Service shadowing, menu audit, competitor table.',
      ),
      CaseStudyTimelinePhase(
        title: 'Define',
        duration: 'Week 2',
        body: 'Positioning refresh + success metrics.',
      ),
      CaseStudyTimelinePhase(
        title: 'Design',
        duration: 'Weeks 3–5',
        body: 'Identity, site, QR menu UX.',
      ),
      CaseStudyTimelinePhase(
        title: 'Build',
        duration: 'Weeks 6–8',
        body: 'Implementation + SEO foundations.',
      ),
      CaseStudyTimelinePhase(
        title: 'Launch',
        duration: 'Weeks 9–10',
        body: 'Staff training, review loops, local pack push.',
      ),
    ],
    lessons: [
      'For restaurants, the menu is the homepage — treat it like product design.',
      'Brand refresh should feel inevitable, not trendy.',
      'Weeknight demand is a discovery problem before it’s a promotions problem.',
    ],
    nextSlug: 'northside-clinic',
  );

  static const List<CaseStudy> all = [northside, ovenAndOak];

  static CaseStudy? bySlug(String slug) {
    for (final study in all) {
      if (study.slug == slug) return study;
    }
    return null;
  }
}
