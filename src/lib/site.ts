/**
 * Canonical site configuration for StepZero.
 * Social URLs come from env; sameAs only includes defined values.
 */

export const site = {
  brand: "StepZero",
  siteUrl: "https://thestepzero.in",
  email: "info@thestepzero.in",
  /** E.164 digits only. Set via NEXT_PUBLIC_WHATSAPP_E164 on Vercel. */
  whatsappE164: (process.env.NEXT_PUBLIC_WHATSAPP_E164 ?? "").replace(
    /\D/g,
    "",
  ),
  /** Primary market / legal operating country. */
  country: "India",
  /**
   * Optional city for local SEO / contact page.
   * Leave empty when serving nationally; set e.g. "Bengaluru" when known.
   */
  city: (process.env.NEXT_PUBLIC_CITY ?? "").trim(),
  /** Service-area framing for copy (not "Worldwide"). */
  serviceArea: "India",
  countriesServed: [
    "India",
    "United States",
    "United Arab Emirates",
    "United Kingdom",
    "Singapore",
  ] as const,
  socials: {
    linkedin: (process.env.NEXT_PUBLIC_LINKEDIN_URL ?? "").trim(),
    github: (process.env.NEXT_PUBLIC_GITHUB_URL ?? "").trim(),
    x: (process.env.NEXT_PUBLIC_X_URL ?? "").trim(),
  },
  defaultTitle: "StepZero | Custom SaaS & Software Development Studio (India)",
  defaultDescription:
    "StepZero is a custom SaaS and software development studio in India. We design and ship MVPs, productized tools, automation, and websites with clear scope and straight answers.",
} as const;

/** Contact alias kept for existing imports. */
export const contact = {
  brand: site.brand,
  siteUrl: site.siteUrl,
  email: site.email,
  whatsappE164: site.whatsappE164,
  country: site.country,
  city: site.city,
} as const;

export const bookingMessage =
  "Hi StepZero. I want to book a call about custom SaaS, MVP, or software development.";

export function whatsappBookingUrl(message = bookingMessage): string | null {
  if (!site.whatsappE164) return null;
  return `https://wa.me/${site.whatsappE164}?text=${encodeURIComponent(message)}`;
}

export function mailtoBookingUrl(message = bookingMessage): string {
  const subject = "Book a call - StepZero";
  return `mailto:${site.email}?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(message)}`;
}

/** Prefer WhatsApp when configured; otherwise mailto. */
export function primaryBookingUrl(message = bookingMessage): string {
  return whatsappBookingUrl(message) ?? mailtoBookingUrl(message);
}

/** Defined social profile URLs only (for JSON-LD sameAs). */
export function sameAsProfiles(): string[] {
  return [site.socials.linkedin, site.socials.github, site.socials.x].filter(
    Boolean,
  );
}

export function locationLabel(): string {
  if (site.city) return `${site.city}, ${site.country}`;
  return site.country;
}
