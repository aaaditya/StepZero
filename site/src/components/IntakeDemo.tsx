"use client";

import { useEffect, useState } from "react";

type Stage = "idle" | "loading" | "ready";

/** Real product surface with skeleton loaders. Not decorative chrome. */
export function IntakeDemo() {
  const [stage, setStage] = useState<Stage>("idle");

  useEffect(() => {
    if (stage !== "loading") return;
    const t = window.setTimeout(() => setStage("ready"), 1100);
    return () => window.clearTimeout(t);
  }, [stage]);

  return (
    <section className="demo" aria-labelledby="demo-title">
      <div className="section-meta">
        <p className="kicker">UNIT / DEMO-01</p>
        <h2 id="demo-title">Live intake surface</h2>
        <p className="lede">
          Operator console pattern we install: one form, one routing rule, one
          human handoff. Run it to watch the skeleton resolve into fields.
        </p>
      </div>

      <div className="demo__panel" role="group" aria-label="Intake demo">
        <div className="demo__chrome">
          <span>INTAKE.ROUTE</span>
          <span>REV 2.4</span>
        </div>

        {stage === "idle" && (
          <div className="demo__idle">
            <p className="demo__status">Status: idle</p>
            <button
              type="button"
              className="book-btn book-btn--ghost"
              onClick={() => setStage("loading")}
            >
              <span className="book-btn__index" aria-hidden="true">
                [ RUN ]
              </span>
              <span className="book-btn__label">Load intake</span>
            </button>
          </div>
        )}

        {stage === "loading" && (
          <div className="demo__skeletons" aria-busy="true" aria-live="polite">
            <div className="skel skel--title" />
            <div className="skel skel--line" />
            <div className="skel skel--line skel--short" />
            <div className="skel skel--block" />
            <div className="skel skel--line" />
            <p className="demo__status">Fetching field schema</p>
          </div>
        )}

        {stage === "ready" && (
          <form
            className="demo__form"
            onSubmit={(e) => {
              e.preventDefault();
              setStage("idle");
            }}
          >
            <label className="field">
              <span>Business type</span>
              <select defaultValue="clinic" name="type">
                <option value="clinic">Clinic</option>
                <option value="salon">Salon</option>
                <option value="restaurant">Restaurant</option>
                <option value="gym">Gym</option>
              </select>
            </label>
            <label className="field">
              <span>Primary bottleneck</span>
              <select defaultValue="booking" name="bottleneck">
                <option value="booking">Missed bookings</option>
                <option value="brand">Weak brand trust</option>
                <option value="reviews">Scattered reviews</option>
                <option value="ops">Front-desk overload</option>
              </select>
            </label>
            <label className="field">
              <span>City</span>
              <input
                name="city"
                defaultValue="Austin"
                autoComplete="address-level2"
              />
            </label>
            <p className="demo__status demo__status--ok">
              Schema resolved. Route ready for human handoff.
            </p>
            <button type="submit" className="book-btn book-btn--ghost">
              <span className="book-btn__index" aria-hidden="true">
                [ RESET ]
              </span>
              <span className="book-btn__label">Reset demo</span>
            </button>
          </form>
        )}
      </div>
    </section>
  );
}
