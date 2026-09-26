import type { Metadata } from "next";
import Link from "next/link";
import { BookAppointment } from "../../components/BookAppointment";

export const metadata: Metadata = {
  title: "Products",
  description:
    "Productized tools from StepZero: intake routers, ops queues, and scoped SaaS starters — coming soon from our India studio.",
  alternates: { canonical: "/products" },
};

const tools = [
  {
    name: "Intake Router",
    status: "Concept",
    body: "A productized intake and routing layer for service businesses: required fields, SLA timers, and WhatsApp/email confirmations without rebuilding from scratch each time.",
  },
  {
    name: "Ops Exception Queue",
    status: "Concept",
    body: "A focused queue for order and ticket exceptions — owners, templates, and vendor nudges — designed to sit beside commerce or helpdesk tools you already use.",
  },
  {
    name: "SaaS Starter Kit",
    status: "Internal",
    body: "Our internal multi-tenant starter (auth, orgs, roles, audit basics) that accelerates custom SaaS builds. Not a public template — the opposite of one-size-fits-all.",
  },
];

export default function ProductsPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">Products</p>
        <h1>Productized tools (coming into focus)</h1>
        <p className="lede">
          StepZero primarily ships custom SaaS and software for clients. We are
          also shaping a few productized tools from patterns that repeat across
          engagements — so you can buy a sharper starting point when it fits.
        </p>
      </header>

      <section className="section" aria-labelledby="tools-title">
        <div className="section-meta">
          <h2 id="tools-title">On the roadmap</h2>
          <p className="lede">
            These are honest concepts, not vaporware landing pages with fake
            waitlist theater. If one matches your need, say so on a call — we
            may prioritize it or scope a custom cousin.
          </p>
        </div>
        <ol className="index-list">
          {tools.map((item) => (
            <li key={item.name}>
              <span className="idx" aria-hidden="true" />
              <div>
                <p className="eyebrow">{item.status}</p>
                <h3>{item.name}</h3>
                <p>{item.body}</p>
              </div>
            </li>
          ))}
        </ol>
      </section>

      <section className="prose-block">
        <h2>Custom still comes first</h2>
        <p>
          Most teams that find us need a system shaped to their domain. See{" "}
          <Link href="/services/custom-saas-development">
            custom SaaS development
          </Link>{" "}
          and{" "}
          <Link href="/services/mvp-development">MVP development</Link>.
          Products will package the boring 60% when that packaging helps —
          never when it forces the wrong model.
        </p>
      </section>

      <section className="book-band" aria-labelledby="prod-book">
        <div>
          <h2 id="prod-book">Influence the roadmap</h2>
          <p className="lede">
            Tell us which tool would remove the most pain. If we are not
            shipping it yet, we can still build your version as a scoped
            engagement.
          </p>
        </div>
        <BookAppointment className="book-btn--block" />
      </section>
    </main>
  );
}
