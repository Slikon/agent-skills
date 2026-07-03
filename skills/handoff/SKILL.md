---
name: handoff
description: Compact the current conversation into a handoff document for another agent to pick up.
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
---

Write a handoff document summarising the current conversation so a fresh agent can continue the work.

Save it **inside the project** so it survives a system restart and can be reopened later — never in a temp directory:

1. Resolve the repo root with `git rev-parse --show-toplevel`. If that fails (not a git repo), use the current working directory.
2. Write to `<root>/.handoffs/<YYYY-MM-DD-HHmm>-<slug>.md`, creating `.handoffs/` if it doesn't exist. `<slug>` is a few kebab-case words naming the work.
3. Print the saved path so the user can reopen it later.

Include:

- A **Next steps** section — the concrete actions the next agent should take, so it can pick up cold. (The [`next-steps`](../next-steps/SKILL.md) skill reads this.)
- A **Suggested skills** section — skills the next agent should invoke.

Do not duplicate content already captured in other artifacts (PRDs, plans, ADRs, issues, commits, diffs). Reference them by path or URL instead.

Redact any sensitive information, such as API keys, passwords, or personally identifiable information.

If the user passed arguments, treat them as a description of what the next session will focus on and tailor the doc accordingly.
