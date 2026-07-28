/// Domain model for StepZero case studies — storytelling + outcomes.
library;

class CaseStudyMetric {
  const CaseStudyMetric({
    required this.label,
    required this.value,
    this.caption,
  });

  final String label;
  final String value;
  final String? caption;
}

class CaseStudyInsight {
  const CaseStudyInsight({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}

class CaseStudyStrategyItem {
  const CaseStudyStrategyItem({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}

class CaseStudyGalleryItem {
  const CaseStudyGalleryItem({
    required this.caption,
    required this.tone,
    this.label = 'Artifact',
  });

  final String caption;
  final String label;
  /// Accent seed for generative placeholder art (no stock photos required).
  final int tone;
}

class CaseStudyAutomation {
  const CaseStudyAutomation({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}

class CaseStudyTimelinePhase {
  const CaseStudyTimelinePhase({
    required this.title,
    required this.duration,
    required this.body,
  });

  final String title;
  final String duration;
  final String body;
}

class CaseStudyTestimonial {
  const CaseStudyTestimonial({
    required this.quote,
    required this.name,
    required this.role,
  });

  final String quote;
  final String name;
  final String role;
}

class CaseStudyOverview {
  const CaseStudyOverview({
    required this.summary,
    required this.industry,
    required this.location,
    required this.companySize,
    required this.engagement,
    required this.services,
  });

  final String summary;
  final String industry;
  final String location;
  final String companySize;
  final String engagement;
  final List<String> services;
}

class CaseStudyBrandChapter {
  const CaseStudyBrandChapter({
    required this.narrative,
    required this.principles,
    required this.paletteLabels,
  });

  final String narrative;
  final List<String> principles;
  final List<String> paletteLabels;
}

class CaseStudyProductChapter {
  const CaseStudyProductChapter({
    required this.narrative,
    required this.decisions,
  });

  final String narrative;
  final List<String> decisions;
}

class CaseStudy {
  const CaseStudy({
    required this.slug,
    required this.name,
    required this.headline,
    required this.outcomeLine,
    required this.heroMetrics,
    required this.overview,
    required this.challenge,
    required this.research,
    required this.strategy,
    required this.brand,
    required this.website,
    required this.mobile,
    required this.automation,
    required this.resultsNarrative,
    required this.gallery,
    required this.metrics,
    required this.testimonial,
    required this.techStack,
    required this.timeline,
    required this.lessons,
    required this.nextSlug,
    required this.accent,
  });

  final String slug;
  final String name;
  final String headline;
  final String outcomeLine;
  final List<CaseStudyMetric> heroMetrics;
  final CaseStudyOverview overview;
  final String challenge;
  final List<CaseStudyInsight> research;
  final List<CaseStudyStrategyItem> strategy;
  final CaseStudyBrandChapter brand;
  final CaseStudyProductChapter website;
  final CaseStudyProductChapter mobile;
  final List<CaseStudyAutomation> automation;
  final String resultsNarrative;
  final List<CaseStudyGalleryItem> gallery;
  final List<CaseStudyMetric> metrics;
  final CaseStudyTestimonial testimonial;
  final List<String> techStack;
  final List<CaseStudyTimelinePhase> timeline;
  final List<String> lessons;
  final String nextSlug;
  final int accent;

  static const toc = <(String, String)>[
    ('overview', 'Client Overview'),
    ('challenge', 'Challenge'),
    ('research', 'Research'),
    ('strategy', 'Strategy'),
    ('brand', 'Brand Identity'),
    ('website', 'Website Design'),
    ('mobile', 'Mobile Experience'),
    ('automation', 'Automation'),
    ('results', 'Business Results'),
    ('gallery', 'Gallery'),
    ('metrics', 'Metrics'),
    ('testimonial', 'Testimonial'),
    ('stack', 'Tech Stack'),
    ('timeline', 'Timeline'),
    ('lessons', 'Lessons Learned'),
    ('next', 'Next Project'),
  ];
}
