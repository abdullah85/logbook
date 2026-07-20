# SSR via FastAPI for the Landing Page

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-07-18-github-api-usage-via-render.md)  <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-07-18 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commits: [b4a2b2dd0](https://github.com/abdullah85/metallictrends/commit/b4a2b2dd00b4269ec512ae019d2949bfdb03874e)

## Context
<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

The code for the landing page at `web/index.html` in  [bcaaf3b0cf](https://github.com/abdullah85/metallictrends/blob/bcaaf3b0cfe08c6fff33bb305324a80f1f5471a7/web/index.html) combined styling, javascript and had hardcoded values for the gold price, date, number of days fetched and other data points. There was a dire need to separate the styles, logic from the html layout. In addition, the data had to be fetched dynamically from the backend instead of harcoding values.

## Decision
<!-- What I chose to do — and what I considered but didn't do, and why. -->

The first step was to refactor the styles, javascript  into their respective files and include them in the main `index.html` file.

I decided to use `Jinja2` with minimal modifications to the html portion of `index.html` and `fastapi` to render the landing page.

This would lead to better maintenance as it would be easier to improve the landing page due to better separation of concerns.

## Result
<!-- What happened for the decision chosen? -->

The html layout was converted to a Jinja template in [b4a2b2dd00](https://github.com/abdullah85/metallictrends/blob/b4a2b2dd00b4269ec512ae019d2949bfdb03874e/web/index.html), rendered by [fastapi when fetching the root](https://github.com/abdullah85/metallictrends/blob/b4a2b2dd00b4269ec512ae019d2949bfdb03874e/api.py#L113) endpoint.

The hero section presented below contains expression delimiters for integrating the dynamic data values.

```html
  <section class="hero">
    <div class="wrap">
      <div class="ingot">
        <div class="ingot-figure">
          <!-- Rendered server-side by the "/" route in api.py (see _latest_meta), computed
               from the DB at request time — never a placeholder, never touched by JS. -->
          <div class="ingot-number">{{ ingot_number }}</div>
          <div class="ingot-sub">XAU · USD/OZ · .9999 FINE</div>
        </div>
        <div class="ingot-copy">
          <div class="eyebrow">On {{ batch_date }} — refined daily</div>
          <h1>Track The Trend</h1>
        </div>
      </div>
      <div class="hero-main">
        <div class="hero-left">
          <p class="lede">MetallicTrends turns years of daily gold, silver, platinum, and palladium data to user-friendly, interactive charts. Explore the performance of your assets. No account needed to get started.</p>
          <div class="ctas">
            <a class="btn btn-primary" href="#stats">Explore</a>
            <a class="btn btn-ghost" href="#b2b">Own a jewellery store? → Get the widget</a>
          </div>
        </div>
        <div class="hero-preview">
          <img class="hero-preview-img" src="assets/hero-preview.png" alt="Preview of the MetallicTrends interactive gold price chart">
          <div class="hero-preview-overlay" aria-hidden="true"><span class="hero-preview-play">▶</span></div>
          <div class="hero-preview-caption">Product walkthrough video — coming soon</div>
        </div>
      </div>
      <div class="trust-strip">
        <span>{{ days_count }} days of daily data</span><span class="sep">·</span>
        <span>4 metals tracked</span><span class="sep">·</span>
        <span>consolidated from <a href="https://metals.dev/docs" target="_blank">metals.dev</a></span>
	<span class="sep">·</span>
        <span>last update {{ last_update }}</span>
      </div>
    </div>
  </section>
```

The server side rendering happens in the `_latest_meta` function in `fastapi` as illustrated below.

```python

def _latest_meta(conn: sqlite3.Connection) -> dict:
    """Server-rendered context for index.html's hero ingot and trust-strip. Computed
    from the DB at request time so the page never carries a placeholder value that
    could be mistaken for real data — there's no "default" because there's no gap for
    one to fill. Gold is the reference metal since every metal is ingested in the same
    daily run and shares an identical date range (see run.py's backfill orchestrator)."""
    snapshot = _snapshot(conn, "gold")
    count_row = conn.execute("SELECT COUNT(*) AS n FROM metal_prices WHERE metal = 'gold'").fetchone()
    latest_date = date.fromisoformat(snapshot["date"])
    return {
        "ingot_number": f"{snapshot['price_usd']:.1f}",
        "batch_date": snapshot["date"],
        "last_update": f"{latest_date.strftime('%b')} {latest_date.day}, {latest_date.year}",
        "days_count": f"{count_row['n']:,}",
    }
```

Thus, the html is presented in a clear manner which allows for further improvement to the landing page when needed.

---
· Continues from: <!--  link to the earlier entry this continues, if any -->

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #ssr #fastapi #clean-code
