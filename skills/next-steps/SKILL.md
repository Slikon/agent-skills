---
name: next-steps
description: Read the latest handoff document and lay out the next steps — short and on-topic. Use when the user asks what's next, what to do next, or to pick up from a handoff.
---

Read the most recent handoff and tell the user what to do next — nothing else.

## Steps

### 1. Find the handoff
- Look in `<repo root>/.handoffs/` (resolve root with `git rev-parse --show-toplevel`, else the current directory). Pick the newest file by its timestamped name.
- If the user named a specific handoff or pasted a path, use that instead.
- If there is no handoff, say so in one line and stop — don't invent next steps.

### 2. Report the next steps
- Output a short ordered list of concrete next actions, drawn from the handoff's **Next steps** section and any open threads it describes.
- **On-topic only:** the immediate actionable steps — not a summary of the whole document, not its background.
- Keep it to the few steps that matter. No preamble, no recap.

**Completion criterion:** the user has a short, ordered list of concrete actions and nothing else.
