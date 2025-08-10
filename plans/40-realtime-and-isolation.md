# Real-time Delivery & Isolation Plan

## Goals
- Deliver events to only the correct user
- Robust connections with reconnection and heartbeats

## Checklist
- [ ] __Connection Management__
  - [ ] WebSocket server with auth on connect
  - [ ] Map: user_id -> Set<socket>
  - [ ] Heartbeat ping/pong, close stale sockets
  - [ ] Backpressure handling and send queue
- [ ] __Publish API__
  - [ ] `publish(user_id, event)` isolates fanout to user
  - [ ] Drop if queue is full; metrics
- [ ] __SSE Fallback__
  - [ ] Keep-alive comments
  - [ ] Same isolation logic
- [ ] __Multi-Instance__
  - [ ] Sticky sessions (if needed) or broker (Redis Pub/Sub)
  - [ ] Channel: `user:{user_id}`
  - [ ] Health checks
- [ ] __Client Strategy__
  - [ ] Exponential backoff reconnect
  - [ ] Offline detection
  - [ ] Token refresh

## Metrics
- connected_sockets, messages_sent, dropped_messages, avg_latency_ms, auth_failures
