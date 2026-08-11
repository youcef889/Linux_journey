# Linux_journey
My Linux journey is my blog . i share in it what i learn about linux 


 how to  Run  decap cms  

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

