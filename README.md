# Claude Code Skills

Personal Claude Code skills collection. Each subdirectory is one skill.

## Skills

| Skill | Description |
|-------|-------------|
| [handoff](./handoff/) | Session continuity — auto-inject previous session context at startup, archive at session end with `/handoff` |

## Installation

### In Container

```bash
# Clone directly into ~/.claude/skills
git clone https://github.wdf.sap.corp/I578336/skills.git ~/.claude/skills

# Install hook scripts for each skill
cp ~/.claude/skills/handoff/hooks/read-handoff.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/read-handoff.sh
```

### Locally

```bash
# Clone into your personal skills directory
git clone https://github.wdf.sap.corp/I578336/skills.git ~/.claude/skills

# Install hook scripts for each skill
cp ~/.claude/skills/handoff/hooks/read-handoff.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/read-handoff.sh
```

### Register Hook

Add the SessionStart hook to `~/.claude/settings.json`:

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

**For local setup**: Replace `/root/.claude/hooks/read-handoff.sh` with `$HOME/.claude/hooks/read-handoff.sh`.
