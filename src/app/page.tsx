import { BookAppointment } from "../components/BookAppointment";
import { IntakeDemo } from "../components/IntakeDemo";
import { contact } from "../lib/contact";

const services = [
  {
    idx: "01",
    title: "Positioning and brand",
    body: "Lock the reason a stranger should trust you before you spend another rupee on ads.",
  },
  {
    idx: "02",
    title: "Website that books",
    body: "A site that answers the five questions buyers ask at 11pm, then pushes them into a booking path.",
  },
  {
    idx: "03",
    title: "Ops automation",
    body: "WhatsApp confirmations, intake routing, and follow-ups that keep the desk sane after hours.",
  },
  {
    idx: "04",
    title: "Growth loop",
    body: "Reviews, referrals, and repeat visits wired so reputation compounds instead of resetting monthly.",
  },
];

const steps = [
  {
    idx: "A",
    title: "Diagnosis call",
    body: "30 minutes. We map demand, leaks, and what is actually worth fixing first.",
  },
  {
    idx: "B",
    title: "Scoped build",
    body: "One written plan. Brand, site, automation. No mystery retainers on day one.",
  },
  {
    idx: "C",
    title: "Install and train",
    body: "We ship, hand over the operating notes, and stay until the front desk can run it cold.",
  },
];

const proof = [
  {
    client: "Northside Clinic",
    sector: "Healthcare",
    change: "Booking path + WhatsApp confirmations",
    signal: "+142% bookings",
  },
  {
    client: "Harbor & Oak",
    sector: "Hospitality",
    change: "Brand reset + conversion site",
    signal: "2.1x dinner covers",
  },
  {
    client: "Veldt Salon",
    sector: "Beauty",
    change: "Identity + after-hours intake",
    signal: "-31% no-shows",
  },
];

export default function HomePage() {
  return (
    <div className="site">
      <header className="topbar">
        <div>
          <a className="brand-mark" href="/">
            StepZero
          </a>
          <p className="brand-meta">
            Growth studio · Local operators · EST. systems
          </p>
        </div>
        <nav className="nav-links" aria-label="Primary">
          <a href="#work">Work</a>
          <a href="#system">System</a>
          <a href="#demo">Demo</a>
          <a href="#book">Book</a>
          <BookAppointment />
        </nav>
      </header>

      <main>
        <section className="hero" aria-label="Introduction">
          <div className="hero__main">
            <p className="kicker">FILE / HOME · PUBLIC</p>
            <h1>
              Build the
              <br />
              business
              <br />
              people trust.
            </h1>
            <div className="hero__rule" aria-hidden="true" />
            <p className="hero__statement">
              StepZero installs brand, website, and booking systems for clinics,
              salons, restaurants, and local operators who are done looking
              interchangeable online.
            </p>
          </div>
          <aside className="hero__side" aria-label="Operating facts">
            <dl>
              <div>
                <dt>Primary action</dt>
                <dd>Book a diagnosis</dd>
              </div>
              <div>
                <dt>Response window</dt>
                <dd>Same business day</dd>
              </div>
              <div>
                <dt>Engagement shape</dt>
                <dd>Scoped build</dd>
              </div>
              <div>
                <dt>Contact rail</dt>
                <dd>
                  WhatsApp
                  <br />+ email
                </dd>
              </div>
            </dl>
          </aside>
        </section>

        <section className="section" id="system" aria-labelledby="system-title">
          <div className="section-meta">
            <p className="kicker">UNIT / SYSTEM</p>
            <h2 id="system-title">What gets installed</h2>
            <p className="lede">
              Four layers. Shipped in order. Sold as one operating stack, not a
              menu of disconnected extras.
            </p>
          </div>
          <ol className="index-list">
            {services.map((item) => (
              <li key={item.idx}>
                <span className="idx">{item.idx}</span>
                <div>
                  <h3>{item.title}</h3>
                  <p>{item.body}</p>
                </div>
              </li>
            ))}
          </ol>
        </section>

        <section className="section" aria-labelledby="method-title">
          <div className="section-meta">
            <p className="kicker">UNIT / METHOD</p>
            <h2 id="method-title">How an engagement runs</h2>
            <p className="lede">
              Short path from first call to a system your team can operate
              without us in the room.
            </p>
          </div>
          <ol className="index-list">
            {steps.map((item) => (
              <li key={item.idx}>
                <span className="idx">{item.idx}</span>
                <div>
                  <h3>{item.title}</h3>
                  <p>{item.body}</p>
                </div>
              </li>
            ))}
          </ol>
        </section>

        <section className="section" id="work" aria-labelledby="work-title">
          <div className="section-meta">
            <p className="kicker">UNIT / PROOF</p>
            <h2 id="work-title">Selected results</h2>
            <p className="lede">
              Measured outcomes from recent installs. Quotes live in private
              debriefs. Numbers live here.
            </p>
          </div>
          <div className="proof-wrap">
            <table className="proof-table">
              <thead>
                <tr>
                  <th scope="col">Client</th>
                  <th scope="col">Sector</th>
                  <th scope="col">Install</th>
                  <th scope="col">Signal</th>
                </tr>
              </thead>
              <tbody>
                {proof.map((row) => (
                  <tr key={row.client}>
                    <td>{row.client}</td>
                    <td>{row.sector}</td>
                    <td>{row.change}</td>
                    <td>{row.signal}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </section>

        <div id="demo">
          <IntakeDemo />
        </div>

        <section className="book-band" id="book" aria-labelledby="book-title">
          <div>
            <p className="kicker">UNIT / BOOKING</p>
            <h2 id="book-title">Book an appointment</h2>
            <p className="lede">
              One tap opens WhatsApp with a prefilled note and starts an email
              to {contact.email}. Tell us the business, the city, and the
              bottleneck. We reply with times.
            </p>
          </div>
          <BookAppointment
            className="book-btn--block"
            label="WhatsApp + email"
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
            We do not guarantee specific revenue outcomes. Marketing results
            depend on offer quality, operations, and demand outside our control.
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
            from India, serving local businesses worldwide.
          </p>
        </section>
      </main>

      <footer className="footer">
        <p>© {new Date().getFullYear()} StepZero · All rights reserved</p>
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
