# From Gmail to Resend for Access Codes

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-07-22-migrations-for-backfill-on-render.md) · [Next](./2026-07-27-initiate-understanding-for-access-codes.md)

Date: 2026-07-19 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commit: [547da27cc](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a), [445d12d5d](https://github.com/abdullah85/metallictrends/commit/445d12d5dadda24344f14a21721db4a04be58000), [52bdd3813](https://github.com/abdullah85/metallictrends/commit/52bdd381310139967c15728c8ca2861584396036) <!-- · PR #__ --> <!-- · Issue #__ -->

## Context
<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

The initial attempt of sending a code was via GMAIL and the content of `.env.example` is below.
```python
# Email-based one-time-code login for /admin (set in Render's dashboard for production)
# GMAIL_ADDRESS/GMAIL_APP_PASSWORD: a dedicated service Gmail account (not a personal one)
# used to send login codes. ADMIN_SESSION_SECRET: any long random string, used to sign
# session cookies — e.g. `python -c "import secrets; print(secrets.token_hex(32))"`.
GMAIL_ADDRESS=your_service_account@gmail.com
GMAIL_APP_PASSWORD=your_16_char_app_password
ADMIN_SESSION_SECRET=a_long_random_string
```

Render does not allow SMTP connection and hence the above did not work as expected.

Thus, we have to use another service for sending the mail via a HTTP `POST` request.


## Decision
<!-- What I chose to do — and what I considered but didn't do, and why.-->

The core logic for sending the mail with the access code used `smtplib` as shown below.
```python
    with smtplib.SMTP(_SMTP_HOST, _SMTP_PORT) as smtp:
        smtp.starttls()
        smtp.login(gmail_address, gmail_app_password)
        smtp.send_message(msg)
```

For sending mail via `Resend`, it is  a simple Post request.

```python
    try:
        response = requests.post(
            _RESEND_API_URL, json=payload, headers=headers, timeout=_REQUEST_TIMEOUT_SECONDS
        )
    except requests.exceptions.Timeout as exc:
        raise EmailSendTimeoutError(
            f"Resend API request timed out after {_REQUEST_TIMEOUT_SECONDS}s."
        ) from exc
```

The contents of .env.example were modified for `RESEND` functionality.
```
# RESEND_API_KEY: from resend.com — used to send login codes via HTTP (not SMTP;
# Render's network blocks outbound SMTP entirely). ADMIN_SESSION_SECRET: any long
# random string, used to sign session cookies —
# e.g. `python -c "import secrets; print(secrets.token_hex(32))"`.
RESEND_API_KEY=your_resend_api_key
```

## Result
<!-- What happened for the decision chosen? -->
This works from Render and the code is received in the mail provided.

<img width="425" height="365" alt="image" src="https://github.com/user-attachments/assets/5bf16d7d-8a14-4ba8-aa96-b79d594c596c" />


Once the code is entered, then we are able to view the admin section.

<img width="2204" height="884" alt="image" src="https://github.com/user-attachments/assets/b6e38d99-046c-4da2-b910-a370e67faaab" />

 
 We need to implement the admin section next to illustrate the fetch

---
· Continues from: <!--  link to the earlier entry this continues, if any -->

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #smtp #resend #access-code
