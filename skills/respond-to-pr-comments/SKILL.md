---
name: respond-to-pr-comments
description: Work through the review comments on a pull request — fix the valid ones, reply to the rest explaining why not. Use when the user says to address, respond to, resolve, or handle PR / review comments, or pastes a PR link and asks to deal with the feedback.
argument-hint: "<PR url or number>"
---

Address every review comment on a pull request. Judge each one on its **merits**, fix what's valid, and answer what isn't.

You need the PR — a URL or number — in the arguments. If none was given, ask for it before doing anything else.

## Steps

### 1. Gather the comments
- Resolve the PR from the argument. Use `gh pr view <pr> --json ...`, `gh api`, and `gh pr diff` to fetch both top-level review comments and inline code comments, each with its file, line, author, and thread.
- List every **unresolved** comment. Resolved and outdated threads are already done — skip them.

### 2. Judge each comment on its merits
For each comment decide **valid** or **invalid**:
- **Valid** — a real bug, a correctness or clarity issue, or a worthwhile improvement.
- **Invalid** — wrong, out of scope, based on a misread, or a matter of taste you've weighed and disagree with.

Judge on the merits, not on who wrote it. Don't reflexively agree to be agreeable, and don't dig in out of pride.

### 3. Fix the valid ones
- Make the change in the working tree. Group related fixes into coherent commits.
- Reply on that comment's thread noting what you changed and the commit that did it, so the reviewer can see it was handled.

### 4. Answer the invalid ones
- Leave the code as is. Reply on the thread explaining — specifically, without hedging — why you're not making the change: the misread, the constraint, the tradeoff.
- Disagree with the comment, never the commenter. Concrete and respectful.

### 5. Report and hand back the link
- Post one summary comment on the PR: what you fixed (with commit links) and what you declined (with a one-line reason each).
- Give the user the **PR link** so they can review your responses.

**Completion criterion:** every unresolved comment is either fixed-and-replied or answered-with-a-reason — none left untouched — and the user has the PR link.
