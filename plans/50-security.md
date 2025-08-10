# Security & Privacy Plan

## Threat Model (MVP)
- Token theft -> data injection or eavesdropping
- Abuse via spam requests
- Cross-tenant leakage

## Checklist
- [ ] __Tokens__
  - [ ] Random opaque tokens or JWT with short TTL
  - [ ] Scope: `webhook`, optional `realtime`
  - [ ] Rotate / revoke endpoints
- [ ] __Transport__
  - [ ] Enforce HTTPS, HSTS on frontend
  - [ ] Validate Origin/CORS
- [ ] __Validation__
  - [ ] Strict schemas and size limits
  - [ ] Rate limiting by token & IP
  - [ ] Optional request signing for CLIs
- [ ] __Isolation__
  - [ ] No broadcasting; all by user_id
  - [ ] Explicit checks before send
- [ ] __Storage__
  - [ ] Minimize PII; no sensitive payload retention
  - [ ] Encrypt secrets at rest
- [ ] __Logging__
  - [ ] Avoid logging tokens/payloads
  - [ ] Redaction middleware
- [ ] __Compliance__
  - [ ] Privacy policy page
  - [ ] Data retention policy
