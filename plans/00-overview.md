# Live2D User-Specific Notifications – Project Overview

This project enables per-user Live2D notifications for coding actions from Claude Code and other CLIs. Users obtain a token from the web app, configure local hooks with that token, and receive real-time, isolated notifications in their own Live2D instance.

- __Current Deployments__: Backend (Modal), Frontend (Vercel)
- __Goal__: Multi-tenant, user-isolated, real-time notifications
- __Key Constraints__: No user IDs yet, single backend & frontend

## Master Checklist
- [ ] Architecture & Data Model finalized
- [ ] Auth & Token Issuance built and documented
- [ ] Webhook ingestion with auth validation
- [ ] Real-time delivery isolated per user
- [ ] Frontend: token flow, config UI, Live2D instance per user
- [ ] Security hardening and rate limits
- [ ] Observability (logs, metrics, tracing)
- [ ] E2E, load, and isolation tests
- [ ] CI/CD & rollout plan

## Architecture (Target)
- __Frontend (Vercel)__: Next.js app providing token issuance UI, user dashboard, Live2D canvas. Connects to backend for auth, websockets/SSE for real-time.
- __Backend (Modal)__: REST for auth + config, Webhook endpoint for events, Pub/Sub or in-memory broker for fanout, real-time channel per user via WebSocket/SSE.
- __Storage__: KV/DB for users, tokens, sessions, rate limits, event audit.
- __Delivery__: WebSockets preferred for bidirectional control; fallback to SSE.

## Data Model (Initial)
- __User__: { id, created_at }
- __Token__: { token_id, user_id, type: "hook" | "session", scopes, expires_at, revoked_at }
- __Hook Event__: not persisted by default; optionally audit-log with { id, user_id, type, payload, received_at }
- __Session__: { session_id, user_id, created_at, last_seen_at }

## MVP Scope
- [ ] Anonymous user -> short-lived hook token issuance
- [ ] Webhook endpoint validates token -> emits real-time event to that token’s user
- [ ] Frontend Live2D reacts to basic event types (start, progress, success, error)
- [ ] Copy-paste local hook config (Claude Code) with token & URL
- [ ] Basic metrics, minimal logging, rate limiting

## Out of Scope (Phase 1)
- Paid plans/billing
- OAuth sign-in (optional later)
- Persistent event history
- Multi-region active-active
