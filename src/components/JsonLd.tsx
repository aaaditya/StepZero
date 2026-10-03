import { contact } from "../lib/contact";

const telephone = `+${contact.whatsappE164}`;

const organization = {
  "@type": "Organization",
  "@id": `${contact.siteUrl}/#organization`,
  name: "StepZero",
  url: contact.siteUrl,
  email: contact.email,
  telephone,
  description:
    "StepZero builds custom software and SaaS to each client's requirements, for clients in India and abroad.",
  areaServed: ["India", "Worldwide"],
  contactPoint: {
    "@type": "ContactPoint",
    contactType: "sales",
    email: contact.email,
    telephone,
    url: contact.siteUrl,
  },
  sameAs: [] as string[],
};

const website = {
  "@type": "WebSite",
  "@id": `${contact.siteUrl}/#website`,
  url: contact.siteUrl,
  name: "StepZero",
  description:
    "Custom software and SaaS from StepZero. Built to your requirements. Clear scope, straight answers.",
  publisher: { "@id": `${contact.siteUrl}/#organization` },
  inLanguage: "en",
};

const professionalService = {
  "@type": "ProfessionalService",
  "@id": `${contact.siteUrl}/#service`,
  name: "StepZero",
  url: contact.siteUrl,
  email: contact.email,
  telephone,
  description:
    "Custom software and SaaS design and development, plus websites, automation, and hands-on tech support.",
  provider: { "@id": `${contact.siteUrl}/#organization` },
  areaServed: ["India", "Worldwide"],
  serviceType: [
    "Custom software and SaaS development",
    "Website design and development",
    "Business automation and workflows",
    "Tech help and troubleshooting",
  ],
};

const graph = {
  "@context": "https://schema.org",
  "@graph": [organization, website, professionalService],
};

/** Organization + WebSite + ProfessionalService JSON-LD for SEO. */
export function JsonLd() {
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(graph) }}
    />
  );
}
