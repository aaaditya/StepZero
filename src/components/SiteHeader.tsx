import Link from "next/link";
import { BookAppointment } from "./BookAppointment";

const nav = [
  { href: "/services", label: "Services" },
  { href: "/work", label: "Work" },
  { href: "/products", label: "Products" },
  { href: "/about", label: "About" },
  { href: "/blog", label: "Blog" },
  { href: "/contact", label: "Contact" },
] as const;

export function SiteHeader() {
  return (
    <header className="topbar">
      <Link className="brand-mark" href="/">
        StepZero
      </Link>
      <nav className="nav-links" aria-label="Primary">
        {nav.map((item) => (
          <Link key={item.href} href={item.href}>
            {item.label}
          </Link>
        ))}
        <BookAppointment />
      </nav>
    </header>
  );
}
