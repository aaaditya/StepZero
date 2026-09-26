import type { Metadata } from "next";
import Link from "next/link";
import { BookAppointment } from "../components/BookAppointment";

export const metadata: Metadata = {
  title: "Page not found",
  description: "That URL does not exist on StepZero.",
  robots: { index: false, follow: true },
};

export default function NotFound() {
  return (
    <main className="not-found">
      <p className="not-found__code">404</p>
      <h1>Page not found</h1>
      <p className="lede">
        That URL does not exist on StepZero. Head home for custom SaaS and
        software development — or book a call.
      </p>
      <div className="hero__actions">
        <Link className="book-btn book-btn--ghost" href="/">
          Back to home
        </Link>
        <BookAppointment label="Book a call" />
      </div>
    </main>
  );
}
