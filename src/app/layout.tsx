import type { Metadata } from "next";
import { IBM_Plex_Sans, Source_Serif_4 } from "next/font/google";
import { Analytics } from "../components/Analytics";
import { JsonLd } from "../components/JsonLd";
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

const title = "StepZero | Websites, Automation & Tech Help";
const description =
  "StepZero builds websites, sets up automation workflows, and provides hands-on tech help. Clear scope, straight answers, work that ships.";

export const metadata: Metadata = {
  metadataBase: new URL("https://thestepzero.in"),
  title: {
    default: title,
    template: "%s | StepZero",
  },
  description,
  keywords: [
    "StepZero",
    "websites",
    "website design",
    "automation",
    "business automation",
    "tech help",
    "tech support",
    "workflows",
  ],
  authors: [{ name: "StepZero", url: "https://thestepzero.in" }],
  creator: "StepZero",
  alternates: { canonical: "/" },
  openGraph: {
    type: "website",
    url: "https://thestepzero.in",
    siteName: "StepZero",
    title,
    description,
    locale: "en_IN",
  },
  twitter: {
    card: "summary_large_image",
    title,
    description,
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
        {children}
        <Analytics />
      </body>
    </html>
  );
}
