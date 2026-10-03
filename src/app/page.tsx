import Image from "next/image";
import Link from "next/link";
import dynamic from "next/dynamic";
import { BookAppointment } from "../components/BookAppointment";
import { SiteFooter } from "../components/SiteFooter";
import { SiteHeader } from "../components/SiteHeader";
import { WorkSection } from "../components/WorkSection";
import { contact, emailUrl, whatsappUrl } from "../lib/contact";

/** Defer intake demo JS — noncritical for first paint / SEO. */
const IntakeDemo = dynamic(
  () =>
    import("../components/IntakeDemo").then((m) => m.IntakeDemo),
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

const services = [
  {
    title: "Custom software and SaaS",
    body: "Products and internal tools built to your requirements, not a template. Web apps, portals, and systems you can run.",
  },
  {
    title: "Websites that work",
    body: "A clear site that explains what you do, answers the usual questions, and makes it easy to get in touch.",
  },
  {
    title: "Automation and workflows",
    body: "Forms, WhatsApp confirmations, intake routing, and follow-ups so busywork stops living in your head.",
  },
  {
    title: "Hands-on tech help",
    body: "Broken tools, messy setups, domain issues, migrations. We diagnose, fix, and leave you with notes.",
  },
];

const steps = [
  {
    title: "Free 15-min call",
    body: "A short conversation about the problem and whether we can help.",
  },
  {
    title: "Fixed-scope quote",
    body: "One written scope with deliverables and timing. No open-ended retainers.",
  },
  {
    title: "Live in about 2 weeks",
    body: "We build, launch, and hand over a working first version.",
  },
];

export default function HomePage() {
  return (
    <div className="site">
      <SiteHeader />

      <main>
        <section className="hero" aria-label="Introduction">
          <div className="hero__copy">
            <h1>Custom software and SaaS</h1>
            <p className="hero__statement">
              Built to your requirements, for clients in India and abroad, plus
              products we run ourselves.
            </p>
            <div className="hero__actions">
              <BookAppointment />
              <Link className="book-btn book-btn--ghost" href="#work">
                See selected work
              </Link>
            </div>
          </div>
          <figure className="hero__media">
            <Image
              src="/hero-utility-desk.png"
              alt="Laptop and notebook on a clean desk. StepZero custom software workspace."
              width={1280}
              height={720}
              priority
              sizes="(max-width: 860px) 100vw, 48vw"
              style={{ width: "100%", height: "auto" }}
            />
          </figure>
        </section>

        <WorkSection />

        <section
          className="how"
          id="process"
          aria-labelledby="process-title"
        >
          <h2 id="process-title">How it works</h2>
          <ol className="how-list">
            {steps.map((item) => (
              <li key={item.title}>
                <h3>{item.title}</h3>
                <p>{item.body}</p>
              </li>
            ))}
          </ol>
        </section>

        <section
          className="section"
          id="services"
          aria-labelledby="services-title"
        >
          <div className="section-meta">
            <h2 id="services-title">What we build</h2>
            <p className="lede">
              Custom software first. Websites, automation, and tech help when
              that is what the brief needs.
            </p>
          </div>
          <ol className="index-list">
            {services.map((item) => (
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

        <div id="demo">
          <IntakeDemo />
        </div>

        <section className="book-band" id="book" aria-labelledby="book-title">
          <div>
            <h2 id="book-title">Book a free 15-min call</h2>
            <p className="lede">
              WhatsApp or email. Tell us what you want built. We reply with
              times.
            </p>
            <p className="contact-lines">
              <a href={whatsappUrl} target="_blank" rel="noopener noreferrer">
                WhatsApp {contact.phoneDisplay}
              </a>
              <a href={emailUrl}>{contact.email}</a>
            </p>
          </div>
          <BookAppointment className="book-btn--block" />
        </section>

        <section className="legal" id="terms" aria-labelledby="terms-title">
          <h2 id="terms-title">Terms of service</h2>
          <h3>Scope</h3>
          <p>
            StepZero provides strategy, design, software, and automation
            services under written proposals. Work starts after both parties
            confirm scope and timeline in writing.
          </p>
          <h3>Payment</h3>
          <p>
            Invoices are due as stated in the proposal. Late balances may pause
            delivery until cleared. Third-party tools (hosting, messaging, ads)
            are billed to the client unless noted otherwise.
          </p>
          <h3>IP</h3>
          <p>
            Finished deliverables transfer to the client after final payment.
            StepZero may show anonymized process and outcomes in its portfolio
            unless a written NDA says otherwise.
          </p>
          <h3>Limitation</h3>
          <p>
            We do not guarantee specific revenue outcomes. Results depend on
            offer quality, operations, and demand outside our control.
          </p>
        </section>

        <section className="legal" id="privacy" aria-labelledby="privacy-title">
          <h2 id="privacy-title">Privacy policy</h2>
          <h3>Data we collect</h3>
          <p>
            When you book via WhatsApp or email, we receive the message content,
            your phone or email address, and basic metadata from those
            providers. Site analytics, if enabled, use privacy-respecting
            aggregate metrics.
          </p>
          <h3>Use</h3>
          <p>
            Contact data is used only to reply, schedule, and deliver services.
            We do not sell personal data.
          </p>
          <h3>Retention</h3>
          <p>
            Project records are kept for the duration of the engagement and for
            lawful accounting needs afterward. You can request deletion of
            non-required records by emailing {contact.email}.
          </p>
          <h3>Contact</h3>
          <p>
            Privacy questions: {contact.email}. Operator: StepZero, operating
            from India, serving clients worldwide.
          </p>
        </section>
      </main>

      <SiteFooter />
    </div>
  );
}
