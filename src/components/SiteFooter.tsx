import Link from "next/link";
import { BookAppointment } from "./BookAppointment";
import { contact, emailUrl, whatsappUrl } from "../lib/contact";

export function SiteFooter() {
  return (
    <footer className="footer">
      <div className="footer__col">
        <p className="footer__brand">StepZero</p>
        <p>
          Custom software and SaaS, built to each client&apos;s requirements.
        </p>
        <p className="footer__contacts">
          <a href={whatsappUrl} target="_blank" rel="noopener noreferrer">
            WhatsApp {contact.phoneDisplay}
          </a>
          <a href={emailUrl}>{contact.email}</a>
        </p>
        <p>
          <Link href="/#terms">Terms</Link>
          {" / "}
          <Link href="/#privacy">Privacy</Link>
        </p>
        <p>© {new Date().getFullYear()} StepZero. All rights reserved.</p>
      </div>
      <div className="footer__cta">
        <BookAppointment className="book-btn--block" />
      </div>
    </footer>
  );
}
