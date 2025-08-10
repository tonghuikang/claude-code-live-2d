# Hooks & CLI Integration Plan

## Goal
Allow users to configure Claude Code (and other CLIs) to POST events to our backend with a user-specific token.

## Checklist
- [ ] __Claude Code Hook Template__
  - [ ] Provide JSON/YAML snippet with:
    - webhook URL: `${BACKEND_BASE_URL}/api/webhook/cli`
    - headers: `Authorization: Bearer <TOKEN>`
    - payload schema examples
  - [ ] Include event types mapping
- [ ] __Installer Scripts__
  - [ ] Shell script to append hook config
  - [ ] Windows (PowerShell) variant
  - [ ] Safety: backups and idempotency
- [ ] __Other CLIs__
  - [ ] Generic curl example
  - [ ] Git hooks example (pre-commit, post-merge)
- [ ] __Docs & Validation__
  - [ ] Verify network reachability (curl test)
  - [ ] Debug mode: echo endpoint
  - [ ] Rate limit guidance

## Example Payloads
- task_started: { tool: "claude-code", task_id, label }
- task_progress: { task_id, pct, message }
- task_succeeded: { task_id, result_summary }
- task_failed: { task_id, error }
- log: { task_id, level, message }
