# Recap Access Codes Flow Logic

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-07-25-from-gmail-to-resend-for-access-codes.md) · [Next](./2026-07-28-form-structure-for-access-codes.md)

Date: 2026-07-19 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commit: [547da27cc](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a) <!-- · PR #__ --> <!-- · Issue #__ -->


## Context
<!-- What problem existed, or what I set out to do. 1–3 sentences. -->
In [547da27cc](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a), I added functionality for allowing user to login via an access coded on providing email id to ensure that the relatively sensitive information pertaining to ingestion history, data obtained from API is restricted to some extent.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

The `/admin` endpoint renders a `Jinja2` template file and presents the user with options to generate, verify access code.


## Notes

The file [`api/app.py`](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a?diff=unified#diff-1ee3ead7352ab51af64f5c8bf08dd156660272feedff099364f03c34151866ff) contains the complete logic related to access code and I hope to unravel each step in the coming entries.

---
· Continues from: [From Gmail to Resend](./2026-07-25-from-gmail-to-resend-for-access-codes.md)

· Continued in: [Form Structure for Access Codes](./2026-07-28-form-structure-for-access-codes.md)

Tags: #fastapi #access-code #resend
