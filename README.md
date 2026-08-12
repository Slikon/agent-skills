# agent-skills

A small set of Agentic skills for everyday engineering work: understanding code you didn't write, capturing handoffs, working through PR review comments, picking up where you left off, keeping READMEs tight, cutting a wall of text down to the point, and saying it again without the jargon.

Each skill is a folder under [`skills/`](skills/) with a single `SKILL.md`. The format is cross-agent — these install into Claude Code, Cursor, Codex, Gemini CLI, GitHub Copilot, OpenCode, Zed, and [70+ other agents](https://skills.sh) via the [`skills`](https://github.com/vercel-labs/skills) CLI.

> Tooling note: `respond-to-pr-comments` needs the `gh` and `git` CLIs; `teach-pr` uses `gh` when a PR exists but falls back to a plain branch diff; `teach-codebase`, `handoff`, `next-steps`, and `readme-check` need `git`. the `disable-model-invocation` frontmatter on `handoff` and `bro` is a Claude Code flag that other agents safely ignore.

## Skills

| Skill | What it does | How it's invoked |
|-------|--------------|------------------|
| [`teach-codebase`](skills/teach-codebase/SKILL.md) | Build a mental model of an unfamiliar repo: architecture, subsystems, and where to look when changing something. Saved at `.teach/codebase.md`. | Auto or typed |
| [`teach-pr`](skills/teach-pr/SKILL.md) | Explain what a PR or branch actually does before you review it — mental model, traced execution path, what to question. Saved at `.teach/`. | Auto or typed |
| [`handoff`](skills/handoff/SKILL.md) | Compact the conversation into a handoff doc for the next agent. Saved in the project at `.handoffs/` so it survives a restart. | You type it |
| [`respond-to-pr-comments`](skills/respond-to-pr-comments/SKILL.md) | Work through a PR's review comments: fix the valid ones, reply to the rest explaining why not, hand back the PR link. Takes a PR url/number. | Auto or typed |
| [`next-steps`](skills/next-steps/SKILL.md) | Read the latest handoff and lay out the next steps — short and on-topic. | Auto or typed |
| [`readme-check`](skills/readme-check/SKILL.md) | Make sure the project has a README that's short, complete, and free of fluff. | Auto or typed |
| [`tldr`](skills/tldr/SKILL.md) | Compress a wall of text into a tight summary. | Auto or typed |
| [`bro`](skills/bro/SKILL.md) | Restate the last message in plain human language, with no jargon. | You type it |

"Auto" skills carry a `description`, so Claude can fire them on its own; you can also type their name. `handoff` and `bro` are typed-only by design.

The two `teach-*` skills are about understanding code rather than judging it — they explain, they don't review. `teach-pr` reads `.teach/codebase.md` when it exists and explains the change as a delta against it, so running `teach-codebase` once per repo makes every later `teach-pr` sharper. Both artifacts record the commit they were generated at, so a re-run updates what actually moved instead of regenerating from scratch. They're working notes, not docs — worth adding `.teach/` to your `.gitignore`.

## Install

### With the `skills` CLI (recommended, any agent)

```bash
# Interactive — pick which skills and which agents
npx skills add Slikon/agent-skills

# Install everything globally into Claude Code, no prompts
npx skills add Slikon/agent-skills -g -a claude-code -y

# Other agents, or several at once
npx skills add Slikon/agent-skills -a cursor -a codex

# Just one skill
npx skills add Slikon/agent-skills --skill tldr
```

Update later with `npx skills update`. Browse the ecosystem at [skills.sh](https://skills.sh).

### Without the CLI (Claude Code only)

Clone and run the installer, which symlinks each skill into `~/.claude/skills/`:

```bash
git clone https://github.com/Slikon/agent-skills.git
cd agent-skills
./install.sh                                               # into ~/.claude/skills
CLAUDE_SKILLS_DIR=/path/to/project/.claude/skills ./install.sh   # into one project
```

Restart your agent afterward so it picks up the new skills.

## Usage

Type a skill by name in Claude Code:

```
/teach-codebase
/teach-codebase auth
/teach-pr
/teach-pr https://github.com/you/repo/pull/42
/handoff wiring up the payments webhook
/respond-to-pr-comments https://github.com/you/repo/pull/42
/next-steps
/readme-check
/tldr
/bro
```

The auto-invoked ones also trigger from natural phrasing — e.g. "that's too long, give me the short version" fires `tldr`, and "what's next?" fires `next-steps`.
