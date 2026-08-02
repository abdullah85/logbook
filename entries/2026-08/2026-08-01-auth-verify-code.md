# Authorization Verify Code

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-07-29-auth-request-code.md) · [Next](./2026-08-02-auth-token-hmac.md)

Date: 2026-07-19 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commit: [547da27cc](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a) <!-- · PR #__ --> <!-- · Issue #__ -->


## Context
<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [Previous entry](./2026-07-29-auth-request-code.md), we discussed the process for generating an access code when a user provides an email id. In this entry, we will discuss the process that is followed to verify the generated access code. As in the previous entry let's first review the Javascript code snippet for the frontend below.

```javascript
  verifyForm.addEventListener("submit", async (event) => {
    event.preventDefault();
    message.textContent = "Verifying…";
    try {
      const res = await fetch("/admin/auth/verify-code", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: submittedEmail, code: codeInput.value.trim() }),
      });
      const data = await res.json().catch(() => ({}));
      if (!res.ok) {
        message.textContent = data.detail || "Invalid code.";
        return;
      }
      window.location.reload();
    } catch (err) {
      message.textContent = "Network error — try again.";
    }
  });
})();

```

The logic for verifying the access code is in [`src/metallictrends/api/app.py`](https://github.com/abdullah85/metallictrends/blob/547da27cc704532fd123d1d66efa7adab8a2bf4a/src/metallictrends/api/app.py) and let's understand each step.


## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

Let's review the code for the `/admin/auth/verify-code` endpoint listed below.


```python
@app.post("/admin/auth/verify-code")
def admin_verify_code(body: _VerifyCodeBody, response: Response):
    secret = os.environ.get("ADMIN_SESSION_SECRET")
    if not secret:
        raise HTTPException(501, "Admin auth is not configured on this server.")

    email = body.email.strip().lower()
    code = body.code.strip()
    now = datetime.now(timezone.utc).isoformat()

    with _connect() as conn:
        row = get_active_login_code(conn, email, now)
        if row is None:
            raise HTTPException(401, "Invalid or expired code.")
        row_id, _email, code_hash, _created_at, _expires_at, _used_at, attempts, _ip = row
        if attempts >= _MAX_CODE_ATTEMPTS:
            mark_login_code_used(conn, row_id, now)
            raise HTTPException(401, "Too many incorrect attempts. Request a new code.")

        submitted_hash = hashlib.sha256(code.encode()).hexdigest()
        if not secrets.compare_digest(submitted_hash, code_hash):
            if increment_login_code_attempts(conn, row_id) >= _MAX_CODE_ATTEMPTS:
                mark_login_code_used(conn, row_id, now)
            raise HTTPException(401, "Invalid or expired code.")

        mark_login_code_used(conn, row_id, now)

    token = _sign_session(email, secret, _SESSION_TTL_SECONDS)
    response.set_cookie(
        _SESSION_COOKIE, token, max_age=_SESSION_TTL_SECONDS,
        httponly=True, samesite="strict",
    )
    return {"status": "ok"}
```

The process for verification involves:
* The `get_active_login_code` fetches the last code hash generated for the `email` provided
* The number of attempts made is checked as `increment_login_code_attempts` tracks unsuccesful attempts.
* The `submitted_hash` is computed from the code provided by the user as the code is never saved in db.
* The `secrets.compare_digest` helps compare the hashes in a secure manner mitigating timing attacks.
* Once, the code is checked successfully, the `mark_login_code_used` ensures that the code is marked used.

Note that in the generation phase, we did not save the code in the db and only saved the hashed code.

The hash is computed based on user input dynamically and hence it avoids having to store the access code.

## Notes

First, We covered the initial page load for [`api/app.py`](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a?diff=unified#diff-1ee3ead7352ab51af64f5c8bf08dd156660272feedff099364f03c34151866ff), and the generated page enables code generation as well as verification.

In the previous entry, we reviewed the steps involved for generating an access code.

In this entry, we listed the steps involved for verifying the access code generated above.

---
· Continues from: [Auth Request Code](./2026-07-29-auth-request-code.md)

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #fastapi #access-code #verify-code
