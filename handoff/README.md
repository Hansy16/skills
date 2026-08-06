# Handoff Skill

Session continuity for Claude Code. Automatically injects the previous session's
context at startup, and writes a detailed handoff archive when you invoke `/handoff`.

## What it does

- **Session start**: reads `HANDOFF.md` from the project root and injects it as context via a `SessionStart` hook — Claude is briefed on prior work before you type anything
- **Session end**: `/handoff` writes a structured archive to `HANDOFF.md`, covering task context, key findings, code changes, gotchas, and next steps — written for a Claude with zero background

## Files

```
handoff/
├── SKILL.md              ← skill instructions loaded by Claude Code
├── README.md             ← this file
└── hooks/
    └── read-handoff.sh   ← SessionStart hook script
```

## Installation

**1. Skill** — if you cloned the skills repo into `~/.claude/skills`, this is already in place.

**2. Hook script**
```bash
cp ~/.claude/skills/handoff/hooks/read-handoff.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/read-handoff.sh
```

**3. Register hook in `~/.claude/settings.json`**
```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [
          {
            "type": "command",
            "command": "/root/.claude/hooks/read-handoff.sh"
          }
        ]
      }
    ]
  }
}
```

## Usage

**At session end** — invoke the skill:
```
/handoff
```
Claude writes `HANDOFF.md` in the project root with a full session archive.

**At session start** — nothing to do. The hook runs automatically and injects
the previous `HANDOFF.md` as context. Claude will acknowledge the handoff.
