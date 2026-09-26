import Link from "next/link";
import { BookAppointment } from "../components/BookAppointment";

export default function NotFound() {
  return (
    <div className="site">
      <header className="topbar">
        <Link className="brand-mark" href="/">
          StepZero
        </Link>
        <nav className="nav-links" aria-label="Primary">
          <Link href="/#services">Services</Link>
          <Link href="/#book">Book</Link>
          <BookAppointment />
        </nav>
      </header>

      <main className="not-found">
        <p className="not-found__code">404</p>
        <h1>Page not found</h1>
        <p className="lede">
          That URL does not exist on StepZero. Head home for websites,
          automation, and tech help — or book an appointment.
        </p>
        <div className="hero__actions">
          <Link className="book-btn book-btn--ghost" href="/">
            Back to home
          </Link>
          <BookAppointment label="Book an appointment" />
        </div>
      </main>
    </div>
  );
}
