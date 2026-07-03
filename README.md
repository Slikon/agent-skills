# claude-skills

A small set of [Claude Code](https://claude.com/claude-code) skills for everyday engineering work: capturing handoffs, working through PR review comments, picking up where you left off, keeping READMEs tight, and cutting a wall of text down to the point.

Each skill is a folder under [`skills/`](skills/) with a single `SKILL.md`. They also work with any agent that reads the same skill format.

## Skills

| Skill | What it does | How it's invoked |
|-------|--------------|------------------|
| [`handoff`](skills/handoff/SKILL.md) | Compact the conversation into a handoff doc for the next agent. Saved in the project at `.handoffs/` so it survives a restart. | You type it |
| [`respond-to-pr-comments`](skills/respond-to-pr-comments/SKILL.md) | Work through a PR's review comments: fix the valid ones, reply to the rest explaining why not, hand back the PR link. Takes a PR url/number. | Auto or typed |
| [`next-steps`](skills/next-steps/SKILL.md) | Read the latest handoff and lay out the next steps — short and on-topic. | Auto or typed |
| [`readme-check`](skills/readme-check/SKILL.md) | Make sure the project has a README that's short, complete, and free of fluff. | Auto or typed |
| [`tldr`](skills/tldr/SKILL.md) | Compress a wall of text into a tight summary. | Auto or typed |

"Auto" skills carry a `description`, so Claude can fire them on its own; you can also type their name. `handoff` is typed-only by design.

## Install

Clone the repo and run the installer, which symlinks each skill into `~/.claude/skills/`:

```bash
git clone https://github.com/Slikon/claude-skills.git
cd claude-skills
./install.sh
```

To install into a single project instead of your user config:

```bash
CLAUDE_SKILLS_DIR=/path/to/project/.claude/skills ./install.sh
```

Restart Claude Code afterward so it picks up the new skills.

## Usage

Type a skill by name in Claude Code:

```
/handoff wiring up the payments webhook
/respond-to-pr-comments https://github.com/you/repo/pull/42
/next-steps
/readme-check
/tldr
```

The auto-invoked ones also trigger from natural phrasing — e.g. "that's too long, give me the short version" fires `tldr`, and "what's next?" fires `next-steps`.
