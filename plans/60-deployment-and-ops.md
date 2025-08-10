# Deployment, Ops, and Observability Plan

## Checklist
- [ ] __Environments__
  - [ ] Staging and Production
  - [ ] Separate projects/vars for Modal/Vercel
- [ ] __CI/CD__
  - [ ] Lint + typecheck + tests
  - [ ] Build artifacts
  - [ ] Auto-deploy on main with approvals to prod
- [ ] __Env Vars__
  - [ ] BACKEND_BASE_URL, FRONTEND_BASE_URL
  - [ ] DB_URL, REDIS_URL (if used)
  - [ ] JWT_SECRET or TOKEN_SIGNING_KEY
- [ ] __Observability__
  - [ ] Structured logs with correlation IDs
  - [ ] Metrics dashboard (QPS, latency, errors)
  - [ ] Tracing (optional)
- [ ] __Runbooks__
  - [ ] Incident response checklist
  - [ ] Token compromise procedure
  - [ ] Rollback & hotfix steps
- [ ] __Scaling__
  - [ ] WebSocket capacity planning
  - [ ] Broker sizing if using Redis
  - [ ] Load test targets
