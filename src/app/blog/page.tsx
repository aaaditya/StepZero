import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Blog",
  description:
    "StepZero writing on custom SaaS, MVP development, and shipping software without bloat — from a studio in India.",
  alternates: { canonical: "/blog" },
};

const posts = [
  {
    href: "/blog/why-custom-saas-beats-no-code-patchwork",
    title: "Why custom SaaS beats no-code patchwork",
    date: "24 Sep 2026",
    body: "When Zapier and spreadsheets become the product — and why encoding the workflow is cheaper than eternal glue.",
  },
  {
    href: "/blog/mvp-in-90-days-without-the-bloat",
    title: "MVP in 90 days without the bloat",
    date: "22 Sep 2026",
    body: "A practical shape for MVP development: cut lists, milestones, and foundations that do not force a rewrite.",
  },
];

export default function BlogPage() {
  return (
    <main className="page">
      <header className="page-hero">
        <p className="page-kicker">Blog</p>
        <h1>Notes on shipping custom software</h1>
        <p className="lede">
          Practical writing for founders and operators considering custom SaaS,
          MVP development, and automation — without agency filler.
        </p>
      </header>

      <section className="section" aria-labelledby="posts-title">
        <div className="section-meta">
          <h2 id="posts-title">Recent posts</h2>
        </div>
        <ol className="index-list">
          {posts.map((post) => (
            <li key={post.href}>
              <span className="idx" aria-hidden="true" />
              <div>
                <p className="eyebrow">{post.date}</p>
                <h3>
                  <Link href={post.href}>{post.title}</Link>
                </h3>
                <p>{post.body}</p>
              </div>
            </li>
          ))}
        </ol>
      </section>
    </main>
  );
}
