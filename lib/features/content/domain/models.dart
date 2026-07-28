/// CMS-ready content domain models — Flutter-agnostic.
library;

// ── Services ───────────────────────────────────────────────────────────────

class ServiceOffering {
  const ServiceOffering({
    required this.slug,
    required this.title,
    required this.summary,
    required this.detail,
    required this.outcomes,
    required this.iconKey,
    this.order = 0,
  });

  final String slug;
  final String title;
  final String summary;
  final String detail;
  final List<String> outcomes;
  final String iconKey;
  final int order;
}

// ── Testimonials ───────────────────────────────────────────────────────────

class Testimonial {
  const Testimonial({
    required this.id,
    required this.quote,
    required this.name,
    required this.role,
    required this.company,
    this.industry,
    this.featured = false,
  });

  final String id;
  final String quote;
  final String name;
  final String role;
  final String company;
  final String? industry;
  final bool featured;
}

// ── Articles ───────────────────────────────────────────────────────────────

class Article {
  const Article({
    required this.slug,
    required this.title,
    required this.dek,
    required this.tag,
    required this.readTime,
    required this.body,
    required this.tone,
    this.featured = false,
    this.publishedAt,
  });

  final String slug;
  final String title;
  final String dek;
  final String tag;
  final String readTime;
  final String body;
  final int tone;
  final bool featured;
  final String? publishedAt;
}

// ── Team ───────────────────────────────────────────────────────────────────

class TeamMember {
  const TeamMember({
    required this.slug,
    required this.name,
    required this.role,
    required this.bio,
    required this.tone,
    this.focus = const [],
  });

  final String slug;
  final String name;
  final String role;
  final String bio;
  final int tone;
  final List<String> focus;
}

// ── FAQs ───────────────────────────────────────────────────────────────────

class FaqItem {
  const FaqItem({
    required this.id,
    required this.question,
    required this.answer,
    this.order = 0,
    this.featured = true,
  });

  final String id;
  final String question;
  final String answer;
  final int order;
  final bool featured;
}

// ── Pricing ────────────────────────────────────────────────────────────────

class PricingPlan {
  const PricingPlan({
    required this.slug,
    required this.name,
    required this.priceLabel,
    required this.cadence,
    required this.summary,
    required this.includes,
    this.highlighted = false,
    this.ctaLabel = 'Book a discovery call',
  });

  final String slug;
  final String name;
  final String priceLabel;
  final String cadence;
  final String summary;
  final List<String> includes;
  final bool highlighted;
  final String ctaLabel;
}

// ── Industries ─────────────────────────────────────────────────────────────

class Industry {
  const Industry({
    required this.slug,
    required this.name,
    required this.insight,
    required this.body,
    required this.iconKey,
    this.proofPoints = const [],
  });

  final String slug;
  final String name;
  final String insight;
  final String body;
  final String iconKey;
  final List<String> proofPoints;
}
