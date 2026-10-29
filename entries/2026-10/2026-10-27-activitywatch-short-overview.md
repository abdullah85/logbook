# ActivityWatch: A short overview
<!-- — describing the event, concepts learnt or progress made. -->
[Previous](/entries/2026-10/2026-10-10-binary-smallest-pair.md)  <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-10-27 · Repo: [activitywatch](https://github.com/ActivityWatch/activitywatch) <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

As developers, we often learn a number of concepts everyday without sufficient time to recall, review or record the solutions. For this, I came up with the [Le Laissez Log](https://github.com/abdullah85/le-laissez-log) repository with the objective of logging on a daily basis, in the background. The first step involves collecting data from the terminal and I found the [activitywatch](https://github.com/ActivityWatch/activitywatch) repo to be a good candidate for this step.

## Concepts

The [activitywatch](https://github.com/ActivityWatch/activitywatch) contains a server `aw-server` and a few [clients](https://docs.activitywatch.net/en/latest/watchers.html) such as `aw-watcher-afk` and `aw-watcher-window` for sending data to the server. However, the clients do not seem to be able to capture the required data from the terminal. I need to collect the input, output and interaction of the user in the terminal. 

## Decision

I went ahead and implemented by own client [aw_watcher_terminal](https://github.com/abdullah85/le-laissez-log/blob/5cb36a1f077f4fa164feb8a31134a199aebc14c3/aw_watcher_terminal.py) for capturing the required data. I used Claude heavily and dependend on it to create the script. The script seems to work as the events record activity on the terminal and get recorded as events on the local server.

---
· Continues from: <!--  link to the earlier entry this continues, if any -->

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #activitywatch #le-laissez-log #log
