# logbook

<img width="1280" height="960" alt="Grand_Turk" src="https://github.com/user-attachments/assets/d38bd7db-e89b-4b92-8093-ed1cb0eb2fa3" />

The objective of this repository is to record the progress I make regularly while exploring various tools, approaches and systems in my technical journey,  drawing inspiration from the original meaning of the term logbook that originated with the ship's log, a maritime record of important events in the management, operation, and navigation of a ship.

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

- One folder per month (`entries/YYYY-MM/`) keeps any single directory from becoming too long and difficult to browse.
- One file per entry, named `YYYY-MM-DD-short-slug.md` and the date prefixes help sort entries correctly.
- Maintenance is low as we just need to create the markdown files, commit and push.

## Workflow

1. Finish something worth remembering like a merged PR, a resolved issue, a design decision.
2. Copy `entries/_template.md`, rename it, fill it in. 5–10 minutes, same day if possible.
3. Commit and push. That's it. There is no build step to generate a site and maintain it.

## Tags

Free-text tags at the bottom of each entry (e.g. `#concurrency #tradeoff
#debugging #open-source`). To find everything on a topic:

```bash
grep -ril "#tradeoff" entries/
```

The `INDEX.md` can be hand-updated or generated with the script in `.github/build_index.sh` when needed.
