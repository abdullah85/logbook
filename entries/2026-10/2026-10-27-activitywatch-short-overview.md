# ActivityWatch: A short overview
<!-- — describing the event, concepts learnt or progress made. -->
[Previous](/entries/2026-10/2026-10-10-binary-smallest-pair.md)  <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-10-27 · Repo: [activitywatch](https://github.com/ActivityWatch/activitywatch) <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context
What problem existed, or what I set out to do. 1–3 sentences.

As developers, we often learn a number of concepts everyday without realizing what we learnt or we do not have the time to review the tools we use to solve the problem. For this, I have come up with the [Le Laissez Log](https://github.com/abdullah85/le-laissez-log) repository with the objective of reviewing the data on a daily basis, in the background. The first step involves collecting data from the terminal and I found the [activitywatch](https://github.com/ActivityWatch/activitywatch) repo to be a good candidate for this step.

## Concepts

The [activitywatch](https://github.com/ActivityWatch/activitywatch) contains a server `aw-server` as well as a few [clients](https://docs.activitywatch.net/en/latest/watchers.html) such as `aw-watcher-afk` and `aw-watcher-window` as well. However, the clients do not provide required data to the server. The data I would require for a start is the details of what the user types into the terminal and the response as well as interaction on the terminal to form a 

## Decision

I went ahead and implemented by own client [aw_watcher_terminal](https://github.com/abdullah85/le-laissez-log/blob/5cb36a1f077f4fa164feb8a31134a199aebc14c3/aw_watcher_terminal.py) for capturing the required data. I used Claude heavily and dependend on it to create the script. The script seems to work as the events record activity on the terminal and a lot more work to do yet. 

---
· Continues from: <!--  link to the earlier entry this continues, if any -->

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #activitywatch #le-laissez-log #log
