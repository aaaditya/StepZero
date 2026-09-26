import type { Metadata } from "next";
import Link from "next/link";
import { BookAppointment } from "../../../components/BookAppointment";

export const metadata: Metadata = {
  title: "Automation & Workflows",
  description:
    "Business automation from StepZero: intake, WhatsApp confirmations, CRM sync, and workflows that replace brittle no-code mazes.",
  alternates: { canonical: "/services/automation" },
};

export default function AutomationPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">
          <Link href="/services">Services</Link> / Automation
        </p>
        <h1>Automation &amp; workflows that hold up</h1>
        <p className="lede">
          Connect intake, messaging, CRMs, and internal tools so follow-ups
          and routing stop depending on one person&apos;s memory.
        </p>
        <div className="hero__actions">
          <BookAppointment label="Book an automation call" />
        </div>
      </header>

      <article className="prose-block">
        <h2>What we automate</h2>
        <p>
          Most operators do not need “AI transformation.” They need a clean
          path from inquiry to confirmation to the right human. We design
          automation for lead intake, WhatsApp or email confirmations,
          appointment reminders, CRM updates, document collection, and internal
          alerts when something stalls.
        </p>
        <p>
          We prefer durable integrations and clear ownership of data over a
          spiderweb of one-off Zaps. When the workflow is the product —
          multi-step approvals, client portals, role-based routing — we often
          recommend graduating into{" "}
          <Link href="/services/custom-saas-development">
            custom SaaS development
          </Link>{" "}
          rather than stretching no-code past its limits.
        </p>

        <h2>Signs your stack is ready for a rethink</h2>
        <p>
          You cannot answer “where did this lead come from?” without opening
          three apps. Permissions are shared passwords. A vendor rate limit or
          a renamed spreadsheet column breaks the week. Staff invent parallel
          WhatsApp groups because the “official” system is too slow. Those are
          automation and software problems — not motivation problems.
        </p>
        <p>
          StepZero maps the current path, kills redundant steps, and implements
          a version that is observable: you can see failures, retry safely,
          and change a rule without rewriting everything.
        </p>

        <h2>How this pairs with websites and MVPs</h2>
        <p>
          A{" "}
          <Link href="/services/websites">website</Link> that captures demand
          without routing is only half the job. An{" "}
          <Link href="/services/mvp-development">MVP</Link> that cannot notify
          the right operator will frustrate early users. We often ship a thin
          site or product surface together with the workflow behind it so the
          demo matches reality.
        </p>
        <p>
          Based in India, we work with teams that need reliable English
          communication and written runbooks — so the automation survives
          staff turnover.
        </p>
      </article>

      <section className="book-band" aria-labelledby="auto-book">
        <div>
          <h2 id="auto-book">Map a workflow</h2>
          <p className="lede">
            Send us the messy current path. We will mark what to automate, what
            to leave human, and what belongs in custom software.
          </p>
        </div>
        <BookAppointment className="book-btn--block" />
      </section>
    </main>
  );
}
