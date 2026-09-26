import type { MetadataRoute } from "next";
import { site } from "../lib/site";

/** Explicit content dates — do not use Date.now(). */
const routes: {
  path: string;
  lastModified: Date;
  changeFrequency: MetadataRoute.Sitemap[number]["changeFrequency"];
  priority: number;
}[] = [
  { path: "/", lastModified: new Date("2026-09-26"), changeFrequency: "weekly", priority: 1 },
  { path: "/services", lastModified: new Date("2026-09-26"), changeFrequency: "monthly", priority: 0.9 },
  {
    path: "/services/custom-saas-development",
    lastModified: new Date("2026-09-26"),
    changeFrequency: "monthly",
    priority: 0.9,
  },
  {
    path: "/services/mvp-development",
    lastModified: new Date("2026-09-26"),
    changeFrequency: "monthly",
    priority: 0.9,
  },
  {
    path: "/services/automation",
    lastModified: new Date("2026-09-26"),
    changeFrequency: "monthly",
    priority: 0.8,
  },
  {
    path: "/services/websites",
    lastModified: new Date("2026-09-26"),
    changeFrequency: "monthly",
    priority: 0.8,
  },
  { path: "/work", lastModified: new Date("2026-09-20"), changeFrequency: "monthly", priority: 0.8 },
  {
    path: "/work/northside-clinic",
    lastModified: new Date("2026-09-18"),
    changeFrequency: "yearly",
    priority: 0.7,
  },
  {
    path: "/work/harbor-and-oak",
    lastModified: new Date("2026-09-18"),
    changeFrequency: "yearly",
    priority: 0.7,
  },
  { path: "/products", lastModified: new Date("2026-09-22"), changeFrequency: "monthly", priority: 0.7 },
  { path: "/about", lastModified: new Date("2026-09-26"), changeFrequency: "monthly", priority: 0.7 },
  { path: "/contact", lastModified: new Date("2026-09-26"), changeFrequency: "monthly", priority: 0.8 },
  { path: "/blog", lastModified: new Date("2026-09-24"), changeFrequency: "weekly", priority: 0.7 },
  {
    path: "/blog/why-custom-saas-beats-no-code-patchwork",
    lastModified: new Date("2026-09-24"),
    changeFrequency: "yearly",
    priority: 0.6,
  },
  {
    path: "/blog/mvp-in-90-days-without-the-bloat",
    lastModified: new Date("2026-09-22"),
    changeFrequency: "yearly",
    priority: 0.6,
  },
  { path: "/terms", lastModified: new Date("2026-09-10"), changeFrequency: "yearly", priority: 0.3 },
  { path: "/privacy", lastModified: new Date("2026-09-10"), changeFrequency: "yearly", priority: 0.3 },
];

export default function sitemap(): MetadataRoute.Sitemap {
  return routes.map((route) => ({
    url: `${site.siteUrl}${route.path === "/" ? "" : route.path}`,
    lastModified: route.lastModified,
    changeFrequency: route.changeFrequency,
    priority: route.priority,
  }));
}
