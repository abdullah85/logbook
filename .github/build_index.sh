#!/usr/bin/env bash
# Regenerates INDEX.md: a flat, dated list of every entry with its tags.
# Run manually whenever you want an updated index — no CI required.
# Usage: bash .github/build_index.sh > INDEX.md

echo "# Index"
echo
for f in $(find entries -name "*.md" ! -name "_template.md" | sort -r); do
  title=$(head -n 1 "$f" | sed 's/^# //')
  date=$(grep -m1 "^\*\*Date:\*\*" "$f" | sed 's/\*\*Date:\*\* //')
  tags=$(grep -m1 "^Tags:" "$f" | sed 's/^Tags: //')
  echo "- **$date** — [$title]($f) — $tags"
done
