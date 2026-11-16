# Future improvements

Ideas for the site that were discussed but not done yet. Not published (excluded in `_config.yml`).

## Publications page

- **Year jump links.** The list is already divided by year (`<h2 class="pub-year" id="y2025">`
  in `publications/index.html`), so a row of links at the top (`2026 · 2025 · 2024 · 2021`)
  pointing at `#y<year>` would let visitors jump between sections. Build the row from the same
  sorted list so new years appear automatically.

- **GraphWalker SIGSPATIAL DOI.** `10.1145/3841645.3843004` isn't registered yet (checked 2026-11-16); uncomment the `doi:` line in its entry once the link resolves.

## Projects

- **Show the project period.** Projects store `date` (start) and `end_date`, but nothing renders
  `end_date`. Show e.g. "Nov 2026 – Nov 2027" on `/projects/` and the project page.

## Members

- **Hidden collaborators.** Tram Tran and Ghani Raissov have `status: past_collab`, which
  `members/index.html` doesn't render, so they don't appear anywhere. Decide whether they should
  be `alumni` or `collab`.
- **Degree years.** Newer students have their graduation year (`Undergraduate, CS '28`); older
  entries don't. Fill them in for consistency.
