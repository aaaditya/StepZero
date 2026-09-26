import type { Metadata } from "next";
import Link from "next/link";
import { BookAppointment } from "../../components/BookAppointment";

export const metadata: Metadata = {
  title: "Work",
  description:
    "Example engagements from StepZero: custom SaaS, MVP, and operations platforms — illustrative case studies from our India studio.",
  alternates: { canonical: "/work" },
};

const cases = [
  {
    href: "/work/northside-clinic",
    title: "Northside Clinic",
    tag: "Custom SaaS · Healthcare ops",
    body: "Multi-location intake, routing, and staff dashboards that replaced spreadsheet chaos.",
  },
  {
    href: "/work/harbor-and-oak",
    title: "Harbor & Oak",
    tag: "Operations platform · Retail",
    body: "Order exceptions, vendor follow-ups, and a lightweight admin console for a growing retailer.",
  },
];

export default function WorkPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">Work</p>
        <h1>Example engagements</h1>
        <p className="lede">
          These case studies are framed as illustrative engagements — composites
          grounded in the kinds of custom SaaS and software problems we solve.
          Names and figures are representative, not client endorsements.
        </p>
      </header>

      <section className="section" aria-labelledby="cases-title">
        <div className="section-meta">
          <h2 id="cases-title">Selected stories</h2>
          <p className="lede">
            Focus on decision criteria, architecture choices, and outcomes you
            can evaluate against your own backlog.
          </p>
        </div>
        <ol className="index-list">
          {cases.map((item) => (
            <li key={item.href}>
              <span className="idx" aria-hidden="true" />
              <div>
                <p className="eyebrow">{item.tag}</p>
                <h3>
                  <Link href={item.href}>{item.title}</Link>
                </h3>
                <p>{item.body}</p>
              </div>
            </li>
          ))}
        </ol>
      </section>

      <section className="prose-block">
        <h2>What we look for in a fit</h2>
        <p>
          Clear operators who own the problem. A willingness to cut scope.
          Data and workflows that justify custom software rather than another
          subscription. If that sounds like you,{" "}
          <Link href="/contact">get in touch</Link> or browse{" "}
          <Link href="/services">services</Link>.
        </p>
      </section>

      <section className="book-band" aria-labelledby="work-book">
        <div>
          <h2 id="work-book">Start a conversation</h2>
          <p className="lede">
            Bring the constraint that hurts most. We will tell you whether it
            belongs in an MVP, custom SaaS, or a simpler automation pass.
          </p>
        </div>
        <BookAppointment className="book-btn--block" />
      </section>
    </main>
  );
}
