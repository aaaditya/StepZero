import type { Metadata } from "next";
import { Archivo_Black, IBM_Plex_Mono } from "next/font/google";
import "./globals.css";

const display = Archivo_Black({
  weight: "400",
  subsets: ["latin"],
  variable: "--font-display",
  display: "swap",
});

const mono = IBM_Plex_Mono({
  weight: ["400", "500"],
  subsets: ["latin"],
  variable: "--font-mono",
  display: "swap",
});

export const metadata: Metadata = {
  metadataBase: new URL("https://thestepzero.in"),
  title: "StepZero | Growth systems for local businesses",
  description:
    "StepZero builds brand, website, and booking systems for clinics, salons, restaurants, and local operators who need trust that converts.",
  alternates: { canonical: "/" },
  openGraph: {
    type: "website",
    url: "https://thestepzero.in",
    siteName: "StepZero",
    title: "StepZero | Growth systems for local businesses",
    description:
      "Brand, web, and booking systems for local businesses that need to look as serious as the work they already do.",
  },
  robots: { index: true, follow: true },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${display.variable} ${mono.variable}`}>
      <body>{children}</body>
    </html>
  );
}
