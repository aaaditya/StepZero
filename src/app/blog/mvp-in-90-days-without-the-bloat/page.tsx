import type { Metadata } from "next";
import Link from "next/link";
import { BookAppointment } from "../../../components/BookAppointment";

export const metadata: Metadata = {
  title: "MVP in 90 Days Without the Bloat",
  description:
    "A practical MVP development plan: discovery, cut lists, vertical slices, and foundations that grow into custom SaaS — from StepZero.",
  alternates: { canonical: "/blog/mvp-in-90-days-without-the-bloat" },
};

export default function BlogMvpPost() {
  return (
    <main className="page">
      <article>
        <header className="page-hero">
          <p className="page-kicker">
            <Link href="/blog">Blog</Link> · 22 Sep 2026
          </p>
          <h1>MVP in 90 days without the bloat</h1>
          <p className="lede">
            MVP development fails when “minimum” means “vague” and “viable”
            means “everything in the pitch deck.” Here is a tighter shape.
          </p>
        </header>

        <div className="prose-block">
          <h2>Define the job, not the feature zoo</h2>
          <p>
            Start with one primary user and one job they must complete without
            calling you. If you cannot say that sentence without commas, you
            are not ready to build — you are ready to interview. The MVP is the
            software that lets that job finish end-to-end: auth if required,
            the core objects, the happy path, and a way for you to see that it
            happened.
          </p>
          <p>
            Secondary dashboards, referral programs, and multi-currency edge
            cases feel productive. They usually delay learning. Write them on a
            dated parking lot. Revisit only after five real users complete the
            primary job.
          </p>

          <h2>A 90-day outline that survives contact</h2>
          <p>
            <strong>Days 1–14:</strong> discovery, written scope, cut list,
            architecture sketch, success metrics. Stakeholders sign the cut
            list. If they cannot, stop — calendar fiction helps no one.
          </p>
          <p>
            <strong>Days 15–60:</strong> vertical slices every one to two weeks.
            Each slice should be demoable: something a user can click, not only
            a schema migration. Prefer staging environments that mirror
            production enough to catch auth and env mistakes early.
          </p>
          <p>
            <strong>Days 61–90:</strong> harden the happy path, add the minimum
            admin visibility, write a one-page runbook, onboard a small cohort,
            instrument drop-offs. Decide whether the next investment is growth
            features or a deeper{" "}
            <Link href="/services/custom-saas-development">custom SaaS</Link>{" "}
            pass on tenancy and billing.
          </p>

          <h2>Foundations without framework tourism</h2>
          <p>
            Throwaway prototypes teach UI taste and little else. At the other
            extreme, six weeks of platform selection teaches nothing about
            users. Aim for boring, known stacks (for us, typically TypeScript
            and Next.js-centered web apps) with a clear data model. You should
            be able to add a second customer without a rewrite — even if
            onboarding is still manual.
          </p>
          <p>
            Integrations deserve skepticism. Every third-party API is a
            schedule risk. Mock what you can; integrate what the job truly
            requires. If messaging is core, build confirmation early. If
            messaging is nice, use email until the cohort complains.
          </p>

          <h2>Governance that keeps “MVP” honest</h2>
          <p>
            Appoint one product owner who can say no. Capture change requests in
            a single list with impact on date. Celebrate cuts. Teams that cannot
            cut will slip — then blame engineering. A studio partner should
            protect the cut list as fiercely as the codebase.
          </p>
          <p>
            StepZero runs{" "}
            <Link href="/services/mvp-development">MVP development</Link> this
            way from India for teams locally and abroad. Related:{" "}
            <Link href="/blog/why-custom-saas-beats-no-code-patchwork">
              why custom SaaS beats no-code patchwork
            </Link>
            . When you want a scoped plan,{" "}
            <Link href="/contact">contact us</Link>.
          </p>
        </div>
      </article>

      <section className="book-band" aria-labelledby="mvp-post-book">
        <div>
          <h2 id="mvp-post-book">Scope a 90-day MVP</h2>
          <p className="lede">
            Bring the user, the job, and the date that matters. We will return
            a cut list you can fund.
          </p>
        </div>
        <BookAppointment className="book-btn--block" />
      </section>
    </main>
  );
}
