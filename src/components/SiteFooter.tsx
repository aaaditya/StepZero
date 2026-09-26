import Link from "next/link";
import { site } from "../lib/site";

const footerNav = [
  { href: "/services", label: "Services" },
  { href: "/work", label: "Work" },
  { href: "/products", label: "Products" },
  { href: "/about", label: "About" },
  { href: "/blog", label: "Blog" },
  { href: "/contact", label: "Contact" },
  { href: "/terms", label: "Terms" },
  { href: "/privacy", label: "Privacy" },
] as const;

export function SiteFooter() {
  return (
    <footer className="footer">
      <div className="footer__meta">
        <p>
          © {new Date().getFullYear()} {site.brand}. Custom SaaS & software
          development · {site.serviceArea}.
        </p>
        <p>
          <a href={`mailto:${site.email}`}>{site.email}</a>
        </p>
      </div>
      <nav className="footer__nav" aria-label="Footer">
        {footerNav.map((item, i) => (
          <span key={item.href}>
            {i > 0 ? " / " : null}
            <Link href={item.href}>{item.label}</Link>
          </span>
        ))}
      </nav>
    </footer>
  );
}
