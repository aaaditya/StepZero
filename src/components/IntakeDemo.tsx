"use client";

import { useEffect, useState } from "react";

type Stage = "idle" | "loading" | "ready";

/** Simplified intake preview with skeleton loaders. Utility, not costume chrome. */
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
        <h2 id="demo-title">Intake preview</h2>
        <p className="lede">
          One short form, one routing path, one human reply. Run it to see the
          loading state resolve into fields.
        </p>
      </div>

      <div className="demo__panel" role="group" aria-label="Intake demo">
        <div className="demo__chrome">
          <span>New inquiry</span>
          <span>Preview</span>
        </div>

        {stage === "idle" && (
          <div className="demo__idle">
            <p className="demo__status">Ready when you are.</p>
            <button
              type="button"
              className="book-btn book-btn--ghost"
              onClick={() => setStage("loading")}
            >
              Load intake
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
            <p className="demo__status">Loading fields</p>
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
              <span>What do you need help with?</span>
              <select defaultValue="website" name="need">
                <option value="website">A website</option>
                <option value="automation">Automation / workflows</option>
                <option value="brand">Brand and messaging</option>
                <option value="fix">Something broken / tech help</option>
              </select>
            </label>
            <label className="field">
              <span>Main bottleneck</span>
              <select defaultValue="online" name="bottleneck">
                <option value="online">Not online yet</option>
                <option value="manual">Too much manual work</option>
                <option value="unclear">Unclear message or brand</option>
                <option value="tools">Tools keep breaking</option>
              </select>
            </label>
            <label className="field">
              <span>City or region</span>
              <input
                name="city"
                defaultValue=""
                placeholder="Where are you based?"
                autoComplete="address-level2"
              />
            </label>
            <p className="demo__status demo__status--ok">
              Fields ready. Submit would route to a human on a live install.
            </p>
            <button type="submit" className="book-btn book-btn--ghost">
              Reset demo
            </button>
          </form>
        )}
      </div>
    </section>
  );
}
