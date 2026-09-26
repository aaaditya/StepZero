import { contact } from "../lib/contact";

const organization = {
  "@type": "Organization",
  "@id": `${contact.siteUrl}/#organization`,
  name: "StepZero",
  url: contact.siteUrl,
  email: contact.email,
  description:
    "StepZero builds websites, automation workflows, and provides hands-on tech help.",
  areaServed: "Worldwide",
  sameAs: [] as string[],
};

const website = {
  "@type": "WebSite",
  "@id": `${contact.siteUrl}/#website`,
  url: contact.siteUrl,
  name: "StepZero",
  description:
    "Websites, automation, and tech help from StepZero — clear scope, straight answers.",
  publisher: { "@id": `${contact.siteUrl}/#organization` },
  inLanguage: "en",
};

const professionalService = {
  "@type": "ProfessionalService",
  "@id": `${contact.siteUrl}/#service`,
  name: "StepZero",
  url: contact.siteUrl,
  email: contact.email,
  description:
    "Website design and development, business automation, and hands-on tech support.",
  provider: { "@id": `${contact.siteUrl}/#organization` },
  areaServed: "Worldwide",
  serviceType: [
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
