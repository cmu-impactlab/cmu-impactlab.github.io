# AGENTS.md

This file provides guidance to AI coding agents (Claude Code, Codex, and similar tools) when
working with code in this repository.

## What this is

The Jekyll-based static site for IMPACTLab (Interdisciplinary Methods for Applied Cyber-physical
Technologies in Society), a research lab at Carnegie Mellon University in Qatar. Deployed via
GitHub Pages (custom domain in `CNAME`). There is no application code, build tooling, or test
suite — content changes are made almost entirely by editing YAML/Markdown data files.

## Local development

```bash
./jekyll_serve.sh   # runs `jekyll serve` inside jekyll/jekyll:3 Docker container, --net=host
```
Site is then served at http://127.0.0.1:4000/. There's no Node/npm build step — Jekyll handles
Sass compilation (`style.scss` → site CSS) and Liquid templating directly.

Alternative (non-Docker) local setup, per README: install Ruby, `gem install github-pages`
(mirrors the GitHub Pages gem set), then `jekyll serve`.

CI (`.gitlab-ci.yml`) just runs `jekyll build -d public` on the `master` branch — GitHub Pages
itself does the equivalent build/deploy on push, no separate deploy step to trigger manually.

There are no automated tests, linters, or CI checks beyond the Jekyll build succeeding. Verifying
a change means running `jekyll serve` and checking the rendered page in a browser.

## Content model (the main thing to know)

Three Jekyll collections plus one data file drive nearly all content:

- **`_data/members.yml`** — the single source of truth for every lab member (faculty, current
  students, alumni, collaborators). Each entry has an `id` (used everywhere else to reference
  this person — by convention, their CMU/Andrew username), `name`, `image`, optional `website`,
  `status` (`faculty`, `current`, `visiting`, `alumni`, `master_alumni`, `ugrad_alumni`,
  `collab`, `past_collab`, `summer_alumni`, ...), `degree`, `affiliation` (a key into
  `_data/affiliations.yml`).
- **`_projects/*.md`** — one file per research project. Front matter only, no body content is
  rendered by `_layouts/project.html`. Key fields: `authors` (list — mix member `id`s and free-text
  names, see below), `pubs` (list of publication `name`s to cross-link), `onhomepage`,
  `thumbnail`/`image`, `status` (`current`, etc.), `date`.
- **`_publications/*.md`** — one file per paper. Front matter drives `_layouts/publication.html`.
  Key fields: `authors`, `conference`, `date`, `pdf`, `thumbnail`/`image`, `abstract`, `citation`,
  `bibtex` (literal block), `blurb` (one-line homepage summary), `onhomepage`, `name` (short
  slug/name used by `_projects/*.md` `pubs:` lists to cross-reference this paper).
- **`_posts/`** — standard Jekyll blog posts (barely used — one placeholder post).

**Author linking mechanism**: `_includes/author_list.html` takes an `authors` list and, for each
entry, looks it up against `site.data.members` by `id`. If found, it renders a link to
`member.website` (or plain name if no website); if not found, it renders the string as-is. This
means authors who are lab members should be referenced **by their `members.yml` id**, not by
full name, to get auto-linking — everyone else (external co-authors) is written as a plain name
string in the same `authors` list.

**Homepage highlights**: `index.html` concatenates `site.projects` and `site.publications`,
filters to `onhomepage: true`, sorts by `date`, and renders each as a badge using `image`
(falling back to `thumbnail`) and `blurb` (falling back to `title`). A `date` in the future
renders a "Coming Soon!" overlay instead of a link (see the `pub.date > site.time` /
`pub.date < site.time` checks) — this is how not-yet-published papers/projects can be teased.

**Images**: member photos go in `images/members/` (square, ideally 165×165px); publication
images/thumbnails in `images/pubs/` (thumbnail: 16:9 @ ≥300px wide; hero image: 3:2 aspect);
project images in `images/projects/`.

## Adding content (the common tasks)

- **New lab member**: add an entry to `_data/members.yml`, upload photo to `images/members/`.
- **New publication**: this is common enough to have a dedicated runbook — see
  `.claude/skills/add-publication/SKILL.md` for the full step-by-step (extracting metadata from
  the PDF, matching authors to `members.yml`, generating a representative thumbnail, writing the
  front matter, linking to a project). Short version: copy `resources/template.md` (or an
  existing `_publications/*.md` file) into `_publications/<slug>.md`. Copy `bibtex` and
  `citation` verbatim from the ACM DL when the paper is ACM-published, not from Google Scholar
  (for other venues, ask for the BibTeX rather than guessing venue/DOI). `resources/process_bibtex.py`
  can semi-automate this from a BibTeX entry exported from ACM DL (fetches abstract/PDF/citation
  by scraping `dl.acm.org` — fragile, ACM-specific, effectively unmaintained tooling; treat it as
  a starting point, not something to build new features on).
- **New project**: add a file to `_projects/`, following the pattern in an existing entry (e.g.
  `_projects/ershad.md`). Reference lab-member authors by their `members.yml` id; reference
  related papers by their publication `name` in the `pubs:` list.

## Layouts/includes worth knowing about

- `_layouts/default.html` — site chrome (nav, footer) wrapping every page.
- `_layouts/project.html` / `_layouts/publication.html` — render `_projects` / `_publications`
  collection entries from front matter (see fields above); `project.html.old` is a stale unused
  file, not part of the active build.
- `_layouts/personal.html` — appears to back individual member pages (not the shared `members/index.html` roster page).
- `members/index.html`, `projects/index.html`, `publications/index.html` — the roster/listing
  pages, grouped and filtered by `status` (members) using Liquid `where`/`sort` filters over
  `site.data.members` / `site.projects` / `site.publications`.
- `_sass/*.scss`, compiled together via `style.scss` — one partial per concern
  (`_members`, `_publications`, `_home`, `_highlights`, `_svg-icons`, `_variables`, `_reset`).
- Front-end JS dependencies (jQuery, Bootstrap) are vendored via Bower into `bower_components/`
  (`bower.json`) — there is no npm/webpack pipeline.
