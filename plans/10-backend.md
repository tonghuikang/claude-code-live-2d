# Backend Plan (Modal)

## High-Level
Provide APIs for token issuance, webhook ingestion, and real-time delivery via WebSockets/SSE. Ensure strict per-user isolation and validation.

## Checklist
- [ ] __Project Setup__
  - [ ] Confirm runtime, framework (FastAPI/Express/etc.)
  - [ ] Add env config: BASE_URL, CORS, LOG_LEVEL
  - [ ] Choose storage: lightweight (SQLite/Neon/Postgres/KV)
  - [ ] Define common error schema and middleware
- [ ] __Data Layer__
  - [ ] Tables/collections: users, tokens, sessions, audit_logs (optional)
  - [ ] Migrations or schema scripts
  - [ ] Token index by token_id; FK to user_id
- [ ] __Auth & Token__
  - [ ] POST `/api/token` issues user-scoped hook token (JWT or random ID)
  - [ ] Token payload: user_id, type="hook", scopes=["webhook"], exp
  - [ ] Validate token middleware for webhook & realtime
  - [ ] Revoke endpoint POST `/api/token/revoke`
- [ ] __User__
  - [ ] POST `/api/user` creates anonymous user if none (returns `user_id`)
  - [ ] GET `/api/me` returns user + active tokens
- [ ] __Webhook Ingestion__
  - [ ] POST `/api/webhook/cli`
  - [ ] Headers: `Authorization: Bearer <hook_token>`
  - [ ] Body: { event_type, event_id?, ts, payload }
  - [ ] Validate: schema, token, rate-limit per token
  - [ ] Emit to user channel: `publish(user_id, event)`
- [ ] __Real-time Delivery__
  - [ ] WebSocket `/api/rt` with `Authorization: Bearer <session_or_hook_token>`
  - [ ] Map connections by `user_id` -> set of sockets
  - [ ] Heartbeats + idle timeouts
  - [ ] Fallback SSE `/api/sse`
- [ ] __Routing & Isolation__
  - [ ] `publish(user_id, event)` sends only to sockets bound to that user
  - [ ] No global broadcast
- [ ] __Security__
  - [ ] CORS allowlist (Vercel domain)
  - [ ] Input validation (schema)
  - [ ] Rate limit (token + IP)
  - [ ] Request signing (optional future)
- [ ] __Observability__
  - [ ] Structured logs (request_id, user_id, token_id)
  - [ ] Metrics: qps, connected_sockets, delivery_latency
  - [ ] Error alerts
- [ ] __Docs__
  - [ ] API reference (OpenAPI)
  - [ ] Example curl scripts

## API Sketch
- POST `/api/user` -> { user_id }
- POST `/api/token` -> { token, user_id, type, exp }
- POST `/api/token/revoke` -> { ok }
- POST `/api/webhook/cli` -> { ok }
- WS `/api/rt` -> send events
- GET `/api/sse` -> event stream

## Event Contract
- `event_type`: "task_started" | "task_progress" | "task_succeeded" | "task_failed" | "log"
- `payload`: free-form JSON; keep under 64KB
- `ts`: ISO-8601
- `id`: server-generated if missing
