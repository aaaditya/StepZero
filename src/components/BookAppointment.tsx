import { BOOKING_URL, bookingCtaLabel } from "../lib/contact";

type Props = {
  label?: string;
  className?: string;
  id?: string;
};

/**
 * Primary booking CTA. Target lives in BOOKING_URL so a calendar
 * link can replace WhatsApp later without touching the UI.
 */
export function BookAppointment({
  label = bookingCtaLabel,
  className = "",
  id,
}: Props) {
  return (
    <a
      id={id}
      href={BOOKING_URL}
      className={`book-btn ${className}`.trim()}
      target="_blank"
      rel="noopener noreferrer"
    >
      {label}
    </a>
  );
}
