import Link from "next/link";
import { BookAppointment } from "./BookAppointment";

export function SiteHeader() {
  return (
    <header className="topbar">
      <Link className="brand-mark" href="/">
        StepZero
      </Link>
      <nav className="nav-links" aria-label="Primary">
        <Link href="/#work">Work</Link>
        <Link href="/#services">Services</Link>
        <Link href="/#process">Process</Link>
        <BookAppointment />
      </nav>
    </header>
  );
}
