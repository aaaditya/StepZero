#!/usr/bin/env node
/**
 * Post-build SEO prerender for Flutter web.
 * Writes unique HTML shells per route + a real 404 page into build/web.
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, '..');
const buildWeb = path.join(root, 'build', 'web');
const routesPath = path.join(__dirname, 'seo-routes.json');

function escapeHtml(s) {
  return String(s)
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;');
}

function replaceMeta(html, { title, description, canonical, image, type, noIndex }) {
  let out = html;
  out = out.replace(/<title>[^<]*<\/title>/, `<title>${escapeHtml(title)}</title>`);
  out = out.replace(
    /<meta name="description" content="[^"]*">/,
    `<meta name="description" content="${escapeHtml(description)}">`,
  );
  out = out.replace(
    /<link rel="canonical" href="[^"]*">/,
    `<link rel="canonical" href="${escapeHtml(canonical)}">`,
  );
  out = out.replace(
    /<meta property="og:url" content="[^"]*">/,
    `<meta property="og:url" content="${escapeHtml(canonical)}">`,
  );
  out = out.replace(
    /<meta property="og:title" content="[^"]*">/,
    `<meta property="og:title" content="${escapeHtml(title)}">`,
  );
  out = out.replace(
    /<meta property="og:description" content="[^"]*">/,
    `<meta property="og:description" content="${escapeHtml(description)}">`,
  );
  out = out.replace(
    /<meta property="og:image" content="[^"]*">/,
    `<meta property="og:image" content="${escapeHtml(image)}">`,
  );
  out = out.replace(
    /<meta property="og:type" content="[^"]*">/,
    `<meta property="og:type" content="${escapeHtml(type || 'website')}">`,
  );
  out = out.replace(
    /<meta name="twitter:title" content="[^"]*">/,
    `<meta name="twitter:title" content="${escapeHtml(title)}">`,
  );
  out = out.replace(
    /<meta name="twitter:description" content="[^"]*">/,
    `<meta name="twitter:description" content="${escapeHtml(description)}">`,
  );
  out = out.replace(
    /<meta name="twitter:image" content="[^"]*">/,
    `<meta name="twitter:image" content="${escapeHtml(image)}">`,
  );

  if (noIndex) {
    out = out.replace(
      /<meta name="robots" content="[^"]*">/,
      '<meta name="robots" content="noindex, follow">',
    );
  }

  // Keep Organization / WebSite / ProfessionalService rooted at the site.
  // Add a WebPage node for this route (idempotent).
  if (!out.includes('"@type": "WebPage"') && !out.includes('"@type":"WebPage"')) {
    const webPage = `{
        "@type": "WebPage",
        "@id": "${escapeHtml(canonical)}#webpage",
        "url": "${escapeHtml(canonical)}",
        "name": "${escapeHtml(title)}",
        "description": "${escapeHtml(description)}",
        "isPartOf": { "@id": "https://thestepzero.in/#website" },
        "about": { "@id": "https://thestepzero.in/#organization" },
        "inLanguage": "en-US"
      },`;
    out = out.replace('"@graph": [', `"@graph": [\n      ${webPage}`);
  }

  return out;
}

function injectCrawlable(html, route, siteUrl, email) {
  const nav = `
      <ul>
        <li><a href="/services">Services</a></li>
        <li><a href="/work">Work</a></li>
        <li><a href="/articles">Insights</a></li>
        <li><a href="/pricing">Pricing</a></li>
        <li><a href="/contact">Contact</a></li>
      </ul>`;

  const seoBlock = `
  <!-- Prerendered crawlable content (removed after Flutter first frame). -->
  <article id="seo-content" data-seo-path="${escapeHtml(route.path)}">
    <h1>${escapeHtml(route.h1)}</h1>
    <p>${escapeHtml(route.body)}</p>
    ${nav}
    <p>Email: <a href="mailto:${escapeHtml(email)}">${escapeHtml(email)}</a></p>
    <p><a href="${escapeHtml(siteUrl)}${route.path === '/' ? '' : route.path}">${escapeHtml(siteUrl)}${route.path === '/' ? '' : route.path}</a></p>
  </article>`;

  const noscript = `
  <noscript>
    <main class="noscript-shell">
      <h1>${escapeHtml(route.h1)}</h1>
      <p>${escapeHtml(route.body)}</p>
      ${nav}
      <p>Email: <a href="mailto:${escapeHtml(email)}">${escapeHtml(email)}</a></p>
    </main>
  </noscript>`;

  let out = html.replace(/<!-- Crawlable fallback[\s\S]*?<\/noscript>/, noscript.trim());
  if (!out.includes('id="seo-content"')) {
    out = out.replace(
      '<div id="main-content" tabindex="-1"></div>',
      `<div id="main-content" tabindex="-1"></div>\n${seoBlock}`,
    );
  } else {
    out = out.replace(/<article id="seo-content"[\s\S]*?<\/article>/, seoBlock.trim());
  }

  // Hide SEO block once Flutter paints; keep it in first HTML for crawlers.
  if (!out.includes('seo-content') || !out.includes("getElementById('seo-content')")) {
    out = out.replace(
      "el.setAttribute('aria-busy', 'false');",
      `el.setAttribute('aria-busy', 'false');
      var seo = document.getElementById('seo-content');
      if (seo) seo.setAttribute('data-hydrated', 'true');`,
    );
  }

  // Keep #seo-content in the DOM for crawlers, visually hidden to avoid CLS/LCP fights.
  if (!out.includes('#seo-content {')) {
    out = out.replace(
      'noscript a { color: #5B5FEF; }',
      `noscript a { color: #5B5FEF; }
    #seo-content {
      position: absolute;
      width: 1px;
      height: 1px;
      padding: 0;
      margin: -1px;
      overflow: hidden;
      clip: rect(0, 0, 0, 0);
      white-space: nowrap;
      border: 0;
    }`,
    );
  }

  return out;
}

function ensureBaseHref(html) {
  // Nested routes must resolve assets from site root.
  return html.replace(/<base href="[^"]*">/, '<base href="/">');
}

function writeRoute(html, routeDir) {
  fs.mkdirSync(routeDir, { recursive: true });
  fs.writeFileSync(path.join(routeDir, 'index.html'), html, 'utf8');
}

function build404(template, siteUrl, email) {
  let html = ensureBaseHref(template);
  html = replaceMeta(html, {
    title: 'Page not found · StepZero',
    description: 'This page does not exist on StepZero.',
    canonical: `${siteUrl}/404`,
    image: `${siteUrl}/og-image.png`,
    type: 'website',
    noIndex: true,
  });
  html = injectCrawlable(
    html,
    {
      path: '/404',
      h1: 'Page not found',
      body: 'This URL is not part of the StepZero site. Head home or contact us.',
    },
    siteUrl,
    email,
  );
  // Soften Flutter boot on 404 — still OK if app loads; crawlers see noindex.
  return html;
}

function main() {
  if (!fs.existsSync(buildWeb)) {
    console.error(`Missing ${buildWeb}. Run flutter build web first.`);
    process.exit(1);
  }
  const indexPath = path.join(buildWeb, 'index.html');
  const template = fs.readFileSync(indexPath, 'utf8');
  const config = JSON.parse(fs.readFileSync(routesPath, 'utf8'));

  let count = 0;
  for (const route of config.routes) {
    const canonical =
      route.path === '/'
        ? `${config.siteUrl}/`
        : `${config.siteUrl}${route.path}`;

    let html = ensureBaseHref(template);
    html = replaceMeta(html, {
      title: route.title,
      description: route.description,
      canonical,
      image: config.ogImage,
      type: route.type || 'website',
      noIndex: false,
    });
    html = injectCrawlable(html, route, config.siteUrl, config.contactEmail);

    if (route.path === '/') {
      fs.writeFileSync(indexPath, html, 'utf8');
    } else {
      writeRoute(html, path.join(buildWeb, route.path.replace(/^\//, '')));
    }
    count += 1;
  }

  fs.writeFileSync(
    path.join(buildWeb, '404.html'),
    build404(template, config.siteUrl, config.contactEmail),
    'utf8',
  );

  // Help some static hosts map unknown routes.
  fs.writeFileSync(
    path.join(buildWeb, '_redirects'),
    '/*    /404.html  404\n',
    'utf8',
  );

  console.log(`→ Prerendered ${count} SEO shells + 404.html`);
}

main();
