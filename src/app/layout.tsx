import type { Metadata } from "next";
import { IBM_Plex_Sans, Source_Serif_4 } from "next/font/google";
import { Analytics } from "../components/Analytics";
import { JsonLd } from "../components/JsonLd";
import { SiteFooter } from "../components/SiteFooter";
import { SiteHeader } from "../components/SiteHeader";
import { site } from "../lib/site";
import "./globals.css";

const display = Source_Serif_4({
  subsets: ["latin"],
  variable: "--font-display",
  display: "swap",
  preload: true,
  adjustFontFallback: true,
});

const sans = IBM_Plex_Sans({
  weight: ["400", "500", "600"],
  subsets: ["latin"],
  variable: "--font-sans",
  display: "swap",
  preload: true,
  adjustFontFallback: true,
});

export const metadata: Metadata = {
  metadataBase: new URL(site.siteUrl),
  title: {
    default: site.defaultTitle,
    template: `%s | ${site.brand}`,
  },
  description: site.defaultDescription,
  keywords: [
    "StepZero",
    "custom SaaS",
    "custom SaaS development",
    "custom software development",
    "MVP development",
    "software development India",
    "SaaS studio India",
    "business automation",
    "websites",
  ],
  authors: [{ name: site.brand, url: site.siteUrl }],
  creator: site.brand,
  alternates: { canonical: "/" },
  openGraph: {
    type: "website",
    url: site.siteUrl,
    siteName: site.brand,
    title: site.defaultTitle,
    description: site.defaultDescription,
    locale: "en_IN",
    images: [
      {
        url: "/opengraph-image",
        width: 1200,
        height: 630,
        alt: "StepZero — Custom SaaS & Software Development Studio",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: site.defaultTitle,
    description: site.defaultDescription,
    images: ["/opengraph-image"],
  },
  robots: { index: true, follow: true },
  icons: {
    icon: [
      { url: "/favicon.ico", sizes: "any" },
      { url: "/favicon.svg", type: "image/svg+xml" },
    ],
    apple: [{ url: "/apple-icon.png", sizes: "180x180", type: "image/png" }],
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${display.variable} ${sans.variable}`}>
      <body>
        <JsonLd />
        <div className="site">
          <SiteHeader />
          {children}
          <SiteFooter />
        </div>
        <Analytics />
      </body>
    </html>
  );
}
