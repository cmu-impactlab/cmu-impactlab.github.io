---
name: add-project
description: Use when adding a new research project to the IMPACTLab site, when the user pastes a project title/abstract/funding/dates/team, when a project image is dropped into images/projects/, when linking papers or people to a project, or when a project ends and should move to past projects.
---

# Adding a project to the IMPACTLab site

One file, `_projects/<shortname>.md`, front matter only (the layout ignores the body). It shows
up on `/projects/`, its own page `/projects/<shortname>/`, and (if `onhomepage: true`) as a
homepage highlight card.

## Template

```yaml
---
abstract: '
<abstract verbatim from the user>
'
authors:
- Eduardo Feo Flushing (LPI)
- kharras
- mai

image: /images/projects/morshed.jpeg
name: Morshed
onhomepage: true
thumbnail: /images/projects/morshed_thumb.jpg
title: 'Morshed: A Personalized and Multimodal Ubiquitous Indoor Navigation System (CMU-Q Accelerator Grant)'
year: '2026'
date: '2026-07-01'
end_date: '2029-07-01'
status: current
pubs:
  - graphwalker
  - Tesseract
---
```

## Field rules

| Field | Rule |
|---|---|
| `title` | `'<Name>: <Subtitle> (<Funder> - <Program>)'`, e.g. `(QRDI - UREP)`, `(CMUQ-SURA)`, `(CMU-Q Accelerator Grant)`. Clean up pasted text: duplicated "Name: Name:", line breaks, typos. Escape `'` as `''` (e.g. `Qatar’s` is fine; `Qatar's` needs `''`). |
| `authors` | First entry is always the plain string `Eduardo Feo Flushing (LPI)`. Then lab members by **`members.yml` id** (map first names: "Mai" → `mai`, "Yaqoob" → `yansari`, "Khaled Harras" → `kharras`, "marco" → `mcasagra`). If a person isn't in `members.yml` yet, add them first (**REQUIRED SUB-SKILL:** add-member) or use a plain name and tell the user. |
| `date` / `year` | Project **start** date (`YYYY-MM-DD`; "July 2026" → `2026-07-01`). It drives sort order and the "new" badge. A future start date shows "Coming Soon!" and makes the card unclickable. |
| `end_date` | Store it if given. **Nothing renders it yet**; tell the user so. |
| `status` | `current` or `past`; **only these two render** on `/projects/`. |
| `name` | Short name shown on the homepage card. |
| `pubs` | List of publication `name:` values (exact match; `grep -h "^name:" _publications/*.md`). A paper can belong to several projects; "link X to Y" means **add**, not move. An empty `pubs:` must stay a bare key or become a proper list. |
| `onhomepage` | `true` for new projects. |
| `highlight_badge` | Don't set it. `index.html` auto-badges items dated within the last 90 days ("new project!"). Set `highlight_badge: '<text>'` only if the user wants a custom/forced label (it never expires), or `false` to suppress. |

## Images

`image` is **required** whenever the project is on the homepage or has a page: the card and the
project page render `<img src="{{ image }}">`, and an empty one shows a broken image.

- **User supplied one** (`images/projects/<name>.jpeg`): Read it, keep the original as `image`,
  and make a thumbnail:
  `convert images/projects/<n>.jpeg -resize 400x -quality 85 images/projects/<n>_thumb.jpg`
  (square sources: `-resize 300x300`).
- **None yet:** point `image`/`thumbnail` at a fitting existing figure (e.g. a related paper's
  `images/pubs/*.png`); don't copy files you'll have to delete later. Tell the user it's a
  placeholder and ask for an image.
- When swapping a placeholder out, check the old file still exists before `rm` (the user may
  have deleted it); never chain the path edit after `rm` with `&&`.

## Ending a project

Set `status: past`. Consider `onhomepage: false` (ask). Its papers stay linked.

## Verify

```bash
python3 -c "import yaml; yaml.safe_load(open('_projects/<n>.md').read().split('---')[1]); print('ok')"
docker run --rm -v "$PWD":/site -v jekyll-bundle:/usr/local/bundle --entrypoint sh \
  bretfisher/jekyll:latest -c 'cd /site && bundle exec jekyll build 2>&1 | grep -iE "error|done"'
ls _site/projects/<n>/index.html
grep -o '<n>[_a-z]*\.[a-z]*' _site/index.html _site/projects/index.html   # right image files
```
No `--net=host` (IPv6 is broken here). Report: title as written (and what you cleaned up), team,
dates (note `end_date` isn't displayed), image/placeholder status, linked papers, badge state.
Don't commit unless asked.
