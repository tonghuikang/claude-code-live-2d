# Milestones & Phased Delivery

## Milestone H0 (30 min): End-to-end "hello"
- [ ] Backend: Single public webhook `POST /api/webhook/cli` (no auth)
- [ ] Backend: In-memory broadcast to all clients via WebSocket (pick WS to start)
- [ ] Frontend: Simple page connects to WS and logs messages to console
- [ ] curl example: send `{ "event_type": "ping" }` -> see console message

## Milestone H1 (60-90 min): Live2D reacts
- [ ] Frontend: integrate one Live2D model (existing asset)
- [ ] Map 3 events -> animations: `task_started`, `task_succeeded`, `task_failed`
- [ ] Minimal HUD: connection status badge (green/red)
- [ ] Frontend: copy-to-clipboard for webhook URL and payload samples

## Milestone H2 (60 min): Claude Code hook demo
- [ ] Provide Claude Code hook snippet (no auth) targeting webhook URL
- [ ] Trigger 2-3 real actions to emit events (start/progress/success)
- [ ] Add lightweight progress animation on `task_progress`
- [ ] Record a 30s demo video

## Parking Lot (later)
- [ ] Auth/tokens and per-user isolation
- [ ] Rate limits and input validation
- [ ] SSE fallback or dual support
- [ ] Redis Pub/Sub for scale
- [ ] Runbooks, SLOs, dashboards
