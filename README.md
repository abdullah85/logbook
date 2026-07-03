# logbook

Recording the progress I make regularly while exploring various tools, approaches and systems in my technical journey,  drawing inspiration from the original meaning of the term logbook that originated with the ship's log, a maritime record of important events in the management, operation, and navigation of a ship

## Structure

```
logbook/
├── README.md
├── entries/
│   ├── 2026-07/
│   │   ├── 2026-07-03-short-slug.md
│   │   └── 2026-07-05-another-slug.md
│   └── 2026-08/
│       └── ...
└── INDEX.md          (optional, generated or hand-updated tag index)
```

- One folder per month (`entries/YYYY-MM/`) keeps any single directory from
  becoming unbrowsable after a year or two.
- One file per entry, named `YYYY-MM-DD-short-slug.md` and the date prefixes
  result in entries sorting correctly without additional tooling.
- No build step, no static site generator, no dependencies. It's just
  markdown files in a git repo. Clone it, open it in any editor, done.

## Workflow

1. Finish something worth remembering (merged a PR, closed an issue, hit and
   solved a weird bug, made a design decision).
2. Copy `entries/_template.md`, rename it, fill it in. 5–10 minutes, same day
   if possible.
3. Commit and push. That's the whole publishing step — no drafts folder, no
   CMS, no "publish" button.

## Tags

Free-text tags at the bottom of each entry (e.g. `#concurrency #tradeoff
#debugging #open-source`). To find everything on a topic:

```bash
grep -ril "#tradeoff" entries/
```

No index required — grep is the search engine.

If the repo grows large, `INDEX.md` can be hand-updated or generated
with the one-line script in `.github/build_index.sh` when needed.
