# Insiduous Issue causing Quota Usage on Render

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-07-23-migrations-for-backfill-on-render.md) · [Next](./2026-07-25-from-gmail-to-resend-for-access-codes.md) -->

Date: 2026-07-21 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commit: [dfb98fd7f](https://github.com/abdullah85/metallictrends/commit/dfb98fd7f00bad236b56050177428f03ad07aeaf)
<!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context
<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [previous](./2026-07-23-migrations-for-backfill-on-render.md) entry, we first applied previous migrations if present and generated new ones on fetching the site.

The site is rendered on the Server Side and previous migrations and new ones generated where needed.

This gave good visibility into the changes made but the quota usage was not within expected limits.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

The main issue for the quota usage is the  code snippet displayed below.
```python
def generate_backfill_migration_sql(conn: sqlite3.Connection, since: str) -> str | None
    ...
    windows = conn.execute(
        """SELECT start_date, end_date, fetched_at FROM backfill_windows
           WHERE status = 'fetched' AND fetched_at >= ? ORDER BY start_date""",
        (since,),
    ).fetchall()
    if not windows:
        return None
```
The issue is that the migration is generated only for records that are succesfully fetched.

For an entry that is attemtpted and fails, the entry is not logged back to Github as seen below.

```python
@app.get("/", response_class=HTMLResponse)
def index(request: Request):
    ...
    with _connect() as conn:
        apply_pending_migrations(conn)
        since = datetime.now(timezone.utc)
        backfilled = maybe_backfill(conn)
        if backfilled:
            migration_sql = generate_backfill_migration_sql(conn, since.isoformat())
            if migration_sql:
                filename = f"{since:%Y%m%d_%H%M%S}_backfill.sql"
                commit_migration_file(conn, filename, migration_sql)
        context = _latest_meta(conn)
    return templates.TemplateResponse(request, "index.html", context)
```

When a request fails to fetch any record, a single request is used up for the request.

This request does not generate a migration as `backfilled` would be `None` and migration is skipped.

Since migration is not committed, when Render restarts, that request is attempted again and quota is consumed.

## Decision
<!-- What I chose to do — and what I considered but didn't do, and why. -->

The updated commit [dfb98fd7f](https://github.com/abdullah85/metallictrends/commit/dfb98fd7f00bad236b56050177428f03ad07aeaf) ensures that failed attempts generate migrations as well.
```python
    windows = conn.execute(
        """SELECT start_date, end_date, status, fetched_at FROM backfill_windows
           WHERE fetched_at >= ? ORDER BY start_date""",
        (since,),
    ).fetchall()
    attempts = conn.execute(
        """SELECT attempt_date, attempted_at, status, error_detail
           FROM backfill_attempts WHERE attempted_at >= ? ORDER BY attempted_at""",
        (since,),
    ).fetchall()
    if not windows and not attempts:
        return None
```

The above change adds another array for `attempts` to be on the safe side for additional checks.

## Result
<!-- What happened for the decision chosen? Include what didn't work if relevant. For pure learning entries, we may need to skip a few sections above. -->

After implementing the above change and deploying it, the generated file `20260721_060034_backfill.sql` is as follows:
```sql
INSERT INTO backfill_windows (start_date, end_date, status, fetched_at)
     VALUES ('2026-07-19', '2026-07-20', 'failed', '2026-07-21T06:00:35.226904+00:00')
     ON CONFLICT(start_date, end_date) DO UPDATE SET status = excluded.status, fetched_at = excluded.fetched_at;

INSERT INTO backfill_attempts (attempt_date, attempted_at, status, error_detail)
      VALUES ('2026-07-21', '2026-07-21T06:00:34.944797+00:00', 'failed',
           '400 Client Error: Bad Request for url: https://api.metals.dev/v1/timeseries?api_key=<METALS_API_KEY>&start_date=2026-07-19&end_date=2026-07-20');
```

In the second line the `METALS_API_KEY` is actually rendered in the log and needs to be redacted.

I have redacted it manually and postponed modifying the implementation as the repository is currently private anyways.

The implementation is not ideal with respect to redaction and needs to be updated ideally.

## Notes
<!-- Anything you'd want reloaded fast: a gotcha, a number, a name of a library, a link. -->
**Lesson Learned:** For Quota Usage, one needs to carefully  consider tracking failed attempts.

---
· Continues from: [Migrations for Backfill](./2026-07-23-migrations-for-backfill-on-render.md)

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #fastapi #metals.dev #api
