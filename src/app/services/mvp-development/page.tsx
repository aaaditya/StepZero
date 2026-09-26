import type { Metadata } from "next";
import Link from "next/link";
import { BookAppointment } from "../../../components/BookAppointment";

export const metadata: Metadata = {
  title: "MVP Development",
  description:
    "MVP development with StepZero: ship a focused first product in weeks, with architecture that can grow — custom software from India.",
  alternates: { canonical: "/services/mvp-development" },
};

export default function MvpPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">
          <Link href="/services">Services</Link> / MVP
        </p>
        <h1>MVP development without the bloat</h1>
        <p className="lede">
          A useful first release for founders who need users and evidence — not
          a six-month rewrite of every feature they imagined in a pitch deck.
        </p>
        <div className="hero__actions">
          <BookAppointment label="Book an MVP call" />
        </div>
      </header>

      <article className="prose-block">
        <h2>What a StepZero MVP includes</h2>
        <p>
          MVP development here means the smallest product that real people can
          complete a job with: authentication where needed, the primary
          workflow end-to-end, basic admin or ops visibility, and enough
          instrumentation to see whether the thesis is wrong. We deliberately
          defer secondary dashboards, multi-currency edge cases, and “nice”
          polish that does not change learning.
        </p>
        <p>
          We still care about foundations. Throwaway prototypes that cannot
          accept a second customer waste the money you spent proving anything.
          Our MVPs use clear data models and deployable stacks so the path to
          custom SaaS maturity is incremental, not a restart.
        </p>

        <h2>When MVP development is the right call</h2>
        <p>
          You have a specific user and a painful job-to-be-done. You can talk
          to ten of them this month. You need something they can click —
          not another Notion doc. You are willing to cut features that do not
          test the core risk. If those are true, a focused build beats endless
          no-code patchwork that cannot enforce rules or scale permissions.
        </p>
        <p>
          If you already have paying customers and operational chaos, you may
          need{" "}
          <Link href="/services/custom-saas-development">
            custom SaaS development
          </Link>{" "}
          more than a greenfield MVP. We help you decide which.
        </p>

        <h2>A practical 90-day shape</h2>
        <p>
          Many engagements fit a roughly 90-day arc: weeks 1–2 for discovery and
          written scope; weeks 3–8 for the core loop and staging demos; weeks
          9–12 for hardening, onboarding, and handoff. Exact calendars depend
          on integrations and how available decision-makers are. We publish
          milestones in writing so “MVP” does not quietly expand into a year.
        </p>
        <p>
          Read more in our post{" "}
          <Link href="/blog/mvp-in-90-days-without-the-bloat">
            MVP in 90 days without the bloat
          </Link>
          , or compare with{" "}
          <Link href="/blog/why-custom-saas-beats-no-code-patchwork">
            why custom SaaS beats no-code patchwork
          </Link>
          .
        </p>

        <h2>Working with a studio in India</h2>
        <p>
          StepZero is based in India and builds MVPs for teams locally and
          internationally. You get English-first collaboration, async updates,
          and a bias toward shipping over ceremony. We are not a marketplace
          freelancing bench — you talk to the people designing and implementing
          the system.
        </p>
      </article>

      <section className="book-band" aria-labelledby="mvp-book">
        <div>
          <h2 id="mvp-book">Scope an MVP</h2>
          <p className="lede">
            Share the user, the job, and the deadline that matters. We return
            with a cut list and a first milestone you can fund with confidence.
          </p>
        </div>
        <BookAppointment className="book-btn--block" />
      </section>
    </main>
  );
}
