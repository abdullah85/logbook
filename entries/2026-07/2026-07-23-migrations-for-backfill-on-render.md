# Migrations for Backfill on Render

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-07-20-ssr-via-fastapi-landing-page.md)  <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-07-19 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commit: [392da263e](https://github.com/abdullah85/metallictrends/commit/392da263e17cc7a54f40dedc4c24fc750db0146a)

## Context
The complete db, `metals.db` was being commited to the Github private repository.

This works but it sends the complete db on each commit from the site deployed on Render.

Also, viewing the commit diff does not clarify the minimal changes made.

## Decision
I decided to commit the diff as migrations and on restart, run the commited migrations to db first.

The index was updated to integrate the migrations with `apply_pending_migrations` as shown below:
```python
@app.get("/", response_class=HTMLResponse)
def index(request: Request):
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
When a backfill occurs, the `migration_sql` contains the migrations which are then commited to Github.

The function definition for creating the migration with a few extracted snippets is shown below:

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

    lines = []
    for start_date, end_date, fetched_at in windows:
        for d, metal, price_usd in conn.execute(
            "SELECT date, metal, price_usd FROM metal_prices WHERE date BETWEEN ? AND ? ORDER BY date, metal",
            (start_date, end_date),
        ):
            lines.append(
                f"INSERT OR IGNORE INTO metal_prices (date, metal, price_usd) "
                f"VALUES ({_sql_literal(d)}, {_sql_literal(metal)}, {price_usd});"
            )

        # Similar logic for fx_rates, omitted

        lines.append(
            f"INSERT OR IGNORE INTO backfill_windows (start_date, end_date, status, fetched_at) "
            f"VALUES ({_sql_literal(start_date)}, {_sql_literal(end_date)}, 'fetched', {_sql_literal(fetched_at)});"
        )
    for attempt_date, attempted_at, status, error_detail in conn.execute(
        """SELECT attempt_date, attempted_at, status, error_detail
           FROM backfill_attempts WHERE attempted_at >= ?""",
        (since,),
    ):
        lines.append(
            f"INSERT INTO backfill_attempts (attempt_date, attempted_at, status, error_detail) "
            f"VALUES ({_sql_literal(attempt_date)}, {_sql_literal(attempted_at)}, "
            f"{_sql_literal(status)}, {_sql_literal(error_detail)});"
        )
    return "\n".join(lines) + "\n"
```
The above snippet illustrates the logic for creating the migrations string that is then committed to Github.

## Result

On deploying the changes to Render, we obtained the file with migrations on private Github Repository.

The file contents of `20260719_144439_backfill.sql` is as below:
```sql
INSERT OR IGNORE INTO metal_prices (date, metal, price_usd) VALUES ('2026-07-11', 'gold', 4120.67);
...
INSERT OR IGNORE INTO metal_prices (date, metal, price_usd) VALUES ('2026-07-18', 'gold', 4017.315);
INSERT OR IGNORE INTO metal_prices (date, metal, price_usd) VALUES ('2026-07-18', 'palladium', 1249.534);
INSERT OR IGNORE INTO metal_prices (date, metal, price_usd) VALUES ('2026-07-18', 'platinum', 1589.6);
INSERT OR IGNORE INTO metal_prices (date, metal, price_usd) VALUES ('2026-07-18', 'silver', 55.9);
INSERT OR IGNORE INTO fx_rates (date, currency, rate_to_usd) VALUES ('2026-07-11', 'AUD', 0.695);
INSERT OR IGNORE INTO fx_rates (date, currency, rate_to_usd) VALUES ('2026-07-11', 'BRL', 0.1953);
INSERT OR IGNORE INTO fx_rates (date, currency, rate_to_usd) VALUES ('2026-07-18', 'JPY', 0.006155);
...
INSERT OR IGNORE INTO fx_rates (date, currency, rate_to_usd) VALUES ('2026-07-18', 'SGD', 0.7738);
INSERT OR IGNORE INTO fx_rates (date, currency, rate_to_usd) VALUES ('2026-07-18', 'USD', 1.0);
INSERT OR IGNORE INTO backfill_windows (start_date, end_date, status, fetched_at)
    VALUES ('2026-07-11', '2026-07-18', 'fetched', '2026-07-19T14:44:39.847242+00:00');
INSERT INTO backfill_attempts (attempt_date, attempted_at, status, error_detail)
    VALUES ('2026-07-19', '2026-07-19T14:44:39.457001+00:00', 'success', NULL);
```

Thus, the normal flow works but issues were encountered for the edge cases and hope to describe that later.

---
· Continues from: [Github API Usage](./2026-07-18-github-api-usage-via-render.md)

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #fastapi #metals.dev #github-api #render #migrations
