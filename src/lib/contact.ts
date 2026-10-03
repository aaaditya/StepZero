/** Public contact channels for StepZero. */

const fromEnv = (process.env.NEXT_PUBLIC_WHATSAPP_E164 ?? "").replace(/\D/g, "");

export const contact = {
  brand: "StepZero",
  siteUrl: "https://thestepzero.in",
  email: "info@thestepzero.in",
  /** E.164 digits. Defaults to the public WhatsApp line. */
  whatsappE164: fromEnv || "918955025519",
  phoneDisplay: "+91 89550 25519",
} as const;

export const whatsappUrl = `https://wa.me/${contact.whatsappE164}`;

export const emailUrl = `mailto:${contact.email}`;

export const bookingMessage =
  "Hi StepZero, I'd like to book a free 15-min call about a project.";

export const bookingCtaLabel = "Book a free 15-min call";

/**
 * Single booking target used by every primary CTA.
 * Swap this constant for a Cal.com or Calendly URL later.
 */
export const BOOKING_URL = `${whatsappUrl}?text=${encodeURIComponent(bookingMessage)}`;
