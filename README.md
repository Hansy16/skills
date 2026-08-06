# Claude Code Skills

Personal Claude Code skills collection. Each subdirectory is one skill.

## Skills

| Skill | Description |
|-------|-------------|
| [handoff](./handoff/) | Session continuity — auto-inject previous session context at startup, archive at session end with `/handoff` |

## Installation (after container rebuild)

```bash
# Clone directly into ~/.claude/skills
git clone https://github.com/Hansy16/skills.git ~/.claude/skills

# Install hook scripts for each skill
cp ~/.claude/skills/handoff/hooks/read-handoff.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/read-handoff.sh
```

Then add the SessionStart hook to `~/.claude/settings.json`:

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

## Adding a new skill

```bash
mkdir -p ~/.claude/skills/<skill-name>
# create SKILL.md and any supporting files
git add .
git commit -m "feat: add <skill-name> skill"
git push personal main
git -c http.sslVerify=false push enterprise main
```
