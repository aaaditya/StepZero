export type WorkLink = {
  href: string;
  label: string;
};

export type WorkProject = {
  slug: string;
  title: string;
  kind: string;
  forWhom: string;
  built: string;
  stack: string;
  note?: string;
  link?: WorkLink;
};

/**
 * Only projects we can verify. Do not invent clients, metrics, or logos.
 */
export const workProjects: WorkProject[] = [
  {
    slug: "energy-consumer",
    title: "Energy consumer app and portal",
    kind: "Customer app and web portal",
    forWhom: "People who need to see their energy use and bills in one place.",
    built:
      "An energy/utility consumer app and web portal used by 10,000+ people, for meter data, usage, bills, and recharge-type information.",
    stack: "Customer web portal and mobile app",
  },
  {
    slug: "offgrid",
    title: "Offgrid",
    kind: "Privacy-first PDF toolkit",
    forWhom:
      "Anyone who needs common PDF jobs without uploading files to a third party.",
    built:
      "Merge, split, compress, and organize PDFs, plus images-to-PDF and PDF-to-images. All processing runs in the browser. Files never leave the device.",
    stack: "TypeScript, React, Vite, pdf-lib, pdfjs-dist",
    link: {
      href: "https://github.com/aaaditya/saas-exp",
      label: "View on GitHub",
    },
  },
  {
    slug: "hokai",
    title: "Hokai",
    kind: "Restaurant website",
    forWhom: "Hokai, a Pan Asian Express and Tea Bar.",
    built:
      "A brand site for the restaurant: story, menu paths for sushi, dumplings, baos, bowls, and the tea bar, plus dine-in, takeaway, and at-home.",
    stack: "Next.js",
    link: {
      href: "https://hokai.vercel.app",
      label: "Visit live",
    },
  },
  {
    slug: "stepzero",
    title: "StepZero",
    kind: "Studio site",
    forWhom: "Our own studio, for clients in India and abroad.",
    built:
      "This marketing site: a server-rendered homepage with work, process, and a direct path to book a call.",
    stack: "Next.js App Router",
    link: {
      href: "https://thestepzero.in",
      label: "Visit live",
    },
  },
];
