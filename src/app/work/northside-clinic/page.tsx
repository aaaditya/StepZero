import type { Metadata } from "next";
import Link from "next/link";
import { BookAppointment } from "../../../components/BookAppointment";

export const metadata: Metadata = {
  title: "Northside Clinic — Example Engagement",
  description:
    "Illustrative StepZero engagement: custom SaaS for multi-location clinic intake, routing, and staff dashboards.",
  alternates: { canonical: "/work/northside-clinic" },
};

export default function NorthsideClinicPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">
          <Link href="/work">Work</Link> / Example engagement
        </p>
        <h1>Northside Clinic</h1>
        <p className="lede">
          Custom SaaS for multi-location intake and routing — an illustrative
          engagement showing how StepZero turns operational chaos into a
          product operators can run daily.
        </p>
      </header>

      <article className="prose-block">
        <p className="callout">
          Illustrative example. Details are representative of clinic-ops SaaS
          work; not a named-client testimonial.
        </p>

        <h2>Context</h2>
        <p>
          A growing multi-location clinic group was losing inquiries between
          WhatsApp, a generic form tool, and front-desk spreadsheets. Each
          location invented its own follow-up habit. Leadership could not see
          conversion by source or time-to-first-response. Hiring more staff
          did not fix the missing system of record.
        </p>

        <h2>What we built</h2>
        <p>
          A focused custom SaaS layer: patient/inquiry intake with required
          fields, location-aware routing, role-based staff queues, status
          timelines, and simple reporting on response SLA. Messaging stayed
          where patients already were (WhatsApp/email confirmations), but the
          source of truth moved into the product. Admin users could reassign
          work and audit who touched a record.
        </p>
        <p>
          We deliberately did not rebuild the entire EHR. The product owned
          the front-of-funnel and internal routing — the expensive gap — and
          exported cleanly into existing clinical systems where needed.
        </p>

        <h2>Approach</h2>
        <p>
          Two weeks of discovery with desk staff and managers produced a written
          state machine for inquiry statuses. Engineering shipped in vertical
          slices: intake → queue → confirmation → weekly report. Training
          materials were one-pagers, not a 40-page PDF. After launch, we
          watched failure rates on automations and tightened validation that
          had been informal on paper forms.
        </p>

        <h2>Results (representative)</h2>
        <ul className="plain-list">
          <li>Median time-to-first-response cut from hours to under 15 minutes during staffed windows.</li>
          <li>Duplicate lead records dropped sharply once phone/email uniqueness was enforced.</li>
          <li>Location managers stopped maintaining parallel spreadsheets within one quarter.</li>
        </ul>

        <h2>Why this is a custom SaaS problem</h2>
        <p>
          Horizontal form tools could capture fields. They could not encode
          clinic-specific routing, permissions across locations, or the audit
          trail compliance-minded operators expect. That is the line where{" "}
          <Link href="/services/custom-saas-development">
            custom SaaS development
          </Link>{" "}
          beats another no-code stack. Related reading:{" "}
          <Link href="/blog/why-custom-saas-beats-no-code-patchwork">
            why custom SaaS beats no-code patchwork
          </Link>
          .
        </p>
      </article>

      <section className="book-band" aria-labelledby="ns-book">
        <div>
          <h2 id="ns-book">Have a similar ops gap?</h2>
          <p className="lede">
            Tell us how inquiries move today. We will sketch whether a workflow
            pass or a full product slice is the right first milestone.
          </p>
        </div>
        <BookAppointment className="book-btn--block" />
      </section>
    </main>
  );
}
