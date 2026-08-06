#!/bin/bash
# SessionStart hook: reads HANDOFF.md from the project directory and injects as context.
# If no HANDOFF.md exists, exits silently.

set -euo pipefail

INPUT=$(cat)
PROJECT_DIR=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('cwd', ''))
except Exception:
    print('')
" 2>/dev/null || true)

if [ -z "$PROJECT_DIR" ]; then
    exit 0
fi

HANDOFF_FILE="$PROJECT_DIR/HANDOFF.md"

if [ ! -f "$HANDOFF_FILE" ]; then
    exit 0
fi

CONTENT=$(cat "$HANDOFF_FILE")

python3 - <<EOF
import json

content = """$CONTENT"""

output = {
    "hookSpecificOutput": {
        "hookEventName": "SessionStart",
        "additionalContext": (
            "=== HANDOFF FROM PREVIOUS SESSION ===\n"
            + content
            + "\n=== END OF HANDOFF ===\n\n"
            "You have been briefed on the previous session. "
            "Acknowledge the handoff briefly to the user at your first opportunity, "
            "and pick up from the pending work listed above."
        )
    }
}
print(json.dumps(output))
EOF
