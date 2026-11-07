---
name: add-member
description: Use when adding a person (student, collaborator, alumnus) to the IMPACTLab site, when the user pastes someone's name / Andrew ID / program / website and a photo dropped into images/members/, when connecting a person to a project, or when asked what photo specs to request from students.
---

# Adding a person to the IMPACTLab site

One entry in `_data/members.yml` + one photo in `images/members/`. The `id` is what projects
and publications reference, so a member added here becomes a linked name everywhere.

## Input the user usually pastes

```
1. Full name          → name
2. Andrew ID          → id, email (<id>@andrew.cmu.edu), photo filename
3. Program, year      → degree   (e.g. "CS '28" → "Undergraduate, CS '28")
4. Website/LinkedIn   → website  (add https:// if missing; if two links are given and the
                                  user says which to use, use only that one)
5. Photo              → already dropped in images/members/ (git status shows it untracked)
```

## 1. Photo

Target: **square, 400×400, JPEG, head-and-shoulders, face centred.** The members grid crops
every image to a centred square with `object-fit: cover`, so whatever isn't square gets cut
around the centre, often slicing the top of the head on portrait photos.

Always Read the image first, then pick one case:

| What you see | Command |
|---|---|
| Square, well framed, >400px | `convert in -resize 400x400 -quality 85 images/members/<id>.jpg` |
| Square but face small (lots of sky/background) | crop around the head first: `-crop SxS+X+Y +repage -resize 400x400` |
| Not square | crop a square yourself, anchored so the **hair top stays in**, often slightly above centre: `-crop WxW+0+<small y> +repage` |
| Person doesn't want a photo shown | no file; set `image: /images/members/dummy.png` (shared placeholder silhouette) |
| Smaller than 400px | crop square but **don't upscale**; tell the user it may look soft and ask for a larger one |

Read the result once more. Save as `images/members/<id>.jpg`. If the input had a different
name or extension (`.png`, `.jpeg`), delete the original after converting, and tell the user
(Dropbox keeps version history). If you overwrite the user's file in place, copy the original
to the scratchpad first.

## 2. `_data/members.yml` entry

Append at the end, matching existing entries exactly:

```yaml

# Jana
- id: jhussien
  name: Jana Hussien
  image: /images/members/jhussien.jpg
  website: https://www.linkedin.com/in/jana-hussien/
  email: jhussien@andrew.cmu.edu
  status: current
  degree: Undergraduate, CS '28
  affiliation: QSCS
```

- `status` must be one the roster renders (`members/index.html`): `faculty`, `current`,
  `collab` (external collaborators) or `alumni`. Other values seen in the file
  (`past_collab`, `master_alumni`, …) are **not shown anywhere**: the person silently
  disappears from the page.
- `affiliation` is a key into `_data/affiliations.yml` (`QSCS` for CMU-Q CS students).
- Omit `website` entirely if none was given; the name then renders as plain text.

## 3. Connect to projects and papers

- **Project:** append the `id` to the project's `authors:` list in `_projects/<x>.md`
  (after existing members unless the user specifies an order).
- **Existing papers:** `grep -rln "<Full Name>" _publications _projects`. If the person is
  already listed there as a plain-text name, replace it with the `id` in `authors:` so their
  name gets linked. Leave `citation:` / `bibtex:` text unchanged.

## 4. Verify

```bash
python3 -c "import yaml; print([m['id'] for m in yaml.safe_load(open('_data/members.yml'))][-3:])"
docker run --rm -v "$PWD":/site -v jekyll-bundle:/usr/local/bundle --entrypoint sh \
  bretfisher/jekyll:latest -c 'cd /site && bundle exec jekyll build 2>&1 | grep -iE "error|done"'
grep -c "<Full Name>" _site/members/index.html _site/projects/<x>/index.html
```
No `--net=host` (IPv6 is broken on this network). Report: the entry, what you did to the photo
(and where the original went), the project/paper links, and anything assumed. Don't commit
unless asked.

## Photo specs to send students

Square, ≥400×400 (400–800 ideal), JPEG under ~300 KB, head and shoulders with the face centred,
plain background, good light, recent; no group shots or heavy filters. Also ask for: full name,
Andrew ID, program and year, optional website.
