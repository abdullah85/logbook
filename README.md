# Logbook

A concise record of events, insights and observations obtained in my technical journey,  drawing inspiration from the original meaning of the word logbook that was also known as the ship's log or simply log, a maritime record of important events in the management, operation, and navigation of a ship.

<img width="1280" height="960" alt="Grand_Turk" src="https://github.com/user-attachments/assets/d38bd7db-e89b-4b92-8093-ed1cb0eb2fa3" />

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

- One folder per month (`entries/YYYY-MM/`) keeps any single directory from becoming too long.
- One file per entry, named `YYYY-MM-DD-short-slug.md` and the date prefixes help sort entries correctly.
- Maintenance is low as we just need to create the markdown files, commit and push.

## Workflow

1. Finish something worth remembering like a merged PR, a resolved issue or a design decision.
2. Copy `entries/_template.md`, rename it, fill it in within 5–10 minutes, on the same day if possible.
3. Commit and push to Github which takes care of the presentation.

## Tags and Threading entries

Free-text tags at the bottom of each entry (e.g. `#concurrency #tradeoff
#debugging #open-source`). To find everything on a topic:

```bash
grep -ril "#tradeoff" entries/
```

The `INDEX.md` can be hand-updated or generated with the script in `.github/build_index.sh` when needed.

The `Continues From` / `Continued In` fields above the tags may be used to link across entries appropriately. 

Thus, we can relate different entries while maintaining a near accurate record of events similar to the original ship's log.
