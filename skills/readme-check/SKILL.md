---
name: readme-check
description: Make sure the project has a README that is short, on-topic, and covers the instructions someone actually needs — no fluff. Use when the user asks to check, write, or tighten the project's README.
---

Ensure the current project has a README that earns its length: short, on-topic, every instruction someone needs to use the project, and no fluff.

## Steps

### 1. Find or start the README
Look for `README.md` at the repo root (resolve root with `git rev-parse --show-toplevel`, else the current directory). If none exists, create one.

### 2. Learn what the project actually needs
Read enough of the repo to know what it is, how to install/set it up, how to run it, and how to use it. Draw from package manifests, entry points, scripts, config, and existing docs — don't guess.

### 3. Write the README against these bars
A reader should be able to install, run, and use the project **from the README alone**. Cover only what serves that:

- **What it is** — one or two lines.
- **Install / setup** — the exact commands.
- **Usage** — the commands or API a user actually runs, with minimal examples.
- **Anything that would otherwise block them** — prerequisites, env vars, required config.

Then cut the fluff: marketing lines, restated headings, obvious filler, padding. Every section must carry an instruction or a fact the reader needs.

**Completion criterion:** someone new could install, run, and use the project from this README alone, and there is no line you could delete without losing an instruction or a needed fact.
