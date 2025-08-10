# Testing & QA Plan

## Checklist
- [ ] __Unit Tests__
  - [ ] Token issuance/validation
  - [ ] Webhook schema validation
  - [ ] Publish isolation
- [ ] __Integration Tests__
  - [ ] WebSocket connect + event flow
  - [ ] SSE fallback
  - [ ] Rate limiting
- [ ] __E2E Tests__
  - [ ] User visits app -> gets token -> installs hook -> triggers event -> Live2D reacts
  - [ ] Two users in parallel; ensure no cross-talk
- [ ] __Load Tests__
  - [ ] N concurrent users receiving events
  - [ ] M events/sec per user
- [ ] __Security Tests__
  - [ ] Token replay
  - [ ] Invalid/malformed payloads
  - [ ] CORS/origin checks

## Tooling
- Jest/Vitest for unit
- Playwright/Cypress for E2E
- k6/Artillery for load
