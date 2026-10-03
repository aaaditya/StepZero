import type { MetadataRoute } from "next";
import { contact } from "../lib/contact";

export default function sitemap(): MetadataRoute.Sitemap {
  return [
    {
      url: contact.siteUrl,
      lastModified: new Date(),
      changeFrequency: "monthly",
      priority: 1,
    },
    {
      url: `${contact.siteUrl}/work`,
      lastModified: new Date(),
      changeFrequency: "monthly",
      priority: 0.8,
    },
  ];
}
