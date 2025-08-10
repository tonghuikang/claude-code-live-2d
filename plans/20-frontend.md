# Frontend Plan (Vercel)

## High-Level
Provide token issuance UX, show per-user Live2D instance reacting to events in real-time, and present copyable hook configuration.

## Checklist
- [ ] __Scaffold__
  - [ ] Pages: `/` (landing), `/dashboard` (token + config), `/live` (Live2D playground)
  - [ ] State: store `user_id`, `hook_token`, `session_token?` in memory + localStorage (careful with security)
  - [ ] Env: BACKEND_BASE_URL
- [ ] __Anonymous User Flow__
  - [ ] On visit, call POST `/api/user` -> store `user_id`
  - [ ] Issue hook token via POST `/api/token`
  - [ ] Show token and expiration
- [ ] __Hook Config UI__
  - [ ] Display copyable block with:
    - Backend webhook URL
    - Token
    - Example Claude Code hooks JSON and shell installer
  - [ ] Regenerate token button
- [ ] __Real-time Client__
  - [ ] WebSocket connect to `/api/rt` with Bearer token
  - [ ] Auto-reconnect, heartbeat, backoff
  - [ ] Handle events and dispatch to Live2D controller
- [ ] __Live2D Integration__
  - [ ] One instance per browser tab/session
  - [ ] Map events -> animations/speech bubbles
  - [ ] Minimal HUD: connection status, last event
- [ ] __UX Polish__
  - [ ] Copy-to-clipboard buttons
  - [ ] Dark mode
  - [ ] Error toasts
- [ ] __Docs__
  - [ ] How to set up hooks locally
  - [ ] Troubleshooting (network, proxies)

## Event -> UI Mapping (MVP)
- task_started -> wave/attention animation
- task_progress -> progress bar + subtle motion
- task_succeeded -> celebrate animation
- task_failed -> sad animation + error bubble
- log -> floating text snippets
