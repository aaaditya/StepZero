import type { Metadata } from "next";
import Link from "next/link";
import { locationLabel, site } from "../../lib/site";

export const metadata: Metadata = {
  title: "Privacy Policy",
  description:
    "Privacy policy for StepZero — how we handle contact and project data.",
  alternates: { canonical: "/privacy" },
};

export default function PrivacyPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">Legal</p>
        <h1>Privacy policy</h1>
        <p className="lede">
          Last updated 10 Sep 2026. How StepZero handles information when you
          contact us or engage our services.
        </p>
      </header>

      <article className="legal prose-block">
        <h2>Data we collect</h2>
        <p>
          When you book via WhatsApp or email, we receive the message content,
          your phone or email address, and basic metadata from those providers.
          Site analytics, if enabled, use privacy-respecting aggregate metrics.
        </p>
        <h2>Use</h2>
        <p>
          Contact data is used only to reply, schedule, and deliver services.
          We do not sell personal data.
        </p>
        <h2>Retention</h2>
        <p>
          Project records are kept for the duration of the engagement and for
          lawful accounting needs afterward. You can request deletion of
          non-required records by emailing{" "}
          <a href={`mailto:${site.email}`}>{site.email}</a>.
        </p>
        <h2>Operator</h2>
        <p>
          Privacy questions: {site.email}. Operator: StepZero, operating from{" "}
          {locationLabel()}, serving clients in{" "}
          {site.countriesServed.join(", ")}.
        </p>
        <p>
          <Link href="/terms">Terms of service</Link> ·{" "}
          <Link href="/contact">Contact</Link>
        </p>
      </article>
    </main>
  );
}
