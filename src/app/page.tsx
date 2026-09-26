import Image from "next/image";
import { BookAppointment } from "../components/BookAppointment";
import { IntakeDemo } from "../components/IntakeDemo";
import { contact } from "../lib/contact";

const services = [
  {
    title: "Websites that work",
    body: "A clear site that explains what you do, answers the usual questions, and makes it easy to get in touch.",
  },
  {
    title: "Automation and workflows",
    body: "Forms, WhatsApp confirmations, intake routing, and follow-ups so busywork stops living in your head.",
  },
  {
    title: "Brand that reads clearly",
    body: "Name, message, and visuals that feel trustworthy online without looking like every other template.",
  },
  {
    title: "Hands-on tech help",
    body: "Broken tools, messy setups, domain issues, migrations. We diagnose, fix, and leave you with notes.",
  },
];

const steps = [
  {
    title: "Tell us what you need",
    body: "A short call or message. We map the problem, the urgency, and what is worth fixing first.",
  },
  {
    title: "Agree on a scoped plan",
    body: "One written plan with deliverables and timing. No mystery retainers on day one.",
  },
  {
    title: "Build, ship, hand over",
    body: "We implement, walk you through it, and stay until you can run the system without us.",
  },
];

export default function HomePage() {
  return (
    <div className="site">
      <header className="topbar">
        <a className="brand-mark" href="/">
          StepZero
        </a>
        <nav className="nav-links" aria-label="Primary">
          <a href="#services">Services</a>
          <a href="#process">Process</a>
          <a href="#demo">Demo</a>
          <a href="#book">Book</a>
          <BookAppointment />
        </nav>
      </header>

      <main>
        <section className="hero" aria-label="Introduction">
          <div className="hero__copy">
            <h1>Get online. Automate the busywork. Fix what breaks.</h1>
            <p className="hero__statement">
              StepZero helps anyone who needs a website, automation, or
              hands-on tech help. Clear scope. Straight answers.
            </p>
            <div className="hero__actions">
              <BookAppointment label="Book an appointment" />
            </div>
          </div>
          <figure className="hero__media">
            <Image
              src="/hero-utility-desk.png"
              alt="Laptop and notebook on a clean desk, ready for focused work"
              width={1600}
              height={1000}
              priority
              sizes="(max-width: 860px) 100vw, 48vw"
            />
          </figure>
        </section>

        <section
          className="section"
          id="services"
          aria-labelledby="services-title"
        >
          <div className="section-meta">
            <h2 id="services-title">What we help with</h2>
            <p className="lede">
              Practical work for people and businesses who need to be online,
              save time, or get tech problems resolved.
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

        <section
          className="section"
          id="process"
          aria-labelledby="process-title"
        >
          <div className="section-meta">
            <h2 id="process-title">How it works</h2>
            <p className="lede">
              A short path from first message to something you can run without
              us in the room.
            </p>
          </div>
          <ol className="index-list">
            {steps.map((item) => (
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
            <h2 id="book-title">Book an appointment</h2>
            <p className="lede">
              One tap opens WhatsApp when configured and starts an email to{" "}
              {contact.email}. Tell us what you need and where you are stuck.
              We reply with times.
            </p>
          </div>
          <BookAppointment
            className="book-btn--block"
            label="Book an appointment"
          />
        </section>

        <section className="legal" id="terms" aria-labelledby="terms-title">
          <h2 id="terms-title">Terms of service</h2>
          <h3>Scope</h3>
          <p>
            StepZero provides strategy, design, web, and automation services
            under written proposals. Work starts after both parties confirm
            scope, timeline, and fees in writing.
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

      <footer className="footer">
        <p>© {new Date().getFullYear()} StepZero. All rights reserved.</p>
        <p>
          <a href="#terms">Terms</a>
          {" / "}
          <a href="#privacy">Privacy</a>
          {" / "}
          <a href={`mailto:${contact.email}`}>{contact.email}</a>
        </p>
      </footer>
    </div>
  );
}
