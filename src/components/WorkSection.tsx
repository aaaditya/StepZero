import { workProjects } from "../lib/work";

type Props = {
  heading?: string;
  lede?: string;
};

export function WorkSection({
  heading = "Work",
  lede = "Selected software and sites we can show. Client systems that must stay private stay private.",
}: Props) {
  const [featured, ...rest] = workProjects;

  return (
    <section className="section work" id="work" aria-labelledby="work-title">
      <div className="section-meta">
        <h2 id="work-title">{heading}</h2>
        <p className="lede">{lede}</p>
      </div>

      {featured ? (
        <article className="work-feature">
          <div className="work-feature__meta">
            <p className="work-kicker">{featured.kind}</p>
            <h3>{featured.title}</h3>
            {featured.note ? <p className="work-note">{featured.note}</p> : null}
          </div>
          <div className="work-feature__body">
            <p>
              <span className="work-label">For</span>
              {featured.forWhom}
            </p>
            <p>
              <span className="work-label">Built</span>
              {featured.built}
            </p>
            <p>
              <span className="work-label">Stack</span>
              {featured.stack}
            </p>
          </div>
        </article>
      ) : null}

      <ul className="work-list">
        {rest.map((project) => (
          <li key={project.slug}>
            <article className="work-card">
              <p className="work-kicker">{project.kind}</p>
              <h3>{project.title}</h3>
              <p>
                <span className="work-label">For</span>
                {project.forWhom}
              </p>
              <p>
                <span className="work-label">Built</span>
                {project.built}
              </p>
              <p>
                <span className="work-label">Stack</span>
                {project.stack}
              </p>
              {project.link ? (
                <a
                  className="work-link"
                  href={project.link.href}
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  {project.link.label}
                </a>
              ) : null}
            </article>
          </li>
        ))}
      </ul>
    </section>
  );
}
