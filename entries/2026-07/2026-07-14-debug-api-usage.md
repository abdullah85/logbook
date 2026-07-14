# Debug API Usage
<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-07-12-fetch-latest-price.md)  <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-07-13 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commit: [3bbbc575](https://github.com/abdullah85/metallictrends/commit/3bbbc5755a70d583c09bcfb043e0e34513c254b1
)

## Context

In the [previous](./2026-07-12-fetch-latest-price.md) entry, I integrated dynamic fetching when a user visits the site.

There was an issue and despite using TDD, the usage was high and unaccounted for.

<img width="573" height="175" alt="The latest usage is at 61 of 100 requests" src="https://github.com/user-attachments/assets/06be530a-c6d3-477e-b59a-deb1f82ff932" />

The image above presents the current usage, many calls (about 20) after integrating dynamic fetching were not useful.

## Decision
For now, I chose to update `needs_backfill` to check if there is a gap of at least a day as below:

<img width="2403" height="697" alt="image" src="https://github.com/user-attachments/assets/3aad3386-9d82-4455-8983-beb55412f01d" />

The above is called within `maybe_backfill` and returns when the condition is not satisfied.
```python
def maybe_backfill(conn: sqlite3.Connection, now: datetime | None = None) -> None:
     """Homepage entry point: backfills recent data when the DB has fallen behind.
    ...
    by up to 30 days each time."""
    now = now or datetime.now(timezone.utc)
    today = now.date()
    if not needs_backfill(conn, today):
        return
```

The `mabe_backfill` function is used for fetching the actual landing page.

```python

@app.get("/", response_class=HTMLResponse)
def index(request: Request):
    """Renders the landing page itself, injecting `_latest_meta`'s values server-side.
    ...
    rendering so the page never serves data staler than it needs to."""
    with _connect() as conn:
        maybe_backfill(conn)
        context = _latest_meta(conn)
    return templates.TemplateResponse(request, "index.html", context)

```

As you can see above, we serve a template for the landing page and I hope to go over it in another entry.

Essentially, we use server side rendering for a few data points while maintaining clarity for the index page.

## Result

The usage of the API is much more restricted and the wasted calls must be minimal now.

A call is wasted if it does not record at least one new price entry to the database.

We cannot avoid wastage completely (due to real world constraints) and we need to monitor it.

---
· Continues from: [Fetch latest Price](./2026-07-12-fetch-latest-price.md) <!--  link to the earlier entry this continues, if any -->

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #api #metals.dev #fastapi
