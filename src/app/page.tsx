import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import dynamic from "next/dynamic";
import { BookAppointment } from "../components/BookAppointment";
import { site } from "../lib/site";

const IntakeDemo = dynamic(
  () => import("../components/IntakeDemo").then((m) => m.IntakeDemo),
  {
    loading: () => (
      <section className="demo" aria-labelledby="demo-title">
        <div className="section-meta">
          <h2 id="demo-title">Intake preview</h2>
          <p className="lede">Loading demo…</p>
        </div>
      </section>
    ),
  },
);

export const metadata: Metadata = {
  title: {
    absolute: site.defaultTitle,
  },
  description: site.defaultDescription,
  alternates: { canonical: "/" },
};

const pillars = [
  {
    href: "/services/custom-saas-development",
    title: "Custom SaaS development",
    body: "Multi-tenant products, billing, roles, and admin surfaces built for how your customers actually work — not a template bolted onto a spreadsheet.",
  },
  {
    href: "/services/mvp-development",
    title: "MVP development",
    body: "A focused first release in weeks, not quarters. Scope that survives contact with users, with instrumentation so you know what to build next.",
  },
  {
    href: "/services/automation",
    title: "Automation & workflows",
    body: "Intake, WhatsApp confirmations, CRM sync, and follow-ups that remove busywork without locking you into a brittle no-code maze.",
  },
  {
    href: "/services/websites",
    title: "Websites that convert",
    body: "Clear sites for studios and operators who need trust online — message, structure, and booking paths that match the product behind them.",
  },
];

const why = [
  {
    title: "Studio, not body shop",
    body: "You work with people who own scope, architecture, and delivery — not a rotating bench that disappears after kickoff.",
  },
  {
    title: "India-based, globally usable",
    body: `We operate from ${site.serviceArea} and ship for clients in ${site.countriesServed.slice(0, 3).join(", ")}, and more. Time zones work; English is the working language.`,
  },
  {
    title: "Clear scope on day one",
    body: "Written plans, fixed milestones where they fit, and honest tradeoffs. No mystery retainers before we understand the problem.",
  },
];

export default function HomePage() {
  return (
    <main>
      <section className="hero" aria-label="Introduction">
        <div className="hero__copy">
          <h1>Custom SaaS & software development from India</h1>
          <p className="hero__statement">
            StepZero designs and ships custom SaaS products, MVPs, automation,
            and websites. Clear scope. Straight answers. Work that ships.
          </p>
          <div className="hero__actions">
            <BookAppointment label="Book a call" />
            <Link className="book-btn book-btn--ghost" href="/services">
              View services
            </Link>
          </div>
        </div>
        <figure className="hero__media">
          <Image
            src="/hero-utility-desk.png"
            alt="Laptop and notebook on a clean desk — StepZero custom SaaS and software development workspace"
            width={1280}
            height={720}
            priority
            sizes="(max-width: 860px) 100vw, 48vw"
            style={{ width: "100%", height: "auto" }}
          />
        </figure>
      </section>

      <section className="section" aria-labelledby="pillars-title">
        <div className="section-meta">
          <h2 id="pillars-title">What we build</h2>
          <p className="lede">
            Custom software when off-the-shelf tools force workarounds. Product
            thinking when you need more than a brochure site.
          </p>
        </div>
        <ol className="index-list">
          {pillars.map((item) => (
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

      <section className="section" aria-labelledby="why-title">
        <div className="section-meta">
          <h2 id="why-title">Why teams hire StepZero</h2>
          <p className="lede">
            Founders and operators who need a durable product — not another
            agency deck — use us as their software partner.
          </p>
        </div>
        <ol className="index-list">
          {why.map((item) => (
            <li key={item.title}>
              <span className="idx" aria-hidden="true" />
              <div>
                <h3>{item.title}</h3>
                <p>{item.body}</p>
              </div>
            </li>
          ))}
        </ol>
      </section>

      <section className="section" aria-labelledby="work-peek-title">
        <div className="section-meta">
          <h2 id="work-peek-title">Example engagements</h2>
          <p className="lede">
            Illustrative case studies that show how we scope custom SaaS, MVP
            builds, and operational systems.
          </p>
        </div>
        <ul className="cardless-list">
          <li>
            <Link href="/work/northside-clinic">
              Northside Clinic — intake SaaS for multi-location care
            </Link>
          </li>
          <li>
            <Link href="/work/harbor-and-oak">
              Harbor &amp; Oak — operations platform for a growing retailer
            </Link>
          </li>
        </ul>
        <p className="page-cta-line">
          <Link href="/work">See all work →</Link>
        </p>
      </section>

      <div id="demo">
        <IntakeDemo />
      </div>

      <section className="book-band" id="book" aria-labelledby="book-title">
        <div>
          <h2 id="book-title">Ready to talk scope?</h2>
          <p className="lede">
            Tell us what you are building, who it is for, and where you are
            stuck. We reply with times and a short plan of what to clarify
            first. Legal:{" "}
            <Link href="/terms">Terms</Link> · <Link href="/privacy">Privacy</Link>.
          </p>
        </div>
        <BookAppointment className="book-btn--block" label="Book a call" />
      </section>
    </main>
  );
}
