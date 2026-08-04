# Authorization Token Usage

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-08-02-auth-token-hmac.md) · [Next](2026-08-04-review-access-codes.md)

Date: 2026-07-19 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commit: [547da27cc](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a) <!-- · PR #__ --> <!-- · Issue #__ -->

## Context
<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [Previous entry](./2026-08-02-auth-token-hmac.md), we observed how the token was generated with the help of the [hmac](https://docs.python.org/3.12/library/hmac.html) library and the cookie was set in response [as a parameter](https://fastapi.tiangolo.com/advanced/response-cookies/#use-a-response-parameter) while the return was a normal dictionary of the form `{"status": "ok"}` indicating succesful response.


We need to evaluate what happens next and how the token is used.

```python
def _verify_session(token: str, secret: str) -> str | None:
    try:
        email, exp_str, sig = base64.urlsafe_b64decode(token.encode()).decode().split("|", 2)
    except Exception:
        return None
    expected_sig = hmac.new(secret.encode(), f"{email}|{exp_str}".encode(), hashlib.sha256).hexdigest()
    if not secrets.compare_digest(sig, expected_sig):
        return None
    if int(exp_str) < int(time.time()):
        return None
    return email
```

For now, the only usage is in the code above invoked in `_current_admin_email` when generating the `/admin` endpoint.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->
Essentially, the `email, exp_str, sig` is extracted from the token, with `base64.urlsafe_b64decode`, and then:

```python
    expected_sig = hmac.new(secret.encode(), f"{email}|{exp_str}".encode(), hashlib.sha256).hexdigest()
    if not secrets.compare_digest(sig, expected_sig):
        return None
```

The `expected_sig` is computed and compared with `sig` from the token to ensure that it is not tampered with.


## Notes

Given [`api/app.py`](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a?diff=unified#diff-1ee3ead7352ab51af64f5c8bf08dd156660272feedff099364f03c34151866ff), we have now reviewed various aspects pertaining to authorization with acess codes.

We saw the steps to generate the frontend, generate the access code and verify it which are closely interrelated.

The above details were described at a high level and there are aspects that I hope to explore in depth later.

---
· Continues from: [Auth Token HMAC](./2026-08-02-auth-token-hmac.md)

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #fastapi #token #hmac
