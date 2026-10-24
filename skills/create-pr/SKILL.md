---
name: create-pr
description: Create or update a pull request with a concise, human-first overview at the very top, plus explicit visual/asset change notes and screenshots whenever UI or image dimensions/quality change. Use whenever the user asks to create, open, draft, or update a PR.
argument-hint: "[base branch or PR title]"
---

Create or update a pull request so a human reviewer understands the entire change immediately and never gets surprised by undocumented visual or asset changes.

## Rules

### 1. High-level overview first — in every PR
The very first section of the PR body (`## Overview`) is for the human reviewer, before anything else.
- **Applies to all PRs** (backend, frontend, infra, docs, skills).
- **Concise and direct:** no filler, no throat-clearing, no extra words — straight on point, yet descriptive enough that a reviewer understands everything that changed and why in one read.
- **Complete:** cover the full branch diff (`<base>...HEAD`), not just the most recent commit.

### 2. Visual & asset changes — explicit statement + screenshots
Inspect `git diff <base>...HEAD` for anything that changes what the client sees or downloads: UI layout, styling, copy, components, or image/media asset dimensions, compression, or quality.
- **State visual and asset changes explicitly:** if image dimensions, file size, encoding quality, or layout changed, list the exact before/after details (e.g. dimensions, byte size, quality setting, and whether visual appearance is affected).
- **Attach screenshots:** render the changed pages/states in a browser (desktop and mobile viewports where relevant), upload the screenshots (using the repo's convention such as a `pr-assets` branch if documented in `AGENTS.md`), and embed them in the PR description.
- **Fallback when screenshots are impossible:** if the environment genuinely prevents capturing or hosting screenshots, state that explicitly in the PR body and describe how the change was verified. Never silently omit screenshots on a visual change.

## Steps

### 1. Inspect the full branch delta
Run in parallel:
- `git status`
- `git log <base>..HEAD --oneline` (resolve `<base>` from arguments or the repo's default branch)
- `git diff <base>...HEAD --stat`

Check the repo's `AGENTS.md` or contributing docs for any repo-specific PR rules (such as a `pr-assets` screenshot branch).

### 2. Verify the work
Run the project's verification suite (format, lint, typecheck, tests, build) before pushing. Fix any failures first.

### 3. Capture screenshots when UI or visual assets changed
If the diff touches frontend UI, pages, styles, or client-facing images/media:
1. Start or use the built preview/dev server and capture screenshots of the affected views (desktop and mobile when applicable).
2. Host the images so GitHub renders them in the PR body (e.g. commit to `pr-assets` and reference `https://raw.githubusercontent.com/<owner>/<repo>/pr-assets/...`).
3. Record exact before/after metrics if image dimensions or compression quality changed.

### 4. Push and open (or update) the PR
Push the current branch with `git push -u origin HEAD` and create the PR via `gh pr create` (or `gh pr edit` if one already exists for the branch) using this structure:

```markdown
## Overview
<Concise, straight-to-the-point summary for the human reviewer covering everything changed in this PR and why.>

## Key Changes
- <Concrete technical changes grouped by area>

## Visual & Asset Changes
<Include whenever UI, pages, or image/media dimensions or quality changed. Explicitly state any visual, dimension, or quality changes and embed screenshots — or state explicitly if screenshots could not be captured.>

## Verification
- <Commands, tests, builds, and browser checks run>
```

Omit `## Visual & Asset Changes` only when the PR has zero client-facing visual or asset changes.

### 5. Return the PR link
Print the PR URL as the final outcome.

**Completion criterion:** every commit on the branch is represented in a tight `## Overview` at the very top of the PR, any visual or image size/quality change is stated explicitly with screenshots embedded (or an explicit note if unavailable), and the user has the PR URL.
