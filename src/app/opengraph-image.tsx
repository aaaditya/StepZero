import { ImageResponse } from "next/og";

export const alt = "StepZero — Custom SaaS & Software Development Studio";
export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

export default function OpenGraphImage() {
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          flexDirection: "column",
          justifyContent: "space-between",
          padding: "64px 72px",
          background: "#eceae6",
          color: "#161615",
          fontFamily: "Georgia, serif",
        }}
      >
        <div
          style={{
            display: "flex",
            fontSize: 36,
            fontWeight: 600,
            letterSpacing: "-0.02em",
            color: "#0b5f5c",
          }}
        >
          StepZero
        </div>
        <div style={{ display: "flex", flexDirection: "column", gap: 18 }}>
          <div
            style={{
              display: "flex",
              fontSize: 64,
              fontWeight: 600,
              lineHeight: 1.1,
              letterSpacing: "-0.03em",
              maxWidth: 900,
            }}
          >
            Custom SaaS & software development
          </div>
          <div
            style={{
              display: "flex",
              fontSize: 28,
              color: "#5b5a56",
              maxWidth: 720,
              lineHeight: 1.35,
            }}
          >
            MVPs, productized tools, and automation — studio based in India.
          </div>
        </div>
        <div
          style={{
            display: "flex",
            fontSize: 22,
            color: "#5b5a56",
            letterSpacing: "0.02em",
          }}
        >
          thestepzero.in
        </div>
      </div>
    ),
    { ...size },
  );
}
