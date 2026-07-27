# Initiate Understanding for Access Codes

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-07-25-from-gmail-to-resend-for-access-codes.md)  <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-07-19 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commit: [547da27cc](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a) <!-- · PR #__ --> <!-- · Issue #__ -->


## Context
<!-- What problem existed, or what I set out to do. 1–3 sentences. -->
In [547da27cc](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a), I introduced access codes for email id provided by the user. This helps me in validating that the user has access to a mail id and allows me timed access to relatively sensitive information involving ingestion history. This will also allow me to further restrict access if the service is misused in future.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->
To understand the changes introduced by [547da27cc](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a), let's understand the `/admin` endpoint implementation in FastAPI.

```python

@app.get("/admin", response_class=HTMLResponse)
def admin_home(request: Request):
    """Always 200s — the page itself decides what to show. With no valid
    session it renders the email/code login form; with one, the (placeholder)
    dashboard. This is deliberately not behind a Depends() that raises, since
    an anonymous visitor is meant to see a real login page, not an error."""
    email = _current_admin_email(request)
    return templates.TemplateResponse(request, "admin.html", {"email": email})
```

This is quite easy to understand as it contains two steps, the first step is to use `_current_admin_email` to get the email.

```python
def _current_admin_email(request: Request) -> str | None:
    """None if there's no valid session — used where the caller wants to
    branch on auth state (e.g. show a login form vs. the dashboard) rather
    than hard-fail."""
    secret = os.environ.get("ADMIN_SESSION_SECRET")
    token = request.cookies.get(_SESSION_COOKIE)
    if not secret or not token:
        return None
    return _verify_session(token, secret)
```

Initially, the token is not set and [`admin.html`](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a?diff=unified#diff-008375f94821d74f2fc456d9433414208e9a6c8ae0c3ea67bc68cabcbefa5834) is rendered via the `else` branch as `email` would be `None` for the initial request.

```html
      {% if email %}
        <h1>Admin Dashboard</h1>
        <p class="lede">Signed in as {{ email }}.</p>
        <p class="lede">Coming soon — backfill attempt history and GitHub sync status, pulled straight from the DB.</p>
        <button id="logout-button" type="button" class="btn btn-ghost" style="margin-top:18px">Log out</button>
      {% else %}
        <h1>Admin Login</h1>
        <p class="lede">Enter your email and we'll send a one-time code to it. Your email address is logged for access tracking.</p>

        <form id="request-form" class="admin-auth-form">
          <input type="email" id="email-input" class="field-input" placeholder="you@example.com" autocomplete="email" required>
          <button type="submit" class="btn btn-primary">Send code</button>
        </form>

        <form id="verify-form" class="admin-auth-form" hidden>
          <input type="text" id="code-input" class="field-input" placeholder="6-digit code" inputmode="numeric" pattern="[0-9]{6}" maxlength="6" autocomplete="one-time-code" required>
          <button type="submit" class="btn btn-primary">Verify</button>
        </form>

        <p id="auth-message" class="admin-auth-message" role="status"></p>
      {% endif %}
```

Thus, user gets two input fields for entering the email and for entering the code as shown above.

## Notes

The file [`api/app.py`](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a?diff=unified#diff-1ee3ead7352ab51af64f5c8bf08dd156660272feedff099364f03c34151866ff) contains the complete logic related to access code and I hope to unravel each step in the coming entries.

---
· Continues from: [From Gmail to Resend](./2026-07-25-from-gmail-to-resend-for-access-codes.md)

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #fastapi #access-code #resend
