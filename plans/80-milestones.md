# Milestones & Phased Delivery

## Milestone 0: Wire-only MVP (1-2 days)
- [ ] Backend: Single public webhook `POST /api/webhook/cli` (no auth)
- [ ] Backend: Broadcast incoming events to all connected clients (WS or SSE)
- [ ] Frontend: One page with Live2D reacting to 3-4 core events
- [ ] Examples: curl + Claude Code hook snippet to trigger events

## Milestone 1: Demo polish (1-2 days)
- [ ] Frontend: auto-reconnect, simple connection status indicator
- [ ] Backend: basic structured logs
- [ ] Frontend: copy-to-clipboard for webhook URL and sample payloads
- [ ] Minimal error toasts

## Milestone 2: Optional next steps (later)
- [ ] Authentication/tokens and per-user isolation
- [ ] Rate limits and input validation
- [ ] SSE fallback if starting with WS (or vice-versa)
- [ ] Redis Pub/Sub for multi-instance scale
- [ ] Runbooks, SLOs, dashboards

