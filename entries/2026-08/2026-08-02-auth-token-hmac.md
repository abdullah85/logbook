# Authorization Token HMAC

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-08-01-auth-verify-code.md) · [Next](./2026-08-03-auth-token-usage.md)

Date: 2026-07-19 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commit: [547da27cc](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a) <!-- · PR #__ --> <!-- · Issue #__ -->


## Context
<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [Previous entry](./2026-08-01-auth-request-code.md), we reviewed the process for verifying an access code for an email provided by the user. With that, the email id provided by the user has been successfully verified at the backend. In this entry, we discuss the `token` generated that ensures that a private session can be maintained between the client and server.

```python
@app.post("/admin/auth/verify-code")
def admin_verify_code(body: _VerifyCodeBody, response: Response):
    secret = os.environ.get("ADMIN_SESSION_SECRET")
    if not secret:
        raise HTTPException(501, "Admin auth is not configured on this server.")

    ...

    with _connect() as conn:
        ...
        mark_login_code_used(conn, row_id, now)

    token = _sign_session(email, secret, _SESSION_TTL_SECONDS)
    response.set_cookie(
        _SESSION_COOKIE, token, max_age=_SESSION_TTL_SECONDS,
        httponly=True, samesite="strict",
    )
    return {"status": "ok"}
```
The `token` is valid for `_SESSION_TTL_SECONDS`, currently fifteen minutes, and the process is discussed below.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

Let's review the code for the `/admin/auth/request-code` endpoint listed below.


```python
def _sign_session(email: str, secret: str, ttl_seconds: int) -> str:
    """A stateless, tamper-evident session token: email + expiry + an HMAC
    signature over both, base64-encoded. No server-side session store needed —
    verifying is just re-computing the signature and comparing."""
    exp = int(time.time()) + ttl_seconds
    payload = f"{email}|{exp}"
    sig = hmac.new(secret.encode(), payload.encode(), hashlib.sha256).hexdigest()
    return base64.urlsafe_b64encode(f"{payload}|{sig}".encode()).decode()
```

The [hmac](https://docs.python.org/3.12/library/hmac.html) library is used for generating the signature.

## Notes

Given [`api/app.py`](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a?diff=unified#diff-1ee3ead7352ab51af64f5c8bf08dd156660272feedff099364f03c34151866ff), we earlier reviewed the frontend generation, generating an access code and verifying the access code.

In this entry, we reviewed how the session is maintained between the client and server with the help of a token.

We need to further review the [hmac](https://docs.python.org/3.12/library/hmac.html) library to understand the process better and subsequent interactions.

---
· Continues from: [Auth Verify Code](./2026-08-01-auth-verify-code.md)

· Continued in: [Auth Token Usage](./2026-08-03-auth-token-usage.md)

Tags: #fastapi #token #hmac
