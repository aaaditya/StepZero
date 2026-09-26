import type { Metadata } from "next";
import Link from "next/link";
import { BookAppointment } from "../../../components/BookAppointment";

export const metadata: Metadata = {
  title: "Harbor & Oak — Example Engagement",
  description:
    "Illustrative StepZero engagement: operations platform for retail order exceptions, vendor follow-ups, and admin workflows.",
  alternates: { canonical: "/work/harbor-and-oak" },
};

export default function HarborAndOakPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">
          <Link href="/work">Work</Link> / Example engagement
        </p>
        <h1>Harbor &amp; Oak</h1>
        <p className="lede">
          An operations platform for a growing retailer — illustrative of how
          StepZero ships custom software when Shopify-plus-spreadsheets stops
          scaling.
        </p>
      </header>

      <article className="prose-block">
        <p className="callout">
          Illustrative example. Composite of retail operations work; not a
          named-client testimonial.
        </p>

        <h2>Context</h2>
        <p>
          Harbor &amp; Oak (representative name) sold through a mainstream
          commerce stack that handled checkout well and exceptions poorly.
          Partial shipments, vendor delays, and VIP replacements lived in
          shared inboxes. Every peak season, the same fire drills returned
          with more volume.
        </p>

        <h2>What we built</h2>
        <p>
          A lightweight operations console: exception queues by type, SLA
          timers, vendor follow-up templates, and a history attached to each
          order. Staff roles limited who could issue refunds versus who could
          only comment. Weekly digests showed which vendors and SKUs created
          the most exceptions — data that had previously been anecdotal.
        </p>
        <p>
          Integrations pulled order events from the commerce platform; the
          custom layer owned judgment workflows the vendor UI would never
          prioritize. That split kept the project honest: we were not
          rewriting commerce.
        </p>

        <h2>Approach</h2>
        <p>
          We started with the three exception types that burned the most hours,
          not a grand “OMS rewrite.” An{" "}
          <Link href="/services/mvp-development">MVP-style</Link> first release
          proved the queue model with one warehouse team, then expanded
          permissions and reporting. Automation handled nudges; humans kept
          the decisions that needed taste.
        </p>

        <h2>Results (representative)</h2>
        <ul className="plain-list">
          <li>Exception handling time per order down materially after queue discipline landed.</li>
          <li>Fewer VIP issues lost in email threads; every case had an owner and timestamp.</li>
          <li>Leadership finally saw vendor-level exception rates without manual compilation.</li>
        </ul>

        <h2>Takeaway</h2>
        <p>
          Custom software development pays when the workflow is unique and
          costly. Harbor &amp; Oak did not need another dashboard theme — they
          needed a system of record for messy reality. If that resonates, see{" "}
          <Link href="/services/custom-saas-development">
            custom SaaS development
          </Link>{" "}
          or{" "}
          <Link href="/services/automation">automation</Link>, and{" "}
          <Link href="/contact">contact StepZero</Link>.
        </p>
      </article>

      <section className="book-band" aria-labelledby="ho-book">
        <div>
          <h2 id="ho-book">Talk through your exceptions</h2>
          <p className="lede">
            Describe the cases that escape your current stack. We will propose
            a thin first release you can measure.
          </p>
        </div>
        <BookAppointment className="book-btn--block" />
      </section>
    </main>
  );
}
