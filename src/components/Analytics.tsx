import Script from "next/script";

const rawId = process.env.NEXT_PUBLIC_GA_ID?.trim() ?? "";
/** Accept GA4 (G-…) or Universal (UA-…) IDs only — never invent a fake ID. */
const gaId = /^(G-[A-Z0-9]+|UA-\d+-\d+)$/i.test(rawId) ? rawId : null;

/**
 * Loads Google Analytics only when NEXT_PUBLIC_GA_ID is set.
 * Uses next/script afterInteractive to avoid blocking first paint.
 */
export function Analytics() {
  if (!gaId) return null;

  return (
    <>
      <Script
        src={`https://www.googletagmanager.com/gtag/js?id=${gaId}`}
        strategy="afterInteractive"
      />
      <Script id="ga-init" strategy="afterInteractive">
        {`window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','${gaId}');`}
      </Script>
    </>
  );
}
