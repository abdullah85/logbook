# Explore API Usage due to Render Deployment
<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-07-14-debug-api-usage.md) · [Next](./2026-07-18-github-api-usage-via-render.md)

Date: 2026-07-15 · Repo: [metallictrends](https://github.com/abdullah85/metallictrends) · Commits: [d3fbea149](https://github.com/abdullah85/metallictrends/commit/d3fbea149f928582323de6e02a8ef8ac781f9337), [be946db3](https://github.com/abdullah85/metallictrends/commit/be946db3890a39ddca3a3c4c9fdc858bfc229a7a)

## Context
In the [previous](./2026-07-14-debug-api-usage.md) entry, I had mentioned the changes deployed to restrict daily usage.

Yesterday, the usage was recorded at 61 and now it is 72, for a total of 11 requests within 24 hours.

<img width="573" height="175" alt="Usage is 72 out of available 100 within 24 hours" src="https://github.com/user-attachments/assets/cb6c8dd4-3c95-4fbc-9b07-65d539459a49" />

This does not make sense as we would expect at most three requests, that too if all failed.

The possible explanation I can come up with is due to the Render deployment on the free tier.

<img width="1522" height="817" alt="image" src="https://github.com/user-attachments/assets/db46bacc-4abd-4e50-99c6-216dbb4ba763" />

For the deployment, I have used a private Github repo with the `metals.db` data commited to the `deploy` branch.

On the private repo, I manually rebase the `deploy` onto the `main` branch for deployment with updated code and data.

I think the `metals.db` data on `deploy` branch is getting reset and fetches each time it restarts.

## Decision

I decided to automatically commit the entries from LIVE db to the Github Repo and log fetches for debugging.

```python
def push_db_to_github() -> None:
    """Commits the local DB file to GitHub. Deliberately has NO "[skip render]"
    phrase -- the resulting normal auto-deploy is what bakes the updated file
    into the image Render restarts from next."""
    if not os.path.exists(DB_PATH):
        return

    with open(DB_PATH, "rb") as f:
        content_b64 = base64.b64encode(f.read()).decode()

    get_resp = requests.get(API_URL, headers=HEADERS, params={"ref": GITHUB_BRANCH}, timeout=15)
    sha = get_resp.json().get("sha") if get_resp.status_code == 200 else None

    payload = {
        "message": "Update metals.db with latest fetched entries",
        "content": content_b64,
        "branch": GITHUB_BRANCH,
    }
    if sha:
        payload["sha"] = sha

    put_resp = requests.put(API_URL, headers=HEADERS, json=payload, timeout=30)
    if put_resp.status_code in (200, 201):
        logger.info("Pushed metals.db to GitHub — Render will redeploy with this commit.")
    else:
        logger.error("Failed to push DB to GitHub: %s %s", put_resp.status_code, put_resp.text)
```

The environment variables `GITHUB_TOKEN` and `GITHUB_REPO` must be added in Render for the above to work.

I also considered [Turso](https://turso.tech/) but dropped it as it would required modifications to the existing implementation.

## Result
The commits [d3fbea149](https://github.com/abdullah85/metallictrends/commit/d3fbea149f928582323de6e02a8ef8ac781f9337) and [be946db3](https://github.com/abdullah85/metallictrends/commit/be946db3890a39ddca3a3c4c9fdc858bfc229a7a) were pushed to the to the `main` branch of the private Github Repo. Then, we rebased the `deploy` branch on to the `main` branch to ensure the code gets updated. This is then deployed to Render automatically when the `deploy` branch is pushed to Github.

### Automatic Deployment without Token Set

I had not saved the `GITHUB_TOKEN` or the `GITHUB_REPO` variables and this generated the error below.

<img width="2472" height="1285" alt="image" src="https://github.com/user-attachments/assets/350634c6-d24a-4da5-9278-c8a52127b779" />

### Usual API error once configured

Once the variables were updated, we came across an API error, likely due to unavailable data for the day.

<img width="2470" height="1470" alt="image" src="https://github.com/user-attachments/assets/2cb2e344-21d2-43dd-9b3e-098e5e9d609d" />

### API usage restricted by Skipping Backfill

The screenshot below indicates that `maybe_backfill` ensures that only one attempt is made per day.

<img width="2470" height="1470" alt="image" src="https://github.com/user-attachments/assets/58c8aa70-d6d3-468e-8595-71276487f925" />

### Checkpoint New Entries to DB on Github

New entries are getting saved to Github relatively correctly.

<img width="2906" height="1244" alt="image" src="https://github.com/user-attachments/assets/8a9b78a5-3feb-4bf0-936f-9e20b9669278" />

In the above screenshot, there are two entries instead of just one per day which can be tolerated.

### Summary 

Now, that we have the changes deployed, we will need to evaluate how this behaves moving forward.

<img width="573" height="175" alt="image" src="https://github.com/user-attachments/assets/7c209e4d-8cb9-47f4-8e37-7a0999e0f36a" />

We have used 2 requests as we started out with usage at `72 / 100` and we need to monitor this further.

---
· Continues from: [Debug API Usage](./2026-07-14-debug-api-usage.md)

· Continued in: <!-- filled in later, once a follow-up entry exists -->

Tags: #api #fastapi #metals.dev #render #github-api
