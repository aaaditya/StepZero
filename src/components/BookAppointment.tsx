import { primaryBookingUrl, whatsappBookingUrl } from "../lib/site";

type Props = {
  label?: string;
  className?: string;
  id?: string;
};

/**
 * Real booking link: WhatsApp when NEXT_PUBLIC_WHATSAPP_E164 is set, else mailto.
 * No onClick theater — crawlable `<a href>`.
 */
export function BookAppointment({
  label = "Book a call",
  className = "",
  id,
}: Props) {
  const href = primaryBookingUrl();
  const isWhatsApp = Boolean(whatsappBookingUrl());

  return (
    <a
      id={id}
      href={href}
      className={`book-btn ${className}`.trim()}
      {...(isWhatsApp
        ? { target: "_blank", rel: "noopener noreferrer" }
        : {})}
    >
      {label}
    </a>
  );
}
