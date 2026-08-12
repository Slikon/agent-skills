---
name: teach-pr
description: Explain what a PR or branch actually does before you review it — the mental model, the execution path, and what to question. Use when the user needs to understand a change they didn't write, or an agent just produced a large diff or PR.
argument-hint: "[PR url or number]"
---

Explain a change so the user can review it with a mental model already in their head. Understanding, not criticism — for a findings-and-severity review, that's `/code-review`.

## Steps

### 1. Resolve the target
In order: the PR in the arguments → a PR open for the current branch (`gh pr view --json number,title,body`) → the local branch diff. For the local case find the base (`git merge-base HEAD main`, or whatever the default branch is) and use `git diff <base>...HEAD`. `gh` is optional — never block on it.

### 2. Scope the reading
The diff, the changed files, their direct callers and callees, and the tests and config the change touches. **Stop there.** Don't walk the dependency graph or read unrelated subsystems. If a code-index MCP is available (call graph, callers/callees), prefer it over manual grep to find these.

If `<repo root>/.teach/codebase.md` exists, read it first for architectural context and explain the change as a *delta* against it rather than re-deriving the repo. Check its frontmatter `commit` against `HEAD` — if the file is far behind, say so and trust the code.

### 3. Trace one real path end to end
Pick a concrete entry point the change affects and follow it through, naming the actual file and symbol at every hop (`src/services/order.ts:create()`). One traced path is worth more than a summary of every file.

### 4. Look for what AI-written code gets wrong
Check specifically:

- An abstraction introduced and used exactly **once**.
- Logic reimplemented that **already exists** elsewhere in the repo — search before believing it's new.
- Something the task asked for that the diff **silently doesn't do**.
- Tests that assert the implementation back to itself rather than the behavior.
- Config, flags, or env vars added but never read.
- Error handling that catches and swallows.
- Scaffolding left unwired — dead exports, unused params, TODOs.

Report what you actually find. If the change is clean on all seven, say so in a line and move on.

### 5. Write it
Write `<repo root>/.teach/pr-<number>.md`, or `.teach/<branch-name>.md` with no PR, creating `.teach/` if needed. Frontmatter first:

```yaml
---
commit: <git rev-parse HEAD>
generated: <YYYY-MM-DD>
---
```

**Always include:**

- **TL;DR** — what this change does, in a few lines.
- **Mental model** — the shape of the change: what the flow was before, what it is now. A small before/after Mermaid `flowchart` when the architecture genuinely moved; skip it when the change is local.
- **Execution path** — the trace from step 3.
- **Files that matter** — split *critical* / *supporting*, one line each on why. Never list every changed file; cover the mechanical ones in a single line.
- **What to question** — at most 7 items, from the step 4 findings and anything you couldn't establish from the repo. Each item: a `path:line` anchor, a short **verbatim excerpt** of the code in question (3–10 lines in a language-tagged fence, copied from the file — never retyped from memory), and one plain sentence on why it matters. Where items connect, link them with anchor links.
- **Review order** — the numbered order to open the files in, so the user doesn't read the diff alphabetically. Link each entry to the section of this doc that discusses it.

Excerpts serve the reader, not completeness: quote only code that changes what they check, keep total quoted code under ~100 lines, and fold longer supporting excerpts into `<details>` blocks. A 1–3 line quote at a pivotal hop of the execution path is welcome on the same terms.

Skip any other heading rather than padding it. Scannable in five minutes.

### 6. Language and honesty rules
- Write for a reader whose first language may not be English: short sentences, plain words, no idioms or colloquialisms. Never show a naked diagram — one sentence before it stating the question it answers, one after it pointing at the thing to notice; over ~8 nodes, split or cut it.
- State observed behavior plainly. Mark inferences as inferences, and label confidence **only when it isn't high**. Where the author's intent can't be established from the repo, write it as a question for them rather than a guess — never invent a rationale.

### 7. Hand it back
Print the path and the TL;DR, and note they may want to gitignore `.teach/`. Don't commit it, and don't approve, merge, or comment on the PR.

**Completion criterion:** the user knows what changed, how the new code runs, and which three things to look at hardest — before opening the diff.
