---
name: add-position
description: Use when the user wants to advertise an open position (research assistant, independent study, SURA/QSIURP, paid role) on the IMPACTLab site, pastes a position description or deadline, or wants to edit, extend or remove a posting.
---

# Advertising a position on the IMPACTLab site

Positions live in `_data/positions.yml` (a YAML list; `[]` when empty). `_includes/open_positions.html`
renders them as an "Open Positions" section on `/join/` (Get Involved) and as a "We're currently
looking for" line in the homepage collaborate box. With no open positions both disappear.

## Entry

```yaml
- id: dalilsense-sensing-s27
  title: 'Wearable Sensing Prototype for DalilSENSE'
  project: dalilsense
  type: 'Paid research assistant'
  start: 'Spring 2027'
  deadline: 2027-01-15
  description: >
    What the student will work on, in 2-4 sentences.
  requirements: >
    Who we're looking for (courses, skills, availability).
  apply_url: ''
```

| Field | Rule |
|---|---|
| `id` | Unique, lowercase-hyphenated; becomes the `/join/#<id>` anchor the homepage links to. |
| `title` | Short role title, single-quoted (`''` for apostrophes). |
| `project` | Optional. The project **file name without `.md`** (`ls _projects`); renders a link to it. Omit if none. |
| `type` | As the user says it (Independent study, Volunteer, Paid research assistant, SURA/QSIURP). |
| `deadline` | **Required**, `YYYY-MM-DD`, last day to apply. If the user gives none, ask. |
| `description` / `requirements` | From the user's text, lightly edited; plain text. |
| `apply_url` | Optional. Empty → the posting tells students to go through the Read First doc (the application form lives inside it, on purpose). Only set it when the user gives a position-specific form/link. |

## Expiry

A position shows through the end of its deadline day (Qatar time). Expired entries are skipped at
build time **and** hidden by a small script in the browser, because GitHub Pages only rebuilds on
push. So nothing has to be done on the deadline; delete old entries when editing the file anyway.
To extend a posting, change `deadline`.

## Verify

```bash
python3 -c "import yaml; print(yaml.safe_load(open('_data/positions.yml')))"
docker run --rm -v "$PWD":/site -v jekyll-bundle:/usr/local/bundle --entrypoint sh \
  bretfisher/jekyll:latest -c 'cd /site && bundle exec jekyll build 2>&1 | grep -iE "error|done"'
grep -c 'id="<id>"' _site/join/index.html; grep -c 'join/#<id>' _site/index.html
```
No `--net=host`. Report the posting as it will read, the deadline, and the apply route. Don't
commit unless asked.
