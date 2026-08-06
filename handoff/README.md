# Handoff Skill

**Write a comprehensive session handoff archive for the next session to pick up.**

## Installation

### 1. Clone the repo

```bash
git clone https://github.wdf.sap.corp/I578336/skills.git <path-to-your-home>/.claude/skills
```

### 2. Install the hook script

Copy the hook script to your hooks directory:

```bash
cp <path-to-your-home>/.claude/skills/handoff/hooks/read-handoff.sh <path-to-your-home>/.claude/hooks/
chmod +x <path-to-your-home>/.claude/hooks/read-handoff.sh
```

### 3. Register the SessionStart hook

Add this to `<path-to-your-home>/.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [
          {
            "type": "command",
            "command": "<path-to-your-home>/.claude/hooks/read-handoff.sh"
          }
        ]
      }
    ]
  }
}
```

Restart Claude Code after installation.

---

## Usage

### At session end

Invoke the skill:
```
/handoff
```

Claude writes `HANDOFF.md` in the project root with a structured archive covering:
- Task context and constraints
- Concrete actions taken this session
- Root cause analysis if a bug was investigated
- Key technical findings
- Code changes (uncommitted files)
- Gotchas — mistakes not to repeat
- Pending work and next steps
- Open questions / decisions pending
- Environment notes

### At session start

Nothing to do. The `SessionStart` hook runs automatically and injects the previous `HANDOFF.md` as context. Claude will acknowledge the handoff before you type anything.

---

## Scope

Project-specific — each project gets its own `HANDOFF.md` in the repo root. The handoff is committed alongside code so all team members can read prior session context.
