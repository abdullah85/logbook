# Authorization Request Code

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-07-28-form-structure-for-access-codes.md) · [Next](../2026-08/2026-08-01-auth-verify-code.md)

Date: 2026-07-19 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commit: [547da27cc](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a) <!-- · PR #__ --> <!-- · Issue #__ -->


## Context
<!-- What problem existed, or what I set out to do. 1–3 sentences. -->
In the [Previous entry](./2026-07-28-form-structure-for-access-codes.md), we identified that the page rendered on visiting the `/admin` endpoint had two embedded forms, one for generating the code and another for verification. In this entry, we will explore the steps that occur for generating the request code. First, recall the `requestForm` logic implemented in Javascript as below.

```javascript
  requestForm.addEventListener("submit", async (event) => {
    event.preventDefault();
    submittedEmail = emailInput.value.trim();
    message.textContent = "Sending code…";
    try {
      const res = await fetch("/admin/auth/request-code", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: submittedEmail }),
      });
      const data = await res.json().catch(() => ({}));
      if (!res.ok) {
        message.textContent = data.detail || "Could not send code.";
        return;
      }
      message.textContent = "Code sent — check your inbox.";
      requestForm.hidden = true;
      verifyForm.hidden = false;
      codeInput.focus();
    } catch (err) {
      message.textContent = "Network error — try again.";
    }
  });
```

The above code snippet is obtained from the file [web/admin.html](https://github.com/abdullah85/metallictrends/blob/547da27cc704532fd123d1d66efa7adab8a2bf4a/web/admin.html) which is used as a `Jinja2` template for generating the page.

The frontend component is quite straightforward as seen in the listing above and we covered it last time as well.

Review the logic for generating the access code in [`src/metallictrends/api/app.py`](https://github.com/abdullah85/metallictrends/blob/547da27cc704532fd123d1d66efa7adab8a2bf4a/src/metallictrends/api/app.py) and let's understand each step.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

Let's review the code for the `/admin/auth/request-code` endpoint listed below.

```python
@app.post("/admin/auth/request-code")
def admin_request_code(body: _RequestCodeBody, request: Request):
    email = body.email.strip().lower()
    if not _EMAIL_RE.match(email):
        raise HTTPException(400, "Enter a valid email address.")

    ip = request.client.host if request.client else None
    now = datetime.now(timezone.utc)
    since = (now - timedelta(hours=1)).isoformat()

    with _connect() as conn:
        if count_recent_login_codes(conn, email=email, since=since) >= _MAX_CODE_REQUESTS_PER_EMAIL_PER_HOUR:
            raise HTTPException(429, "Too many code requests for this email. Try again later.")
        if ip and count_recent_login_codes(conn, ip=ip, since=since) >= _MAX_CODE_REQUESTS_PER_IP_PER_HOUR:
            raise HTTPException(429, "Too many code requests from this network. Try again later.")

        code = f"{secrets.randbelow(1_000_000):06d}"
        code_hash = hashlib.sha256(code.encode()).hexdigest()
        expires_at = (now + timedelta(seconds=_CODE_TTL_SECONDS)).isoformat()
        create_login_code(conn, email, code_hash, now.isoformat(), expires_at, ip)

    send_otp_email(email, code)
    return {"status": "sent"}

```

Let's consider the core logic which revolves around generating the `code` quite succinctly below.

```python
In [1]: import secrets, hashlib; from datetime import date, datetime, timedelta, timezone; _CODE_TTL_SECONDS = 10 * 60;

In [2]: now = datetime.now(timezone.utc)

In [3]: code = f"{secrets.randbelow(1_000_000):06d}"
   ...: code_hash = hashlib.sha256(code.encode()).hexdigest()
   ...: expires_at = (now + timedelta(seconds=_CODE_TTL_SECONDS)).isoformat()

In [4]: code, code_hash, now.isoformat(), expires_at
Out[4]:
('106864',
 'cef88a1ee22759206f68b6f7bb89be7c1b97b159b54627a2df4936ce2dd04011',
 '2026-07-29T14:23:26.977893+00:00',
 '2026-07-29T14:33:26.977893+00:00')
```

The generated details are essentially recorded into the `admin_login_code` table as shown below.

```python

def create_login_code(
    conn: sqlite3.Connection, email: str, code_hash: str, created_at: str,
    expires_at: str, ip: str | None = None,
) -> int:
    """Stores a hashed one-time login code. Also doubles as the access log —
    every request, successful or not, leaves a row here with the requesting
    email and IP."""
    cur = conn.execute(
        """INSERT INTO admin_login_codes (email, code_hash, created_at, expires_at, ip)
           VALUES (?, ?, ?, ?, ?)""",
        (email, code_hash, created_at, expires_at, ip),
    )
    conn.commit()
    return cur.lastrowid
```

I consider the approach adopted to generate the code to be quite neat and the hash is generated for this code.

The need for encoding with `hashlib.sha256` will be explored later and here we just note the generation process.

## Notes

Earlier, we covered the initial page load for `/admin` which displays two forms for generating an access code and then verifying it.

In this entry, we reviewed the steps involved for generating an access code which is quite succinct and robust.

In the next entry, we will evaluate the steps involved for verifying the access code generated above.

---
· Continues from: [Form Structure for Access Codes](./2026-07-28-form-structure-for-access-codes.md)

· Continued in: [Auth Verify Code](../2026-08/2026-08-01-auth-verify-code.md)

Tags: #fastapi #access-code #request-code
