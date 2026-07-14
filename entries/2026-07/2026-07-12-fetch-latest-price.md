# Fetch the Latest Price automatically

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-07-04-pydantic-dataclasses-models.md)  <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-07-11 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) <!-- · PR #__ --> <!-- · Issue #__ --> · Commit: [dbd9efb3](https://github.com/abdullah85/metallictrends/commit/dbd9efb3cf45be820e016cc667dab13d9ad73d3f)

## Context
We need to fetch the latest price from [metals.dev](https://metals.dev/) site dynamically.

Earlier, we had a command line tool `run.py` to fetch the data and load the database manually each time.

The main issue is that when a user loads the page, he receives stale data which reflects the data that was loaded to the site via the commandline earlier. There is scope for further improving the ingestion process and for now we would like to focus on the user experience. That is, when the user visits the site, we should retrieve the price dynamically and present it.

## Decision

I decided to update the endpoint for getting the index in a synchronous manner.

The function `maybe_backfill` is implemented in `run.py` with the signature below:

```python
def maybe_backfill(conn: sqlite3.Connection, now: datetime | None = None) -> None:
```

The above function is then invoked in `api.py` in a synchronous manner to achieve the desired result.

## Result

Let's review the current behaviour from the user's perspective as well as the API usage behind the scenes.

The current usage is as below:

<img width="573" height="175" alt="image" src="https://github.com/user-attachments/assets/d4ae5a6f-0812-4a34-b4de-041b2c0ab7b8" />

The site is currently hosted on Render under the free plan and it needs to restart each time:

<img width="3045" height="1634" alt="image" src="https://github.com/user-attachments/assets/db46bacc-4abd-4e50-99c6-216dbb4ba763" />

The site loads with slightly stale data of about a day as shown below :

<img width="3045" height="1634" alt="image" src="https://github.com/user-attachments/assets/280c2d27-fd91-407b-9406-3ab0d248758e" />

I checked the log in Render and there seems to have been an issue:
<img width="1895" height="474" alt="image" src="https://github.com/user-attachments/assets/1e73aac3-d9da-457d-ac99-bcc1ae4dd0d0" />

The usage has increased by one for the above call as seen below:

<img width="573" height="175" alt="image" src="https://github.com/user-attachments/assets/b5b3acd0-de14-4cf4-9dea-132fd2a32085" />

There seems to be some issue when fetching after a gap of one day and needs to be looked into further.

---
· Continues from: <!--  link to the earlier entry this continues, if any -->

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #ssr #api #metals.dev
