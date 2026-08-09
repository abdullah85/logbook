# Review Access Code

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-08-03-auth-token-usage.md) · [Next](./2026-08-09-binary-search-python.md)

Date: 2026-07-19 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commit: [547da27cc](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a) <!-- · PR #__ --> <!-- · Issue #__ -->

## Context
<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the past few entries, I have described the process involved in generating the access code and using it.

The file [web/admin.html](https://github.com/abdullah85/metallictrends/blob/547da27cc704532fd123d1d66efa7adab8a2bf4a/web/admin.html)  contains the frontend while [src/metallictrends/api/app.py](https://github.com/abdullah85/metallictrends/blob/547da27cc704532fd123d1d66efa7adab8a2bf4a/src/metallictrends/api/app.py), contains the backend implementation.


I will attempt to recap in simple terms the complete flow for generating, verifying and using the access code here.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

Let's review the steps from the user's perspective, with steps involved annotated below:
+ The user visits `/admin` and is greeted with an appropriate page
  + Checks for the token and if one exists, use the `email` contained within the token to generate the page.
  + If no token exists, then, it presents the user with two field elements each of which is contained within a form.
  + Note that there is a crucial step involved in checking for token validity in the first step.
+ The user enters the email id and hits Send Code
  + The backend performs a few verification steps, generates the code and sends it to the mail id
+ The user checks the mail and enters the code sent via mail
  + The backend will verify by generating the hash and checking for the entry in the db.
+ Subsequent visits to the `/admin` endpoint after generating the code above
  + This will generate the page **after** checking if token is correct or not tampered with.
+ When the user logs out or if the time (within the token as well as the backend) expires,
  + The `_verify_session` function ensures that the token is ignored


## Notes

This is a high level summary that I have written myself (without any AI input) for clarity of thought.

I still need to understand the token as well as other aspects involved in the flow at a more deeper leve.

I hope the current entry provides a simple, clear explanation for reference in the future.

---
· Continues from: 

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #fastapi #token #hmac
