# agent-skills

A small set of agent skills for everyday engineering work. Each skill is a folder under [`skills/`](skills/) with a single `SKILL.md`. The format is cross-agent — these install into Claude Code, Cursor, Codex, Gemini CLI, GitHub Copilot, OpenCode, Zed, and [70+ other agents](https://skills.sh) via the [`skills`](https://github.com/vercel-labs/skills) CLI.

## Skills

| Skill | What it does |
|-------|--------------|
| [`teach-codebase`](skills/teach-codebase/SKILL.md) | Build a mental model of an unfamiliar repo: architecture, subsystems, and where to look when changing something. Saved at `.teach/codebase.md`. |
| [`teach-pr`](skills/teach-pr/SKILL.md) | Explain what a PR or branch actually does before you review it — mental model, traced execution path, what to question. Saved at `.teach/`. |
| [`handoff`](skills/handoff/SKILL.md) | Compact the conversation into a handoff doc for the next agent. Saved at `.handoffs/` so it survives a restart. |
| [`respond-to-pr-comments`](skills/respond-to-pr-comments/SKILL.md) | Work through a PR's review comments: fix the valid ones, reply to the rest explaining why not. Takes a PR url or number. |
| [`next-steps`](skills/next-steps/SKILL.md) | Read the latest handoff and lay out the next steps. |
| [`readme-check`](skills/readme-check/SKILL.md) | Make sure the project has a README that's short, complete, and free of fluff. |
| [`tldr`](skills/tldr/SKILL.md) | Compress a wall of text into a tight summary. |
| [`bro`](skills/bro/SKILL.md) | Restate the last message in plain human language, with no jargon. |

`teach-pr` reads `.teach/codebase.md` when it exists and explains the change as a delta against it, so running `teach-codebase` once per repo makes every later `teach-pr` sharper. Both record the commit they were generated at, so a re-run updates what actually moved instead of regenerating from scratch. They're working notes, not docs — worth adding `.teach/` to your `.gitignore`.

## Install

Needs Node (for `npx`) and `git`. `respond-to-pr-comments` also needs the `gh` CLI; `teach-pr` uses `gh` when a PR exists but falls back to a plain branch diff.

### With the `skills` CLI (recommended, any agent)

```bash
# Interactive — pick which skills and which agents
npx skills add Slikon/agent-skills

# Everything, globally, into Claude Code, no prompts
npx skills add Slikon/agent-skills -g -a claude-code -y

# Other agents, or several at once
npx skills add Slikon/agent-skills -a cursor -a codex

# Just one skill
npx skills add Slikon/agent-skills --skill tldr
```

Update later with `npx skills update`.

### Without the CLI (Claude Code only)

Clone and run the installer, which symlinks each skill into `~/.claude/skills/`:

```bash
git clone https://github.com/Slikon/agent-skills.git
cd agent-skills
./install.sh                                                     # into ~/.claude/skills
CLAUDE_SKILLS_DIR=/path/to/project/.claude/skills ./install.sh   # into one project
```

Restart your agent afterward so it picks up the new skills.

## Usage

Type any skill by name:

```
/teach-codebase                 # or: /teach-codebase auth
/teach-pr                       # or: /teach-pr https://github.com/you/repo/pull/42
/handoff wiring up the payments webhook
/respond-to-pr-comments https://github.com/you/repo/pull/42
/next-steps
/readme-check
/tldr
/bro
```

Every skill except `handoff` and `bro` also carries a `description`, so the agent can fire it on its own from natural phrasing — "that's too long, give me the short version" fires `tldr`, "what's next?" fires `next-steps`. Those two are typed-only by design.
