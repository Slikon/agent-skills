---
name: teach-codebase
description: Build a mental model of an unfamiliar codebase — architecture, subsystems, and where to look when changing something. Use when the user is new to a repo, is picking up a project they didn't write, or asks how a codebase is structured or where something lives.
argument-hint: "[area to focus on]"
---

Teach the user this codebase the way a colleague would at a whiteboard: a short **lesson** they read once, top to bottom — not a reference file they look things up in. The reader finishes able to retell how the system works; they do not memorize facts from it.

If arguments were passed, scope the lesson to that area.

## Steps

### 1. Check for an existing lesson
Read `<repo root>/.teach/codebase.md` if it exists (resolve root with `git rev-parse --show-toplevel`, else the current directory). Its frontmatter carries the commit it was generated at — run `git diff <that sha>..HEAD --stat` and update only what moved. If the diff is huge or the SHA is unreachable, start fresh.

### 2. Explore enough to tell the story
Widening passes — structure and manifests, then entry points and config, then the main flow — and stop as soon as you can narrate one real run of the system end to end. If a code-index MCP is available (architecture or call-graph queries), use it instead of manual grep to find entry points and trace the flow. Trust code over documentation when they disagree.

### 3. Write the lesson
Write `<repo root>/.teach/codebase.md` with frontmatter (`commit:` from `git rev-parse HEAD`, `generated:` date). Three parts, in this order:

**Part 1 — The idea.** What the system does and for whom, in a few lines. Then the one or two design decisions that explain everything else (for example: "there is no database — files on disk are the state"). Then one small overview diagram, **3–7 boxes**, concepts not filenames.

**Part 2 — One run, start to finish.** The heart of the lesson. Pick the system's most representative operation — a request, a job, a build — and narrate it as a story: "You do X. First A happens (`file.py`), because ... Then B ...". Each step says what happens, which file does it, and why it is a separate step. Add a `sequenceDiagram` of this flow that matches the narration.

Close Part 2 with a **module map**: one flowchart of the real modules, grouped into named `subgraph` blocks by role (front end, pipeline stages, shared services — whatever the system's real groupings are), with edges labeled by the data that flows between them. Grouping is the budget: at most ~5 groups of ~5 nodes each — name the groups, don't enumerate every file. This map comes *after* the story on purpose: a map only makes sense once the reader knows the journey.

**Part 3 — Working in it.** A table mapping change to place — "To change X → open Y" — one line per row, no paragraphs. Then at most five warnings, each a single plain sentence: the mistake, what you will see, what to do instead.

**Cut everything else.** No file inventories, no disk layouts, no lists of config options, no documentation audits, no branch or git state. Those facts live in the repo; the lesson exists to build the model, not to copy the data. If existing docs would actively mislead a reader, that is one warning line in Part 3, not a section.

### 4. Language and diagram rules
- Write for a reader whose first language may not be English: short sentences, plain words, no idioms or colloquialisms ("gotcha", "trips you up", "load-bearing", "escape hatch"). If a domain term is unavoidable, define it in the same sentence.
- Never show a naked diagram. One sentence before it stating the question it answers; one sentence after it pointing at the thing to notice. A diagram over ~8 ungrouped nodes gets grouped into subgraphs, split, or cut.
- Explain **why** a thing exists whenever the code shows the reason. Mark guesses as guesses; label confidence only when it isn't high. Never invent a rationale.

### 5. Hand it back
Print the path and offer to go deeper on any part. Target under ~150 lines, readable in five minutes. If it runs long, cut Part 3 detail — never Part 2.

**Completion criterion:** after one top-to-bottom read, the user can retell how one real run moves through the system, and knows which file to open for each kind of change.
