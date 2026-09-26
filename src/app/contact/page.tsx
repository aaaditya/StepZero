import type { Metadata } from "next";
import { BookAppointment } from "../../components/BookAppointment";
import {
  locationLabel,
  mailtoBookingUrl,
  site,
  whatsappBookingUrl,
} from "../../lib/site";

export const metadata: Metadata = {
  title: "Contact",
  description:
    "Contact StepZero for custom SaaS and software development. Book via WhatsApp or email — studio based in India.",
  alternates: { canonical: "/contact" },
};

export default function ContactPage() {
  const wa = whatsappBookingUrl();
  const mail = mailtoBookingUrl();

  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">Contact</p>
        <h1>Book a call with StepZero</h1>
        <p className="lede">
          Tell us what you are building or fixing. We reply with times and the
          questions that unlock a clear first milestone.
        </p>
      </header>

      <section className="section contact-grid" aria-labelledby="channels-title">
        <div className="section-meta">
          <h2 id="channels-title">Reach us directly</h2>
          <p className="lede">
            Real links — no contact-form black hole. Prefer WhatsApp when the
            number is configured; email always works.
          </p>
        </div>
        <ul className="cardless-list contact-list">
          <li>
            <span className="eyebrow">Email</span>
            <a href={`mailto:${site.email}`}>{site.email}</a>
            <p>Best for longer briefs and attachments.</p>
          </li>
          <li>
            <span className="eyebrow">WhatsApp</span>
            {wa ? (
              <a href={wa} target="_blank" rel="noopener noreferrer">
                Message StepZero on WhatsApp
              </a>
            ) : (
              <p>
                WhatsApp booking unlocks when{" "}
                <code>NEXT_PUBLIC_WHATSAPP_E164</code> is set on the server.
                Until then, use email or the button below (mailto).
              </p>
            )}
            <p>Fast for scheduling and short scope questions.</p>
          </li>
          <li>
            <span className="eyebrow">Location</span>
            <p>
              {locationLabel()}
              {site.city ? "" : " (service area; city configurable)"}
            </p>
            <p>
              Clients in {site.countriesServed.join(", ")}. We are not a
              “worldwide” placeholder — these are the markets we actively serve.
            </p>
          </li>
        </ul>
      </section>

      <section className="prose-block">
        <h2>What to include</h2>
        <p>
          Who the user is, what hurts today, what “done” means in 60–90 days,
          and any hard constraints (compliance, integrations, launch date).
          Links to current tools help. A polished deck does not.
        </p>
        <p>
          Primary booking link (WhatsApp when available, otherwise email):
        </p>
        <p>
          <a href={wa ?? mail} {...(wa ? { target: "_blank", rel: "noopener noreferrer" } : {})}>
            {wa ? "Open WhatsApp booking" : `Email ${site.email}`}
          </a>
        </p>
      </section>

      <section className="book-band" aria-labelledby="contact-book">
        <div>
          <h2 id="contact-book">Start the thread</h2>
          <p className="lede">
            One tap opens the preferred channel with a short starter message
            you can edit.
          </p>
        </div>
        <BookAppointment className="book-btn--block" label="Book a call" />
      </section>
    </main>
  );
}
