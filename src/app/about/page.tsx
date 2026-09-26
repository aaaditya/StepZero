import type { Metadata } from "next";
import Link from "next/link";
import { BookAppointment } from "../../components/BookAppointment";
import { locationLabel, site } from "../../lib/site";

export const metadata: Metadata = {
  title: "About",
  description:
    "About StepZero: a custom SaaS and software development studio in India — clear scope, product thinking, different from other StepZero brands.",
  alternates: { canonical: "/about" },
};

export default function AboutPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">About</p>
        <h1>A software studio for operators who need the real system</h1>
        <p className="lede">
          StepZero builds custom SaaS, MVPs, automation, and websites from{" "}
          {locationLabel()}. We care about shipped software more than decks.
        </p>
      </header>

      <article className="prose-block">
        <h2>Who we are</h2>
        <p>
          StepZero is a small studio focused on custom software development for
          founders and operators. We sit in the uncomfortable middle: too
          product-minded for a pure outsourcing bench, too delivery-minded for
          a strategy-only consultancy. You hire us to design the system and
          actually put it in production.
        </p>
        <p>
          Our working base is India. We collaborate with clients in{" "}
          {site.countriesServed.join(", ")}. English is the working language.
          Updates are written. Scope is written. Surprises are discussed early.
        </p>

        <h2>Not the other StepZeros</h2>
        <p>
          The name “StepZero” appears in other markets and niches. This site —
          <strong> thestepzero.in</strong> — is the custom SaaS and software
          development studio described here. If you found us looking for
          websites, automation, or tech help, you are in the right place; those
          remain part of how we ship. If you expected a different company with
          a similar name, check the domain and contact email (
          {site.email}) before assuming continuity.
        </p>

        <h2>How we think about software</h2>
        <p>
          Off-the-shelf tools win until your process is the product. Then you
          either accept permanent workarounds or invest in custom SaaS that
          encodes how you actually work. We help you make that call without
          ego: sometimes the answer is better{" "}
          <Link href="/services/automation">automation</Link>; sometimes it is
          an{" "}
          <Link href="/services/mvp-development">MVP</Link>; sometimes it is a
          multi-tenant product. See{" "}
          <Link href="/services">services</Link> and{" "}
          <Link href="/work">example engagements</Link>.
        </p>

        <h2>Working style</h2>
        <p>
          Short discovery. Written milestones. Demos on a cadence. Hand-over
          that includes how to operate the thing. We decline work that needs
          theater more than engineering — vanity rebuilds, undefined “AI
          platforms,” or scopes that refuse a cut list.
        </p>
        <p>
          Ready to talk?{" "}
          <Link href="/contact">Contact</Link> via WhatsApp or email, or book
          below.
        </p>
      </article>

      <section className="book-band" aria-labelledby="about-book">
        <div>
          <h2 id="about-book">Meet the studio</h2>
          <p className="lede">
            A short call is enough to know if we are a fit. Bring the problem,
            not a 40-page RFP.
          </p>
        </div>
        <BookAppointment className="book-btn--block" />
      </section>
    </main>
  );
}
