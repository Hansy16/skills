---
name: handoff
description: Write a comprehensive session handoff archive to HANDOFF.md at the end of a session. Use when the user says the session is ending, wants to wrap up, or explicitly invokes /handoff.
disable-model-invocation: false
allowed-tools: Read Write Bash
---

You are writing a handoff document for the NEXT session's Claude, who has zero background on this project or conversation. Be maximally specific — vague summaries are useless. Include exact file paths, line numbers, function names, field names, error messages, and code snippets where relevant.

Write to `HANDOFF.md` in the project root directory (`${CLAUDE_PROJECT_DIR}/HANDOFF.md`).

## Structure to follow

```markdown
# Session Handoff — <YYYY-MM-DD>

## Project & Task Context
What project is this, what is the active Jira/GitHub ticket, what is the user trying to accomplish, and what are the constraints (e.g. "no re-grounding", "all fixes target existing cloud data").

## What Was Done This Session
Bullet list of concrete actions taken. For each: what was done, which file/line was changed, and why.

## Root Cause Analysis
If a bug or issue was investigated: exact cause, evidence found, how it was confirmed. Written so anyone can understand without re-investigating.

## Key Technical Findings
Non-obvious facts discovered during this session that will be needed again. Prefer facts over summaries:
- Exact field names and their presence rates in the data
- Which fields are/aren't stored as chunk metadata in cloud
- Architecture decisions and why they were made
- Differences between entities (e.g. SolutionComponent vs SAPCapabilityModel)

## Code Changes Made (Still in Working Copy)
List every file that has uncommitted changes, what was changed, and whether it should be kept or reverted. Include the git diff summary if helpful.

## Gotchas — Do Not Repeat These Mistakes
Specific mistakes made this session with exact details. Written as rules:
- "Do NOT check only the first item in a list to infer field presence — check the full distribution"
- "Do NOT try to fix EARP-17538 by modifying document_grounding.py — user said no re-grounding"

## Pending Work & Next Steps
Exact next actions with enough detail to resume immediately. Include: which file to edit, what change to make, what to verify.

## Open Questions / Decisions Pending
Things that were discussed but not decided. Include the options and tradeoffs already analyzed so the next session doesn't repeat the analysis.

## Environment Notes
Anything needed to reproduce the setup: local server URL, grounding commands used, how to restart the server, which zip files contain which data.
```

## Instructions

1. Read the full conversation context to extract all relevant information.
2. Run `!git diff HEAD --stat` to list all uncommitted file changes.
3. Run `!git status` to check for untracked files.
4. Write the HANDOFF.md using the structure above. Be specific. Do not generalize.
5. Confirm to the user: "HANDOFF.md written to `${CLAUDE_PROJECT_DIR}/HANDOFF.md`"
