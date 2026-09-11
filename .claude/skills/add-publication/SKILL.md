---
name: add-publication
description: Use when the user has dropped a new paper PDF into pdfs/ and asks to add it to the site (publications list, homepage, and/or a project page). Covers extracting metadata from the PDF, matching authors to lab members, generating a representative thumbnail, and wiring up cross-links.
---

# Adding a publication to the IMPACTLab site

This site is a Jekyll site (see root `CLAUDE.md` for the general content model:
`_data/members.yml`, `_projects/`, `_publications/`, author-id linking, homepage
highlights). This skill is the step-by-step for the single most common content task:
turning a dropped-in PDF into a fully wired-up publication entry.

## 1. Find the PDF and read it

The PDF will be in `pdfs/`, usually just added and untracked in git (`git status` shows it).
Read the first 1-2 pages (use the `Read` tool with `pages: "1-2"`, it renders as an image)
to get: exact paper title, full author list in paper order, and the abstract. Use
`pdftotext` on the whole PDF if you need to grep for a venue name, DOI, or "to appear" /
"under review" language that isn't on page 1.

**Do not guess the venue.** If the PDF itself doesn't state where it was
published/accepted (common for preprints/author manuscripts), ask the user for it or for
the BibTeX entry — don't fabricate a journal/conference name, volume, or DOI. If the user
gives you a BibTeX entry, prefer it over anything scraped from the PDF for venue/year/DOI,
but still pull the abstract from the PDF (BibTeX rarely has one).

## 2. Match authors to lab members

Open `_data/members.yml`. For each author on the paper, check if they're a lab member —
name matching is fuzzy in practice (e.g. a paper byline "Mohammed Yaqoob" can be the same
person as `members.yml` entry `name: Yaqoob Ansari, id: yansari`; check existing
`_publications/*.md` files for how that person was previously referenced if unsure).

- If they're a member: use their `id` in the `authors:` list (this is what makes
  `_includes/author_list.html` auto-link them).
- If they're not a member (external collaborator): put their plain full name as a string
  in the same `authors:` list.
- For the `citation:` string (human-readable, not BibTeX), always spell out full names for
  everyone, including members — look at an existing `_publications/*.md` file's `citation`
  field for the exact phrasing style ("Full Name, Full Name, ..., and Full Name. YEAR.
  Title. Venue.").

## 3. Generate a representative thumbnail image

Convention for recent entries (check `git log --oneline -- images/pubs/` for the pattern):
`image:` and `thumbnail:` point at the *same* file, a cropped figure from the paper (not a
full first-page screenshot) — usually the main system/pipeline diagram.

1. Render the page containing the best figure at high res:
   `pdftoppm -png -r 300 -f <page> -l <page> pdfs/<file>.pdf <scratch>/page`
2. Read the rendered PNG (via the `Read` tool) to find the figure's pixel bounding box.
3. Crop with a margin, generous enough not to clip the figure:
   `convert <scratch>/page-XX.png -crop <W>x<H>+<X>+<Y> +repage <scratch>/fig_crop.png`
4. Re-read the crop, adjust the box if anything got clipped.
5. Trim whitespace and add a small white border:
   `convert <scratch>/fig_crop.png -trim +repage -bordercolor white -border 20 <scratch>/fig_trimmed.png`
6. Resize to a reasonable width and save into the repo:
   `convert <scratch>/fig_trimmed.png -resize 700x images/pubs/<slug>-<venue-abbrev>-<year>.png`

Filename convention: lowercase, hyphenated, short-name + venue abbreviation + year, e.g.
`thermal-homography-tpec-2025.png`, `daredevil-icc-2025.png`.

If no figure is suitable (e.g. a text-only theory paper), a cropped title/abstract region
or a diagram from a later page both work — the goal is just a recognizable, mostly-graphical
thumbnail, not a literal "first page screenshot" despite what old commit messages say.

## 4. Write the publication file

Copy `resources/template.md` or an existing `_publications/*.md` entry as a starting point.
Filename: slugified full paper title, in `_publications/<slug>.md`.

Required front matter fields (see any existing file for exact formatting):
- `title` — verbatim from the paper.
- `authors` — list, member ids + external plain names (see step 2).
- `conference` — venue string, e.g. `'IEEE Transactions on Industry Applications, 2026'`.
- `date` — publication date (`YYYY-MM-DD`). If unknown, and the paper is already
  out/accepted, using today's date is fine — it just needs to be `<=` the current date so
  the publication page shows PDF/citation/bibtex immediately (see
  `_layouts/publication.html`: fields are hidden while `page.date > site.time`, which is
  the "Coming Soon" mechanism for not-yet-public papers).
- `year`
- `name` — short slug/display name used to cross-reference this paper from a project's
  `pubs:` list (step 5). Keep it short and distinct from other papers on the same project.
- `pdf` — `/pdfs/<original pdf filename>`, URL-encode spaces if the filename has them.
- `thumbnail` / `image` — both point at the file made in step 3.
- `abstract` — verbatim from the paper.
- `citation` — human-readable citation string (step 2).
- `bibtex` — literal block (`bibtex: |`). If the user supplied a BibTeX entry, **replace
  its citation key** with something readable before pasting it in — IEEE-exported BibTeX
  keys are often raw article numbers (e.g. `11576598`); use `AuthorYearShortTitle` instead
  (e.g. `Yaqoob2026HomographyBenchmarkPV`), matching the style of existing entries. You can
  also drop noisy auto-generated fields like a giant `keywords` list if other entries don't
  carry them.
- `blurb` — one sentence, used on the homepage highlight card.
- `onhomepage` — `true` to feature it (see step 6 for what this triggers).

Validate the YAML parses before moving on:
`python3 -c "import yaml; yaml.safe_load(open('_publications/<slug>.md').read().split('---')[1])"`

## 5. Link it to a project (if applicable)

If the paper belongs to an existing `_projects/*.md` entry, add the publication's `name`
(from step 4) to that project's `pubs:` list.

## 6. Homepage

Nothing extra to do — `index.html` automatically concatenates `site.projects` and
`site.publications`, filters `onhomepage: true`, and sorts by `date` (newest last, then
rendered `reversed`, so newest appears first). Setting `onhomepage: true` and a `date` of
today or earlier is sufficient for the new paper to show up as a homepage highlight
immediately, using `image` (falling back to `thumbnail`) and `blurb` (falling back to
`title`).

## 7. Sanity check

There's no test suite. Confirm by running `./jekyll_serve.sh` and checking the new paper
renders correctly on `/publications/`, its own permalink page, the project page (if
linked), and the homepage.
