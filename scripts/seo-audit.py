#!/usr/bin/env python3
"""Custom SEO score for thestepzero.in (0–10). Usage: python3 scripts/seo-audit.py [base_url]"""

from __future__ import annotations

import json
import re
import subprocess
import sys
import urllib.request

SITE = sys.argv[1] if len(sys.argv) > 1 else "https://thestepzero.in"


def fetch(url: str, method: str = "GET") -> tuple[int | None, str]:
    req = urllib.request.Request(url, method=method, headers={"User-Agent": "StepZeroSEO/1.0"})
    try:
        with urllib.request.urlopen(req, timeout=25) as r:
            body = r.read().decode("utf-8", "replace") if method == "GET" else ""
            return r.status, body
    except Exception as e:  # noqa: BLE001
        if hasattr(e, "code"):
            body = ""
            try:
                body = e.read().decode("utf-8", "replace") if method == "GET" else ""
            except Exception:
                pass
            return int(e.code), body
        return None, str(e)


def main() -> None:
    checks: list[tuple[str, bool, str, float]] = []

    def add(name: str, ok: bool, detail: str = "", weight: float = 0.5) -> None:
        checks.append((name, ok, detail, weight))
        print(f"{'PASS' if ok else 'FAIL'} {name}: {detail[:200]}")

    st, home = fetch(f"{SITE}/")
    add("https_home_200", st == 200, str(st), 1.0)
    title = (re.search(r"<title>([^<]+)", home or "") or ["", ""])[1]
    add("title_home", "StepZero" in title, title, 0.5)
    add(
        "canonical_home",
        'rel="canonical" href="https://thestepzero.in/"' in (home or ""),
        "",
        0.5,
    )
    add("email_present", "info@thestepzero.in" in (home or ""), "", 0.5)
    add("og_image_meta", "og-image.png" in (home or ""), "", 0.25)

    st, _ = fetch(f"{SITE}/og-image.png", "HEAD")
    if st is None:
        st, _ = fetch(f"{SITE}/og-image.png")
    add("og_image_200", st == 200, str(st), 0.75)

    st, robots = fetch(f"{SITE}/robots.txt")
    add("robots_200", st == 200 and "sitemap" in (robots or "").lower(), "", 0.5)
    st, sm = fetch(f"{SITE}/sitemap.xml")
    add("sitemap_200", st == 200 and "thestepzero.in" in (sm or ""), str(st), 0.5)

    out = subprocess.check_output(["curl", "-sI", "https://www.thestepzero.in/"], text=True)
    loc = re.search(r"(?i)^location:\s*(\S+)", out, re.M)
    code = re.search(r"HTTP/\d(?:\.\d)?\s+(\d+)", out)
    add(
        "www_to_apex",
        bool(
            code
            and code.group(1) in ("301", "308", "302")
            and loc
            and loc.group(1).startswith("https://thestepzero.in")
        ),
        f"{code.group(1) if code else '?'} -> {loc.group(1) if loc else '?'}",
        1.0,
    )

    routes = ["/", "/services", "/work", "/contact", "/pricing"]
    titles: dict[str, str] = {}
    canons: dict[str, str] = {}
    for path in routes:
        _, html = fetch(f"{SITE}{path}")
        titles[path] = (re.search(r"<title>([^<]+)", html or "") or ["", ""])[1]
        canons[path] = (re.search(r'rel="canonical" href="([^"]+)"', html or "") or ["", ""])[1]
    add("unique_titles_sample", len(set(titles.values())) == len(titles), json.dumps(titles), 1.5)
    add(
        "unique_canonicals_sample",
        len(set(canons.values())) == len(canons),
        json.dumps(canons),
        1.5,
    )

    st, _ = fetch(f"{SITE}/this-page-does-not-exist-seo-scan-999")
    add("unknown_not_200", st != 200, f"status={st}", 0.5)
    add("unknown_is_404", st == 404, f"status={st}", 0.5)

    text = re.sub(r"<script[\s\S]*?</script>", "", home or "")
    text = re.sub(r"<style[\s\S]*?</style>", "", text)
    text = re.sub(r"<[^>]+>", " ", text)
    words = len(re.findall(r"[A-Za-z]{3,}", text))
    add("crawlable_words_home", words >= 40, f"words={words}", 0.5)

    score = sum(w for _, ok, _, w in checks if ok)
    maxs = sum(w for *_, w in checks)
    print(f"\nSCORE {score / maxs * 10:.1f}/10  ({sum(1 for _, ok, _, _ in checks if ok)}/{len(checks)} checks)")


if __name__ == "__main__":
    main()
