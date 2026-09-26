import type { Metadata } from "next";
import { IBM_Plex_Sans, Source_Serif_4 } from "next/font/google";
import "./globals.css";

const display = Source_Serif_4({
  subsets: ["latin"],
  variable: "--font-display",
  display: "swap",
});

const sans = IBM_Plex_Sans({
  weight: ["400", "500", "600"],
  subsets: ["latin"],
  variable: "--font-sans",
  display: "swap",
});

export const metadata: Metadata = {
  metadataBase: new URL("https://thestepzero.in"),
  title: "StepZero | Web, automation, and tech help",
  description:
    "StepZero helps anyone who needs to get online, automate busywork, or solve tech problems. Clear scope. Straight answers. Work that ships.",
  alternates: { canonical: "/" },
  openGraph: {
    type: "website",
    url: "https://thestepzero.in",
    siteName: "StepZero",
    title: "StepZero | Web, automation, and tech help",
    description:
      "Websites, automation, and hands-on tech help for people and businesses who need things fixed and running.",
  },
  robots: { index: true, follow: true },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${display.variable} ${sans.variable}`}>
      <body>{children}</body>
    </html>
  );
}
