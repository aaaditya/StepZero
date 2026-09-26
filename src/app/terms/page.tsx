import type { Metadata } from "next";
import Link from "next/link";
import { site } from "../../lib/site";

export const metadata: Metadata = {
  title: "Terms of Service",
  description:
    "Terms of service for StepZero custom SaaS and software development engagements.",
  alternates: { canonical: "/terms" },
};

export default function TermsPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">Legal</p>
        <h1>Terms of service</h1>
        <p className="lede">
          Last updated 10 Sep 2026. These terms cover strategy, design, web,
          automation, and custom software work from StepZero.
        </p>
      </header>

      <article className="legal prose-block">
        <h2>Scope</h2>
        <p>
          StepZero provides strategy, design, web, automation, and custom
          software development services under written proposals. Work starts
          after both parties confirm scope, timeline, and fees in writing.
        </p>
        <h2>Payment</h2>
        <p>
          Invoices are due as stated in the proposal. Late balances may pause
          delivery until cleared. Third-party tools (hosting, messaging, ads,
          cloud infrastructure) are billed to the client unless noted otherwise.
        </p>
        <h2>Intellectual property</h2>
        <p>
          Finished deliverables transfer to the client after final payment.
          StepZero may show anonymized process and outcomes in its portfolio
          unless a written NDA says otherwise. Pre-existing tools, libraries,
          and internal starters remain StepZero property; clients receive a
          license to use them as embedded in deliverables.
        </p>
        <h2>Limitation</h2>
        <p>
          We do not guarantee specific revenue outcomes. Results depend on
          offer quality, operations, and demand outside our control. Liability
          is limited to fees paid for the engagement giving rise to the claim,
          except where law requires otherwise.
        </p>
        <h2>Contact</h2>
        <p>
          Questions:{" "}
          <a href={`mailto:${site.email}`}>{site.email}</a>. See also{" "}
          <Link href="/privacy">Privacy</Link> and{" "}
          <Link href="/contact">Contact</Link>.
        </p>
      </article>
    </main>
  );
}
