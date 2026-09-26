import { sameAsProfiles, site } from "../lib/site";

const sameAs = sameAsProfiles();
const logoUrl = `${site.siteUrl}/icon.svg`;
const imageUrl = `${site.siteUrl}/opengraph-image`;

const areaServed = site.countriesServed.map((name) => ({
  "@type": "Country",
  name,
}));

const address = {
  "@type": "PostalAddress",
  addressCountry: "IN",
  ...(site.city ? { addressLocality: site.city } : {}),
};

const organization = {
  "@type": "Organization",
  "@id": `${site.siteUrl}/#organization`,
  name: site.brand,
  url: site.siteUrl,
  email: site.email,
  logo: logoUrl,
  image: imageUrl,
  description: site.defaultDescription,
  address,
  areaServed,
  ...(sameAs.length ? { sameAs } : {}),
};

const website = {
  "@type": "WebSite",
  "@id": `${site.siteUrl}/#website`,
  url: site.siteUrl,
  name: site.brand,
  description: site.defaultDescription,
  publisher: { "@id": `${site.siteUrl}/#organization` },
  inLanguage: "en",
  image: imageUrl,
};

const professionalService = {
  "@type": "ProfessionalService",
  "@id": `${site.siteUrl}/#service`,
  name: site.brand,
  url: site.siteUrl,
  email: site.email,
  description:
    "Custom SaaS development, MVP builds, business automation, and websites from a studio in India.",
  provider: { "@id": `${site.siteUrl}/#organization` },
  image: imageUrl,
  address,
  areaServed,
  serviceType: [
    "Custom SaaS development",
    "Custom software development",
    "MVP development",
    "Business automation",
    "Website design and development",
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
