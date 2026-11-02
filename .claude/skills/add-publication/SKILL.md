---
name: add-publication
description: Use when the user has dropped one or more new paper PDFs into pdfs/ (often with throwaway names like 188.pdf) and asks to add them to the site (publications list, homepage, and/or a project page). Covers extracting metadata, matching authors to lab members, dating "to appear" papers, renaming the PDF, cropping a representative figure as thumbnail, linking projects, and verifying the build.
---

# Adding a publication to the IMPACTLab site

Jekyll site; see root `AGENTS.md` for the content model (`_data/members.yml`, `_projects/`,
`_publications/`, author-id linking, homepage highlights). This is the end-to-end runbook for
turning a dropped-in PDF into a fully wired-up publication. With several PDFs, do every step
for each one; work on them side by side (batch the shell calls), not one after the other.

Use the session scratchpad directory for all intermediate renders/crops (written `$S` below).

## 1. Find the PDF and extract text

`git status --short pdfs/` shows the new, untracked PDFs. Then:

```bash
pdfinfo pdfs/<f>.pdf | grep Pages
pdftotext -l 1 pdfs/<f>.pdf - | head -60          # title, byline, emails, abstract
pdftotext pdfs/<f>.pdf - | grep -iE "to appear|accepted|doi|github|dataset"
```

Match authors by the byline emails, not by names. Look each email up in `members.yml`:
usually the Andrew ID *is* the `id` (`aaryal`, `ma1`, `efeoflus`), but not always
(`maimoonm@andrew.cmu.edu` is `id: mai`), so grep the `email:` field too.

**ACM papers** print an "ACM Reference Format" block on page 1. It gives the exact venue
name, conference dates, location and DOI (`grep -A4 "ACM Reference Format"`). Use it
directly; no web search needed. A DOI like `10.1145/nnnnnnn` is a template placeholder:
leave it out.

**pdftotext mangles text at line ends.** Before pasting the abstract, fix the joins:
words hyphenated across lines get glued together (`privacysensitive`, `attentiongated`,
`resourceconstrained`, `featurelevel`, `pixeland` → `privacy-sensitive`, `attention-gated`,
`resource-constrained`, `feature-level`, `pixel- and`). Real hyphens and en dashes
(`encoder–decoder`, `efficiency–accuracy`) must stay. Also watch for `32 × 24`-style math.
Otherwise keep the abstract verbatim.

## 2. Venue and date

**Never guess the venue.** Take it from the user's message, the PDF, or a BibTeX entry they
provide. If none of those gives it, ask.

For accepted, not-yet-published papers ("to appear at X"), follow the site's convention:

- `date:` = the conference's **first day** (look it up with WebSearch, e.g. "IEEE VCIP 2026
  dates"; cite the source to the user). A future date is deliberate. While
  `date > site.time`, the homepage card shows "Coming Soon!", the listing shows "To appear
  in", and the PDF/citation/BibTeX buttons stay hidden. They appear automatically on that
  date (`_config.yml` has `future: true`, which keeps future-dated entries in the build).
- `citation:` year written as `2026 (to appear)`; BibTeX `year={2026 (to appear)}` with no
  DOI/pages/volume (see `_publications/llm_based_post_asr_error_correction_for_disordered_speech.md`).
- For a journal paper that is already published, use the actual publication date and the
  real DOI.

`conference:` format: `'IEEE International Conference on Visual Communications and Image
Processing (VCIP), 2026'`, i.e. full name, abbreviation in parentheses, then a comma and the year.

## 3. Authors

For each author in byline order:
- Lab member (Andrew ID in byline email matches a `members.yml` `id`) → use the `id`.
- Otherwise → their plain full name as a string.

Equal-contribution asterisks are dropped. In `citation:` and BibTeX, spell every name **as
printed in this paper's byline**. Members' bylines sometimes differ from `members.yml`
(e.g. `yansari` appears as "Yaqoob Ansari" or "Mohammed Yaqoob").

## 4. Rename the PDF to the paper title

```bash
mv pdfs/188.pdf "pdfs/<Title_With_Underscores>.pdf"
```
Rule: spaces → `_`, `: ` → `__`, keep hyphens and capitalization, drop other punctuation
(`?`, `,`, `'`). Example:
`MASP-UNet: Acquisition-Aware ...` → `MASP-UNet__Acquisition-Aware_..._in_Ultrasound.pdf`.
If the file is untracked, a plain `mv` is fine; use `git mv` if it is already tracked.
If the user already renamed it, still compare the name against the full title: user-chosen
names are often truncated (e.g. a missing subtitle) and should be fixed.

## 5. Thumbnail: crop a representative figure

`image:` and `thumbnail:` both point at the same file, a cropped figure (usually Fig. 1,
the architecture or pipeline diagram), not a page screenshot.

1. Find the candidate figures and the pages they're on:
   ```bash
   for p in $(seq 1 N); do pdftotext -f $p -l $p pdfs/<f>.pdf - | grep -oE "(Fig\. [0-9]+\.|Figure [0-9]+:)[^.]*" | sed "s/^/p$p: /"; done
   ```
   (IEEE uses "Fig. 1.", ACM uses "Figure 1:", CVF-style uses "Figure 1.".) For demo papers,
   prefer the screenshot of the system's interface over the pipeline diagram. If Fig. 1 is
   mostly a table or text (layer specs etc.), use the headline-result plot instead, e.g. an
   accuracy-vs-parameters chart for an efficiency paper.
2. Render that page twice: a small preview at 60 dpi for finding coordinates, and a 300 dpi
   copy for cropping (coordinates scale ×5):
   ```bash
   pdftoppm -png -r 60  -f P -l P pdfs/<f>.pdf $S/prev
   pdftoppm -png -r 300 -f P -l P pdfs/<f>.pdf $S/hi
   ```
3. Read the preview, estimate the figure's box, multiply by 5, and crop **generously**:
   `convert $S/hi-P.png -crop WxH+X+Y +repage $S/crop.png`
4. Read the crop. Two gotchas:
   - The Read tool may downscale large images and print a note like "multiply coordinates
     by 1.13". Apply that factor when you tighten the box.
   - The first line of the **caption** ("Fig. 1. ...") almost always slips in at the bottom.
     Lower the crop height until it's gone, and make sure nothing on the left or right
     edge got clipped.
   - For figures at the top of a page, the **running header** (title / "SIGSPATIAL '26, ...")
     slips in at the top. Start the crop below it. Likewise, when figures are stacked, the
     *previous* figure's caption slips in at the top.
   - A legend row half cut off at the bottom looks worse than none. Include it fully or
     cut above it.
5. Finish (trim whitespace, add a white border, resize to 700px wide) and save into the repo:
   ```bash
   convert $S/crop.png -crop WxH'+0+0' +repage -trim +repage -bordercolor white -border 20 \
     -resize 700x images/pubs/<shortname>-<venue>-<year>.png
   ```
   Naming: lowercase and hyphenated, e.g. `masp-unet-vcip-2026.png`,
   `thermal-navigability-vcip-2026.png`.
6. Read the final PNG once more to confirm it is clean.

## 6. Write `_publications/<slug>.md`

Slug = full title lowercased, non-alphanumerics → `_`, collapsed (e.g.
`masp_unet_acquisition_aware_lightweight_segmentation_of_renal_structures_in_ultrasound.md`).
Fields, in this order (copy an existing file for quoting style, single-quoted strings):

`title`, `authors`, `conference`, `date`, `year`, `name`, `pdf` (`/pdfs/<renamed>.pdf`),
`thumbnail`, `image`, `abstract`, `citation`, `bibtex: |`, `blurb`, `onhomepage`.

- `name`: short display name, unique across all publications. It's how projects reference
  the paper. The method name (`MASP-UNet`) works well; otherwise a 2–3 word topic. First
  `grep -h "^name:" _publications/*.md`. Follow-up papers reuse system names (an existing
  `graphwalker` workshop paper and `Tesseract` full paper), so add a qualifier:
  `GraphWalker SIGSPATIAL`, `Tesseract Demo`.
- Demo, poster and workshop papers are separate entries. Keep `[Demo]` etc. in the title as
  printed.
- BibTeX key: `FirstAuthorSurnameYearShortName` (e.g. `Aryal2026MASPUNet`). Replace raw
  IEEE numeric keys; drop huge `keywords` fields.
- `blurb`: one plain-language sentence for the homepage card. Don't start it with the title.
  Take any numbers from the abstract's headline claims, not from figure annotations.
- `onhomepage: true` for new papers unless the user says otherwise.
- Titles containing `'` must be escaped as `''` inside single-quoted YAML.

Validate:
```bash
python3 -c "import yaml,sys; [yaml.safe_load(open(f).read().split('---')[1]) for f in sys.argv[1:]]; print('ok')" _publications/<slug>.md
```

Ordering: listings are newest `date` first. Always use the real date; never adjust it to
move a paper up or down the list. If the user asks for a specific order, tell them what
real dates produce and ask before changing anything.

## 7. Link to a project

`grep -l . _projects/*.md` and read the candidates' titles/abstracts. Pick by topic: kidney
ultrasound → `lightweight_image_segmentation_kidney_ultrasound.md`; indoor navigation and
thermal or wearable sensing → `ershad.md`; PV inspection or cleaning → `tubitak_pv_cleaning.md`.
Append the paper's `name` to the project's `pubs:` list. `_layouts/project.html` matches on
`pub.name` exactly. If `pubs:` is empty (a bare `pubs:` line), turn it into a list:
```yaml
pubs:
  - MASP-UNet
```
If no project fits, skip this step and say so to the user.

## 8. Verify the build

```bash
docker run --rm -v "$PWD":/site -v jekyll-bundle:/usr/local/bundle --entrypoint sh \
  bretfisher/jekyll:latest -c 'cd /site && bundle install --quiet && bundle exec jekyll build 2>&1 | tail -3'
ls _site/publications/<slug>/index.html
grep -c "<Title fragment>" _site/index.html _site/publications/index.html
grep -l "<Title fragment>" _site/projects/*/index.html
```
Don't use `--net=host`: IPv6 is broken on this network, and with host networking Bundler
can't reach rubygems.org. For a visual check, the user runs `./jekyll_serve.sh` and opens
http://127.0.0.1:4000/.

## 9. Report

Tell the user: the renamed PDF paths, the entry files, which figure became the thumbnail,
the date used and where it came from (with source link), any project links, and anything
assumed (e.g. a name spelled per byline). Do not commit unless asked.
