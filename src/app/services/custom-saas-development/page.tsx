import type { Metadata } from "next";
import Link from "next/link";
import { BookAppointment } from "../../../components/BookAppointment";

export const metadata: Metadata = {
  title: "Custom SaaS Development",
  description:
    "Custom SaaS development from StepZero in India: multi-tenant products, roles, billing hooks, and admin tooling built for your domain.",
  alternates: { canonical: "/services/custom-saas-development" },
};

export default function CustomSaasPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">
          <Link href="/services">Services</Link> / Custom SaaS
        </p>
        <h1>Custom SaaS development</h1>
        <p className="lede">
          When your product is the business — or your operations need software
          that vendors will never prioritize — we design and ship custom SaaS
          from our studio in India.
        </p>
        <div className="hero__actions">
          <BookAppointment label="Book a SaaS scoping call" />
        </div>
      </header>

      <article className="prose-block">
        <h2>What “custom SaaS” means here</h2>
        <p>
          Custom SaaS development is not a marketing site with a login button.
          It is a product with accounts, roles, data isolation, workflows, and
          the admin surfaces you need to run the business. We focus on the
          domain model first: who can see what, how work moves between states,
          and which events matter enough to notify, bill, or audit.
        </p>
        <p>
          Typical builds include customer portals, partner dashboards,
          scheduling and intake systems, inventory and fulfillment tools, and
          vertical SaaS for a niche you already understand better than any
          horizontal vendor. We ship on modern web stacks (Next.js and related
          Node/TypeScript tooling) with hosting that matches your security and
          cost constraints.
        </p>

        <h2>Problems we solve with custom software</h2>
        <p>
          Teams come to us when spreadsheets and Zapier start losing money:
          permissions are informal, reporting is manual, and every new client
          means another fragile configuration. Custom software development
          fixes the core loop — create, assign, complete, bill, report — so
          growth does not multiply chaos.
        </p>
        <p>
          We also build SaaS that you sell. If you are productizing an agency
          service or an internal tool, we help you define tenancy, onboarding,
          pricing hooks, and the first admin console. The goal is a product
          you can demo, onboard, and iterate — not a prototype that collapses
          under a second customer.
        </p>

        <h2>How an engagement runs</h2>
        <ol className="index-list prose-steps">
          <li>
            <span className="idx" aria-hidden="true" />
            <div>
              <h3>Discovery &amp; boundaries</h3>
              <p>
                We map users, permissions, and the smallest set of workflows that
                create value. Out of scope is written down early so timelines
                stay honest.
              </p>
            </div>
          </li>
          <li>
            <span className="idx" aria-hidden="true" />
            <div>
              <h3>Architecture &amp; milestones</h3>
              <p>
                Data model, auth approach, and release slices. You see working
                software on a cadence, not a big reveal after months of silence.
              </p>
            </div>
          </li>
          <li>
            <span className="idx" aria-hidden="true" />
            <div>
              <h3>Ship, hand over, optionally retain</h3>
              <p>
                Docs, admin runbooks, and a path for support. Many clients start
                with a build and only then decide what ongoing product work they
                want.
              </p>
            </div>
          </li>
        </ol>

        <h2>India-based studio, products that travel</h2>
        <p>
          StepZero operates from India and collaborates with clients across
          India, the United States, the UAE, the United Kingdom, and Singapore.
          We write and speak in English, work in clear tickets and async
          updates, and treat timezone overlap as a planning constraint — not an
          excuse for vague status.
        </p>
        <p>
          If you need a lighter first step, see{" "}
          <Link href="/services/mvp-development">MVP development</Link> or{" "}
          <Link href="/services/automation">automation</Link>. For outcomes in
          practice, browse{" "}
          <Link href="/work">example engagements</Link>.
        </p>
      </article>

      <section className="book-band" aria-labelledby="saas-book">
        <div>
          <h2 id="saas-book">Discuss a custom SaaS build</h2>
          <p className="lede">
            Bring the problem, the users, and any tools you already pay for. We
            will say whether custom SaaS is warranted — and what a first
            milestone should prove.
          </p>
        </div>
        <BookAppointment className="book-btn--block" />
      </section>
    </main>
  );
}
