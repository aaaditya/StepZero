/** Public contact channels for StepZero. */
export const contact = {
  brand: "StepZero",
  siteUrl: "https://thestepzero.in",
  email: "info@thestepzero.in",
  /** E.164 digits only. Set via NEXT_PUBLIC_WHATSAPP_E164 on Vercel. */
  whatsappE164: (process.env.NEXT_PUBLIC_WHATSAPP_E164 ?? "").replace(
    /\D/g,
    "",
  ),
} as const;

export const bookingMessage =
  "Hi StepZero. I want to book an appointment to discuss web, automation, or tech help.";

export function whatsappBookingUrl(message = bookingMessage): string | null {
  if (!contact.whatsappE164) return null;
  return `https://wa.me/${contact.whatsappE164}?text=${encodeURIComponent(message)}`;
}

export function mailtoBookingUrl(message = bookingMessage): string {
  const subject = "Book an appointment - StepZero";
  return `mailto:${contact.email}?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(message)}`;
}
