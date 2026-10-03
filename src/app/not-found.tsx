import Link from "next/link";
import { BookAppointment } from "../components/BookAppointment";
import { SiteHeader } from "../components/SiteHeader";

export default function NotFound() {
  return (
    <div className="site">
      <SiteHeader />

      <main className="not-found">
        <p className="not-found__code">404</p>
        <h1>Page not found</h1>
        <p className="lede">
          That URL does not exist on StepZero. Head home to see selected work,
          or book a free 15-min call.
        </p>
        <div className="hero__actions">
          <Link className="book-btn book-btn--ghost" href="/">
            Back to home
          </Link>
          <BookAppointment />
        </div>
      </main>
    </div>
  );
}
