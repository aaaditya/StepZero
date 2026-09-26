import type { Metadata } from "next";
import Link from "next/link";
import { BookAppointment } from "../../../components/BookAppointment";

export const metadata: Metadata = {
  title: "Websites",
  description:
    "Website design and development from StepZero: clear marketing and product sites that explain the offer and make booking obvious.",
  alternates: { canonical: "/services/websites" },
};

export default function WebsitesPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">
          <Link href="/services">Services</Link> / Websites
        </p>
        <h1>Websites that explain and convert</h1>
        <p className="lede">
          Fast, readable sites for studios and operators who need trust online —
          matched to the custom software or service behind them.
        </p>
        <div className="hero__actions">
          <BookAppointment label="Book a website call" />
        </div>
      </header>

      <article className="prose-block">
        <h2>Sites as part of the product system</h2>
        <p>
          StepZero builds websites that answer the usual questions: what you
          do, who it is for, how engagement works, and how to start. We avoid
          template sameness and agency filler. Structure, typography, and
          performance matter because they affect whether a serious buyer stays
          long enough to book.
        </p>
        <p>
          When your real moat is{" "}
          <Link href="/services/custom-saas-development">custom SaaS</Link> or
          an operational platform, the site should not pretend you are a
          generic “digital agency.” Messaging and IA should point at the
          product truth — including paths into demos, waitlists, or{" "}
          <Link href="/contact">contact</Link>.
        </p>

        <h2>What delivery includes</h2>
        <p>
          Information architecture, copy collaboration, responsive
          implementation (typically Next.js), SEO basics (titles, canonicals,
          sitemap hooks), and a booking or inquiry path that actually works.
          We can pair the site with{" "}
          <Link href="/services/automation">automation</Link> so inquiries
          route correctly on day one.
        </p>
        <p>
          Hosting on modern CDNs keeps assets fast worldwide while the studio
          remains based in India — useful for teams selling locally and to
          clients abroad.
        </p>

        <h2>When a site is not enough</h2>
        <p>
          If the bottleneck is the product itself — multi-tenant workflows,
          billing, partner portals — a prettier homepage will not fix churn.
          We will say so and point you toward MVP or custom SaaS work. Many
          clients start with a sharp site and a thin product slice in parallel.
        </p>
      </article>

      <section className="book-band" aria-labelledby="web-book">
        <div>
          <h2 id="web-book">Brief a site</h2>
          <p className="lede">
            Share the offer, the audience, and any constraints (brand, CMS,
            timeline). We reply with a scoped plan.
          </p>
        </div>
        <BookAppointment className="book-btn--block" />
      </section>
    </main>
  );
}
