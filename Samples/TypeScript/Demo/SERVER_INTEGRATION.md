# Live2D Server Integration

This demo has been enhanced with a server that can receive actions via HTTP and queue them for the Live2D character to perform.

## Architecture

1. **Action Server** - Now deployed on Modal at:
   - https://tonghuikang--live2d-action-server-fastapi-app.modal.run
   - Accepts POST requests to queue actions
   - Provides GET endpoint to retrieve queued actions
   - Local proxy available via `server.js` on port 3000

2. **Action Client** (`src/actionclient.ts`) - A TypeScript client that:
   - Polls the server every 500ms for new actions
   - Passes actions to the Live2D manager for execution

3. **Live2D Manager** - Modified to:
   - Process actions from the server queue
   - Execute motions, expressions, and tap events

## Starting the System

1. Start the action server:
   ```bash
   node server.js
   ```

2. In another terminal, ensure the demo is built and running:
   ```bash
   npm run build
   npm run serve
   ```

3. Open http://localhost:5001 in your browser

## Sending Actions

### Using curl:

```bash
# Trigger a body tap motion
curl -X POST https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action \
  -H "Content-Type: application/json" \
  -d '{"type":"motion","group":"TapBody"}'

# Change expression
curl -X POST https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action \
  -H "Content-Type: application/json" \
  -d '{"type":"expression","name":"F01"}'

# Simulate a tap
curl -X POST https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action \
  -H "Content-Type: application/json" \
  -d '{"type":"tap","x":0.5,"y":0.5}'

# Trigger idle motion
curl -X POST https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action \
  -H "Content-Type: application/json" \
  -d '{"type":"motion","group":"Idle"}'
```

### Using the test client:

```bash
node test-client.js
```

## Action Types

1. **Motion Actions**
   ```json
   {
     "type": "motion",
     "group": "TapBody",  // or "Idle"
     "index": 0  // optional, specific motion index
   }
   ```

2. **Expression Actions**
   ```json
   {
     "type": "expression",
     "name": "F01"  // expression name, or omit for random
   }
   ```

3. **Tap Actions**
   ```json
   {
     "type": "tap",
     "x": 0.5,  // normalized coordinates
     "y": 0.5
   }
   ```

## API Endpoints

- `POST /action` - Add an action to the queue
- `GET /actions` - Retrieve all queued actions (clears queue)
- `GET /status` - Check queue status

## Notes

- The client polls the server every 500ms
- Actions are processed in the order they are received
- The queue is cleared each time actions are retrieved
- Multiple actions can be queued and will be executed sequentially