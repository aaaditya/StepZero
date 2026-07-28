import '../../work/data/case_study_catalog.dart';
import '../../work/domain/case_study.dart';
import '../domain/models.dart';

/// In-memory content catalogs — swap for CMS without touching presentation.
abstract final class ContentCatalog {
  // ── Projects (delegates to case study catalog) ───────────────────────────

  static List<CaseStudy> get projects => CaseStudyCatalog.all;

  static CaseStudy? projectBySlug(String slug) => CaseStudyCatalog.bySlug(slug);

  // ── Services ─────────────────────────────────────────────────────────────

  static const services = <ServiceOffering>[
    ServiceOffering(
      slug: 'brand',
      title: 'Brand',
      summary: 'Identity, Logo, Guidelines',
      detail:
          'We define the reason you exist in the market — then lock it into a '
          'system your team can actually use.',
      outcomes: ['Identity systems', 'Logo & marks', 'Brand guidelines'],
      iconKey: 'brush',
      order: 1,
    ),
    ServiceOffering(
      slug: 'digital-presence',
      title: 'Digital Presence',
      summary: 'Websites, Landing Pages, QR Menus',
      detail:
          'Interfaces that feel as considered as your space — and convert '
          'visitors into booked customers.',
      outcomes: ['Premium websites', 'Landing pages', 'QR menus'],
      iconKey: 'desktop',
      order: 2,
    ),
    ServiceOffering(
      slug: 'automation',
      title: 'Automation',
      summary: 'AI Chatbots, WhatsApp, Booking Systems',
      detail:
          'Always-on conversations and ops that remove busywork without '
          'removing the human touch.',
      outcomes: ['AI chatbots', 'WhatsApp flows', 'Booking systems'],
      iconKey: 'bolt',
      order: 3,
    ),
    ServiceOffering(
      slug: 'growth',
      title: 'Growth',
      summary: 'SEO, Content, Analytics',
      detail:
          'Demand generation that compounds because the brand can hold the '
          'attention it earns.',
      outcomes: ['Local SEO', 'Content systems', 'Analytics'],
      iconKey: 'insights',
      order: 4,
    ),
  ];

  static ServiceOffering? serviceBySlug(String slug) {
    for (final s in services) {
      if (s.slug == slug) return s;
    }
    return null;
  }

  // ── Testimonials ─────────────────────────────────────────────────────────

  static const testimonials = <Testimonial>[
    Testimonial(
      id: 'northside-dr-chen',
      quote:
          'StepZero didn’t give us a prettier site. They gave us a system that '
          'books patients while we sleep — and a brand patients finally trust '
          'before they walk in.',
      name: 'Dr. Maya Chen',
      role: 'Founder',
      company: 'Northside Clinic',
      industry: 'Healthcare',
      featured: true,
    ),
    Testimonial(
      id: 'oven-oak-elena',
      quote:
          'Reservations stopped feeling like chaos. Guests arrive already '
          'knowing who we are — and the floor runs quieter because WhatsApp '
          'handles the noise.',
      name: 'Elena Vargas',
      role: 'Owner',
      company: 'Oven & Oak',
      industry: 'Restaurant',
      featured: true,
    ),
    Testimonial(
      id: 'atelier-james',
      quote:
          'We finally look as considered online as we do in the chair. Booking '
          'is clear, the brand holds, and I stopped apologizing for our website.',
      name: 'James Okonkwo',
      role: 'Creative Director',
      company: 'Atelier North',
      industry: 'Salon',
      featured: false,
    ),
  ];

  static List<Testimonial> get featuredTestimonials =>
      testimonials.where((t) => t.featured).toList(growable: false);

  // ── Articles ─────────────────────────────────────────────────────────────

  static const articles = <Article>[
    Article(
      slug: 'brand-before-traffic',
      title: 'Brand before traffic: why ads fail unclear businesses',
      dek:
          'Acquisition amplifies what already exists. If identity is fuzzy, '
          'spend just buys confusion faster.',
      tag: 'Strategy',
      readTime: '6 min',
      featured: true,
      tone: 0xFF5B5FEF,
      publishedAt: '2026-05-12',
      body:
          'Most local operators start with traffic because traffic feels '
          'measurable. Clicks. Impressions. Leads.\n\n'
          'But paid attention without a clear brand is expensive noise. The '
          'visitor lands, cannot place you in a category of trust, and leaves.\n\n'
          'StepZero’s sequence starts with identity because growth systems '
          'need something worth converting. Brand is not decoration — it is '
          'the compression of why someone should choose you.',
    ),
    Article(
      slug: 'qr-menu-brand-surface',
      title: 'The QR menu is a brand surface',
      dek:
          'Menus are not PDFs. They’re conversion products sitting in every '
          'guest’s hand.',
      tag: 'Digital',
      readTime: '4 min',
      featured: false,
      tone: 0xFF0F766E,
      publishedAt: '2026-04-03',
      body:
          'A QR menu is often treated as a compliance artifact. Scan, scroll, '
          'order. Done.\n\n'
          'That is a missed surface. Guests hold your brand for minutes. The '
          'typography, photography, pacing, and upsell path either reinforce '
          'the room — or quietly cheapen it.\n\n'
          'Design the menu like a landing page with hospitality manners.',
    ),
    Article(
      slug: 'automation-still-human',
      title: 'Automation that still feels human',
      dek:
          'WhatsApp and AI should remove friction — never the warmth that '
          'made someone choose you.',
      tag: 'Automation',
      readTime: '5 min',
      featured: false,
      tone: 0xFFB45309,
      publishedAt: '2026-03-18',
      body:
          'Operators fear automation will make them sound corporate. The '
          'opposite risk is worse: manual chaos that burns out the humans '
          'who create the warmth.\n\n'
          'Good automation absorbs repetitive questions, routes urgency, and '
          'protects staff energy — while keeping language local, specific, '
          'and kind.',
    ),
  ];

  static Article? articleBySlug(String slug) {
    for (final a in articles) {
      if (a.slug == slug) return a;
    }
    return null;
  }

  // ── Team ─────────────────────────────────────────────────────────────────

  static const team = <TeamMember>[
    TeamMember(
      slug: 'aria-nolan',
      name: 'Aria Nolan',
      role: 'Strategy & Brand',
      bio:
          'Former brand lead for hospitality groups. Obsessed with making '
          'local operators feel as considered as global names.',
      tone: 0xFF5B5FEF,
      focus: ['Positioning', 'Identity systems', 'Narrative'],
    ),
    TeamMember(
      slug: 'leo-park',
      name: 'Leo Park',
      role: 'Product & Web',
      bio:
          'Designs conversion interfaces that feel quiet and premium — '
          'never loud, never cluttered.',
      tone: 0xFF0F766E,
      focus: ['Websites', 'Systems UI', 'Motion'],
    ),
    TeamMember(
      slug: 'samira-reid',
      name: 'Samira Reid',
      role: 'Automation & Growth',
      bio:
          'Builds the always-on layer: booking, messaging, measurement — '
          'so craft compounds after launch.',
      tone: 0xFFB45309,
      focus: ['AI / WhatsApp', 'Local SEO', 'Analytics'],
    ),
  ];

  // ── FAQs ─────────────────────────────────────────────────────────────────

  static const faqs = <FaqItem>[
    FaqItem(
      id: 'only-websites',
      question: 'Do you only build websites?',
      answer:
          'No. Websites are one layer. We design the sequence — brand, '
          'presence, automation, and growth — so the site has something '
          'worth converting.',
      order: 1,
    ),
    FaqItem(
      id: 'timeline',
      question: 'How long does a typical engagement take?',
      answer:
          'Most transformation systems land in 8–14 weeks depending on '
          'scope. Growth retainers continue after launch so momentum compounds.',
      order: 2,
    ),
    FaqItem(
      id: 'who',
      question: 'What kinds of businesses do you work with?',
      answer:
          'Local operators who want to feel premium — restaurants, cafés, '
          'salons, clinics, gyms, retail, hotels, real estate, and focused startups.',
      order: 3,
    ),
    FaqItem(
      id: 'capacity',
      question: 'How many projects do you take?',
      answer:
          'A limited number each quarter. Constraint protects craft. If '
          'we’re full, we’ll tell you honestly and offer a waitlist.',
      order: 4,
    ),
    FaqItem(
      id: 'discovery',
      question: 'What happens on a discovery call?',
      answer:
          'We diagnose where you are on the journey — identity, presence, '
          'systems, growth — and tell you the honest next step, even if it isn’t us.',
      order: 5,
    ),
    FaqItem(
      id: 'pricing',
      question: 'How does pricing work?',
      answer:
          'Engagements are scoped as fixed transformation systems or ongoing '
          'growth retainers. See Pricing for shapes — discovery confirms fit.',
      order: 6,
      featured: false,
    ),
  ];

  static List<FaqItem> get featuredFaqs =>
      faqs.where((f) => f.featured).toList(growable: false);

  // ── Pricing ──────────────────────────────────────────────────────────────

  static const pricing = <PricingPlan>[
    PricingPlan(
      slug: 'foundation',
      name: 'Foundation',
      priceLabel: 'From \$12k',
      cadence: 'one-time system',
      summary:
          'Brand clarity + a conversion-ready digital presence for operators '
          'ready to look premium.',
      includes: [
        'Positioning & identity system',
        'Premium website or landing system',
        'Launch analytics baseline',
        '4-week post-launch support',
      ],
    ),
    PricingPlan(
      slug: 'transformation',
      name: 'Transformation',
      priceLabel: 'From \$28k',
      cadence: '8–14 week engagement',
      summary:
          'Full sequence: brand, presence, automation, and growth setup — '
          'the core StepZero system.',
      includes: [
        'Everything in Foundation',
        'Booking / WhatsApp / AI flows',
        'Operator playbooks',
        '90-day growth plan',
      ],
      highlighted: true,
    ),
    PricingPlan(
      slug: 'compound',
      name: 'Compound',
      priceLabel: 'From \$4.5k/mo',
      cadence: 'retainer',
      summary:
          'Ongoing craft after launch — content, SEO, automation iteration, '
          'and measurement reviews.',
      includes: [
        'Monthly growth sprints',
        'Content + local SEO',
        'Automation improvements',
        'Priority studio access',
      ],
    ),
  ];

  // ── Industries ───────────────────────────────────────────────────────────

  static const industries = <Industry>[
    Industry(
      slug: 'restaurants',
      name: 'Restaurants',
      insight: 'Covers, reputation, and menus that convert.',
      body:
          'We build reservation trust, menu surfaces, and reputation systems '
          'so the dining room’s quality shows up before the first course.',
      iconKey: 'restaurant',
      proofPoints: ['Direct reservations', 'QR menus', 'Review loops'],
    ),
    Industry(
      slug: 'cafes',
      name: 'Cafés',
      insight: 'Atmosphere online that matches the room.',
      body:
          'Cafés win on feeling. We translate atmosphere into digital presence '
          'without turning the brand into a franchise template.',
      iconKey: 'cafe',
      proofPoints: ['Brand mood', 'Loyalty paths', 'Local discovery'],
    ),
    Industry(
      slug: 'salons',
      name: 'Salons',
      insight: 'Booking clarity and premium visual trust.',
      body:
          'Clients book with their eyes first. We make the brand and booking '
          'flow feel as considered as the chair.',
      iconKey: 'salon',
      proofPoints: ['Booking UX', 'Portfolio trust', 'Reminders'],
    ),
    Industry(
      slug: 'clinics',
      name: 'Clinics',
      insight: 'Care signals, intake automation, reviews.',
      body:
          'Healthcare trust is fragile. We design calm digital fronts and '
          'intake automation that respect patients and staff.',
      iconKey: 'clinic',
      proofPoints: ['Intake flows', 'Care messaging', 'Reputation'],
    ),
    Industry(
      slug: 'gyms',
      name: 'Gyms',
      insight: 'Membership journeys that feel intentional.',
      body:
          'Memberships stick when the brand and onboarding feel purposeful — '
          'not like a discount funnel.',
      iconKey: 'gym',
      proofPoints: ['Membership journeys', 'Class booking', 'Retention'],
    ),
    Industry(
      slug: 'retail',
      name: 'Retail',
      insight: 'Shelf-to-screen systems that sell.',
      body:
          'Local retail needs presence that matches the shelf experience — '
          'and systems that recover abandoned intent.',
      iconKey: 'retail',
      proofPoints: ['Catalog presence', 'Local SEO', 'CRM light'],
    ),
    Industry(
      slug: 'hotels',
      name: 'Hotels',
      insight: 'Stay branding and direct booking paths.',
      body:
          'We reduce OTA dependency with brand-led direct booking journeys '
          'that feel like the property.',
      iconKey: 'hotel',
      proofPoints: ['Direct booking', 'Stay narrative', 'Upsells'],
    ),
    Industry(
      slug: 'real-estate',
      name: 'Real Estate',
      insight: 'Authority sites that close serious buyers.',
      body:
          'Serious buyers need authority, not lead spam. We build presence '
          'that filters for intent and protects reputation.',
      iconKey: 'realestate',
      proofPoints: ['Authority sites', 'Listing systems', 'Lead quality'],
    ),
  ];

  static Industry? industryBySlug(String slug) {
    for (final i in industries) {
      if (i.slug == slug) return i;
    }
    return null;
  }
}
