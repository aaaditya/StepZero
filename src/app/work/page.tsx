import type { Metadata } from "next";
import { SiteFooter } from "../../components/SiteFooter";
import { SiteHeader } from "../../components/SiteHeader";
import { WorkSection } from "../../components/WorkSection";

export const metadata: Metadata = {
  title: "Work",
  description:
    "Selected software and sites from StepZero: an energy consumer app and portal, Offgrid, Hokai, and this studio site.",
  alternates: { canonical: "/work" },
};

export default function WorkPage() {
  return (
    <div className="site">
      <SiteHeader />
      <main>
        <WorkSection
          heading="Work"
          lede="The same selected projects as the homepage. Client systems that must stay private stay private."
        />
      </main>
      <SiteFooter />
    </div>
  );
}
