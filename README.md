# Linux_journey
My Linux journey is my blog . i share in it what i learn about linux 



npx decap-server 



Good — that output means **`decap-server` is configured correctly**.

```text
info: Decap CMS File System Proxy Server configured with
/home/youcef/Desktop/My_Linux_Journey/Linux_journey

info: Decap CMS Proxy Server listening on port 8081
```

So Decap is pointing directly at your Hugo project:

```text
/home/youcef/Desktop/My_Linux_Journey/Linux_journey
```

The `@hapi/joi` message is only a **deprecated dependency warning**. It is not the cause of your problem.

### Now check your `config.yml`

Run:

```bash
cat static/admin/config.yml
```

You should have something like:

```yaml
local_backend: true

backend:
  name: git-gateway
  branch: main
```

Then:

**Terminal 1:**

```bash
hugo server -D
```

**Terminal 2:**

```bash
npx decap-server
```

**Browser:**

```text
http://localhost:1313/admin/
```

### Important test

Before modifying anything, run:

```bash
git status
```

Then edit **one existing post** through Decap CMS and click **Save**.

Afterwards run:

```bash
git status
```

and:

```bash
git diff
```

You should see something similar to:

```text
modified: content/Tutorials/Some Article/index.md
```

If `git status` still says:

```text
nothing to commit, working tree clean
```

then the next thing I need to inspect is your **`static/admin/config.yml`**, especially the `collections` section.

Paste the complete output of:

```bash
cat static/admin/config.yml
```

and I can tell you exactly what needs to change.

