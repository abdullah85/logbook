#!/usr/bin/env bash
# Regenerates INDEX.md: a flat, dated list of every entry with its tags.
# Run manually whenever you want an updated index — no CI required.
# Usage: bash .github/build_index.sh > INDEX.md

echo "# Index"
echo
echo "_Listed by write order; dates shown are work dates, so they may not be in strict order._"
echo
for f in $(find entries -name "*.md" ! -name "_template.md" | sort -r); do
  title=$(head -n 1 "$f" | sed 's/^# //')
  # Sorted by filename (write date); printed date is the body's work date — thus order may not match.
  date=$(grep -m1 "^Date:" "$f" | sed -E 's/^Date: ([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/')
  # date=$(grep -m1 "^\*\*Date:\*\*" "$f" | sed 's/\*\*Date:\*\* //')
  tags=$(grep -m1 "^Tags:" "$f" | sed 's/^Tags: //')
  echo "- **$date** — [$title]($f) — $tags"
done
