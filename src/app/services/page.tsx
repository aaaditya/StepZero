import type { Metadata } from "next";
import Link from "next/link";
import { BookAppointment } from "../../components/BookAppointment";

export const metadata: Metadata = {
  title: "Services",
  description:
    "StepZero services: custom SaaS development, MVP builds, business automation, and websites — from a software studio in India.",
  alternates: { canonical: "/services" },
};

const services = [
  {
    href: "/services/custom-saas-development",
    title: "Custom SaaS development",
    body: "Design and ship multi-tenant products with auth, roles, billing hooks, and admin tooling matched to your domain — not a generic CRUD shell.",
  },
  {
    href: "/services/mvp-development",
    title: "MVP development",
    body: "Validate the smallest useful product with real users. Architecture that can grow, without six months of framework tourism before the first login.",
  },
  {
    href: "/services/automation",
    title: "Automation & workflows",
    body: "Connect forms, messaging, CRMs, and internal tools so intake and follow-up stop living in someone's head or a fragile Zapier chain.",
  },
  {
    href: "/services/websites",
    title: "Websites",
    body: "Marketing and product sites that explain the offer, answer objections, and make booking or signup obvious — fast, readable, and maintainable.",
  },
];

export default function ServicesPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">Services</p>
        <h1>Custom software services that ship</h1>
        <p className="lede">
          StepZero is a custom SaaS and software development studio based in
          India. We help founders and operators turn messy operational reality
          into products, MVPs, and workflows they can run without us in the room.
        </p>
      </header>

      <section className="section" aria-labelledby="svc-list-title">
        <div className="section-meta">
          <h2 id="svc-list-title">How we typically engage</h2>
          <p className="lede">
            Most work starts with a scoped build. Retainers come later, after
            the system exists and you know what continuous support looks like.
          </p>
        </div>
        <ol className="index-list">
          {services.map((item) => (
            <li key={item.href}>
              <span className="idx" aria-hidden="true" />
              <div>
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
        <h2>Custom SaaS vs. bolting tools together</h2>
        <p>
          Off-the-shelf SaaS is excellent until your process no longer fits the
          vendor&apos;s opinion of how work should happen. That is when teams
          pile on Zapier, Airtable, and tribal knowledge — and still cannot
          report accurately or enforce permissions. Custom SaaS development is
          the point where the software becomes the product (or the operating
          system of the business), not a pile of integrations.
        </p>
        <p>
          We do not push custom for its own sake. If a standard stack covers
          90% of the job, we say so. When the remaining 10% is the business,
          we build that core properly: data models, access control, audit
          trails, and the surfaces your staff and customers touch daily.
        </p>
        <h2>Who this is for</h2>
        <p>
          Operators with revenue and a clear bottleneck. Founders who need an
          MVP that investors and early customers can use. Teams in India and
          abroad who want English-first collaboration and written scope —
          without agency theater.
        </p>
        <p>
          Explore{" "}
          <Link href="/work">example engagements</Link>, read about our{" "}
          <Link href="/about">studio</Link>, or{" "}
          <Link href="/contact">contact us</Link> to book a call.
        </p>
      </section>

      <section className="book-band" aria-labelledby="svc-book">
        <div>
          <h2 id="svc-book">Not sure which service fits?</h2>
          <p className="lede">
            Describe the problem in a few sentences. We will tell you whether
            custom SaaS, an MVP spike, automation, or a site is the right first
            move.
          </p>
        </div>
        <BookAppointment className="book-btn--block" />
      </section>
    </main>
  );
}
