"use client";

import { mailtoBookingUrl, whatsappBookingUrl } from "../lib/contact";

type Props = {
  label?: string;
  className?: string;
  id?: string;
};

/**
 * Opens WhatsApp (when configured) and starts an email in parallel.
 * No hover motion theater. Instant feedback via :active only.
 */
export function BookAppointment({
  label = "Book an appointment",
  className = "",
  id,
}: Props) {
  function handleClick() {
    const wa = whatsappBookingUrl();
    if (wa) {
      window.open(wa, "_blank", "noopener,noreferrer");
    }
    window.location.href = mailtoBookingUrl();
  }

  return (
    <button
      id={id}
      type="button"
      onClick={handleClick}
      className={`book-btn ${className}`.trim()}
    >
      {label}
    </button>
  );
}
