# Form Structure for Access Codes

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-07-27-initiate-understanding-for-access-codes.md) · [Next](./2026-07-29-auth-request-code.md)

Date: 2026-07-19 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commit: [547da27cc](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a) <!-- · PR #__ --> <!-- · Issue #__ -->


## Context
<!-- What problem existed, or what I set out to do. 1–3 sentences. -->
In the [Previous entry](./2026-07-27-initiate-understanding-for-access-codes.md), I explained that on initial load of `/admin`, the generated html is as below.

```html
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
```

The above content is generated as the `email` variable is not set on initial page load.

Observe that there are two forms in the page and each has it's own primary button and is explained next.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

The file [web/admin.html](https://github.com/abdullah85/metallictrends/blob/547da27cc704532fd123d1d66efa7adab8a2bf4a/web/admin.html) contains javascript code.
```javascript
  const requestForm = document.getElementById("request-form");
  const verifyForm = document.getElementById("verify-form");
  const emailInput = document.getElementById("email-input");
  const codeInput = document.getElementById("code-input");
  const message = document.getElementById("auth-message");
  if (!requestForm) return;

  let submittedEmail = "";

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

Observe that `requestForm` fetches data from the `/admin/auth/request-code` endpoint while the `verifyForm` fetches data from the `/admin/auth/verify-code` endpoint leading to a good separation of concerns. This seems like a really good idea as it makes it easy to reason through the logic and debug when needed. The code could be made more DRY as a few aspects seem to be repeated.

## Notes

We have covered the initial page load for [`api/app.py`](https://github.com/abdullah85/metallictrends/commit/547da27cc704532fd123d1d66efa7adab8a2bf4a?diff=unified#diff-1ee3ead7352ab51af64f5c8bf08dd156660272feedff099364f03c34151866ff) as well as the front end behaviour and structure of the page once it is loaded.

We need to evaluate if it makes sense to DRY the code, and reduce the repetitiveness of some statements.

We need to check the endpoints for `requestForm` and `verifyForm` corresponding to generating, verifying access code respectively.

---
· Continues from: [Initiate Understanding for Access Codes]((./2026-07-27-initiate-understanding-for-access-codes.md))

· Continued in: [Authorization Request Coded](./2026-07-29-auth-request-code.md)

Tags: #fastapi #access-code #resend
