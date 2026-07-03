# Switched retry logic from fixed delay to exponential backoff

**Date:** 2026-07-02
**Repo/Project:** [api-client](https://github.com/username/api-client)
**Related:** PR #42

## Context
The client was hammering a flaky upstream API with fixed 1s retries, which
made a partial outage upstream turn into a full outage on our side once
enough clients retried in lockstep.

## Decision
Switched to exponential backoff with jitter (base 200ms, cap 5s) instead of
a fixed delay. Considered a circuit breaker instead, but decided it was
overkill for a client library used by ~3 internal services — backoff alone
solved the thundering-herd problem without adding a new failure mode
(a breaker that trips wrong and blocks all traffic).

## Result
Verified locally by simulating upstream 503s. Retry storm behavior visibly
smoothed out in a load test. Circuit breaker is still worth revisiting if
we add more consumers of this client.

## Notes to future me
Jitter matters more than the backoff curve shape — without it, synchronized
clients still retry in waves. Library used: nothing external, ~15 lines by
hand, no need for a dependency here.

---
Tags: #resilience #tradeoff #api #backoff
