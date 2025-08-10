# CLAUDE.md - AI Assistant Guide for Live2D Claude Code Voice Notifying Companion

## Project Overview

This is a Live2D Cubism SDK TypeScript implementation enhanced with a voice notification system that creates a visual companion for Claude Code. The Live2D character responds to various Claude Code actions through a sophisticated hook system, providing visual feedback during AI-assisted coding sessions.

**Key Purpose**: A reactive Live2D character that displays emotions and animations based on Claude Code operations (thinking, completing tasks, requesting permissions, etc.) via HTTP action queue system deployed on Modal.

## Architecture & Key Components

### System Architecture
```
Claude Code → Hooks (.claude/settings.json) → Bash Scripts (/actions/*.sh) 
    ↓
Modal Server (FastAPI) ← Polling (100ms) ← Live2D Frontend (localhost:5001)
```

### Core Components
- **Frontend Application**: Live2D character rendered at `http://localhost:5001` using Vite dev server
- **Action Server**: Modal-deployed FastAPI server at `https://tonghuikang--live2d-action-server-fastapi-app.modal.run`
- **Action Client**: TypeScript client polling server every 100ms for new actions
- **Hook Integration**: Claude Code hooks trigger bash scripts that POST actions to the server
- **Live2D Manager**: Processes queued actions and controls character animations

## Development Workflow

### Starting the System
```bash
# 1. Build the demo (from Samples/TypeScript/Demo)
npm install
npm run build

# 2. Start the preview server
npm run serve

# 3. Open browser to http://localhost:5001
```

### Testing Actions
```bash
# Test individual motions
./actions/thinking.sh    # Thinking animation
./actions/happy.sh        # Happy animation
./actions/idle.sh         # Return to idle
./actions/operation_complete.sh  # Completion animation with sound

# Test all available motions
./actions/all.sh         # Contains all motion mappings with comments
```

### Deployment
- Modal server is already deployed and accessible
- To redeploy: `modal deploy Samples/backend/modal_server.py`
- For local testing: `modal serve Samples/backend/modal_server.py`

## Coding Conventions

### TypeScript Standards
- **Strict Mode**: `noImplicitAny: true` enforced
- **Class Naming**: PascalCase (e.g., `LAppDelegate`, `ActionClient`, `LAppModel`)
- **Method Naming**: camelCase (e.g., `startPolling`, `fetchActions`)
- **Private Members**: Underscore prefix (e.g., `_model`, `_subdelegates`, `_actionQueue`)
- **Constants**: UPPER_SNAKE_CASE for global constants
- **Type Prefixes**: `csm` for Cubism types (e.g., `csmVector<T>`)

### File Organization
- **Framework Imports**: Use `@framework/` alias for framework imports
- **Indentation**: 2 spaces consistently throughout
- **Line Length**: No strict limit but maintain readability
- **Semicolons**: Required and consistently used

### Code Patterns
- **Singleton Pattern**: Used for managers (`LAppDelegate.getInstance()`)
- **State Enums**: For tracking load states and transitions
- **Promise-based Async**: For all network operations

## Critical Files & Their Purposes

### Core Application Files
- `src/actionclient.ts`: Polls Modal server for actions, processes queue (100ms interval)
- `src/lappdelegate.ts`: Main application singleton, manages initialization and event handling
- `src/lapplive2dmanager.ts`: Manages Live2D models, handles motion and expression changes
- `src/lappmodel.ts`: Individual model instance, controls animations and expressions
- `src/main.ts`: Entry point, initializes Cubism framework

### Configuration Files
- `.claude/settings.json`: Hook configurations for Claude Code integration
- `Samples/TypeScript/Demo/package.json`: Build and serve scripts
- `Samples/backend/modal_server.py`: Modal-deployed action queue server
- `Samples/backend/requirements.txt`: Python dependencies for Modal server

### Action Scripts
- `/actions/thinking.sh`: Triggers thinking animation (FlickRight group)
- `/actions/happy.sh`: Random happy motion from array
- `/actions/idle.sh`: Return to idle state
- `/actions/operation_complete.sh`: Completion with sound
- `/actions/requesting_permissions.sh`: Soft request animation
- `/actions/all.sh`: Complete motion reference with comments

## API & Integration Points

### Modal Server Endpoints
- **Base URL**: `https://tonghuikang--live2d-action-server-fastapi-app.modal.run`
- `POST /action`: Add action to queue
- `GET /actions`: Retrieve and clear queue
- `GET /status`: Check queue status

### Action Types
```typescript
interface Action {
  type: 'motion' | 'expression' | 'tap';
  group?: string;    // Motion group name
  index?: number;    // Specific motion index
  name?: string;     // Expression name
  x?: number;        // Tap coordinates (0-1)
  y?: number;        // Tap coordinates (0-1)
}
```

### Motion Groups (Haru2 Model)
- **Idle**: Default idle animations (3 variations)
- **Tap**: Body tap reactions (indices 0-5)
- **FlickLeft**: Left flick motions
- **FlickRight**: Right flick motions  
- **Flick3**: Additional flick variations
- **Shake**: Shake motions with sound

### Claude Code Hook Events
- **PreToolUse**: Before tool execution (triggers thinking animation)
- **PostToolUse**: After tool completion (triggers happy animation)
- **Notification**: On notifications (triggers request animation)
- **Stop**: On stop/completion (triggers completion animation)

## Available Motions & Emotions

### Emotion Mappings
| Emotion | Motion Group | Index | File | Sound |
|---------|-------------|-------|------|-------|
| Thinking | FlickRight | 0 | haru_m_05.motion3.json | No |
| Happy | Flick3 | 2 | haru_normal_06.motion3.json | Yes |
| Happy | Tap | 1 | haru_m_06.motion3.json | No |
| Happy | Flick3 | 0 | haru_m_08.motion3.json | No |
| Shocked | Tap | 2 | haru_m_07.motion3.json | No |
| Angry | Tap | 0 | haru_m_02.motion3.json | No |
| Sad | FlickLeft | 0 | haru_m_09.motion3.json | No |
| Idle | Idle | 0-2 | haru_idle_01-03.motion3.json | No |
| Complete | Flick3 | 1 | haru_normal_01.motion3.json | Yes |
| Request | Tap | 4-5 | haru_normal_02/05.motion3.json | Yes |

## Important Notes & Gotchas

### Critical Considerations
1. **Server URL Hardcoded**: Modal server URL is hardcoded in `actionclient.ts` and all bash scripts
2. **Polling Interval**: 100ms polling can be aggressive - increase if performance issues
3. **Motion Indices**: Indices are specific to Haru2 model - will break with different models
4. **CORS Enabled**: Modal server has wildcard CORS - consider restricting in production
5. **Queue Behavior**: Actions are cleared on retrieval - no persistence between fetches
6. **Cold Starts**: Modal server may have cold start delays - keep_warm=1 helps
7. **Sound Files**: Some motions have associated .wav files that play automatically

### Common Issues
- **No Character Response**: Check Modal server status, verify URL accessibility
- **Wrong Animations**: Motion indices may not match if using different model
- **Performance**: Reduce polling interval if browser becomes sluggish
- **Build Failures**: Ensure Core directory has live2dcubismcore.js files

## Testing & Debugging

### Debug Commands
```bash
# Check Modal server status
curl https://tonghuikang--live2d-action-server-fastapi-app.modal.run/status

# Send test action directly
curl -X POST https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action \
  -H "Content-Type: application/json" \
  -d '{"type":"motion","group":"Idle","index":0}'

# Monitor browser console for ActionClient logs
# Look for: [ActionClient] Retrieved X actions
```

### Testing Tools
- `test-client.js`: Rapid action testing script
- Browser DevTools: Monitor network requests and console logs
- Modal Dashboard: View server logs and metrics
- `/actions/all.sh`: Reference for all available motions

## Common Tasks

### Add New Motion Trigger
```bash
# 1. Find motion in /actions/all.sh
# 2. Create new script in /actions/
#!/bin/bash
curl -X POST https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action \
  -H "Content-Type: application/json" \
  -d '{"type":"motion","group":"YOUR_GROUP","index":YOUR_INDEX}'
```

### Change Polling Interval
```typescript
// In src/actionclient.ts, line 18
constructor(serverUrl: string = '...', pollInterval: number = 100) {
  // Change 100 to desired milliseconds
}
```

### Switch Character Model
1. Update model resources in `/Samples/Resources/`
2. Modify model loading in `lapplive2dmanager.ts`
3. Update motion group/index mappings in action scripts

### Add New Hook
```json
// In .claude/settings.json
"YourHookName": [{
  "hooks": [{
    "type": "command",
    "command": "actions/your_action.sh"
  }]
}]
```

### Deploy Changes to Modal
```bash
# From project root
modal deploy Samples/backend/modal_server.py

# For local testing
modal serve Samples/backend/modal_server.py
```

## Quick Reference

### Essential Commands
```bash
npm run build      # Build the demo
npm run serve      # Start preview server (port 5000)
npm run lint       # Run linter
npm run clean      # Clean build artifacts
```

### Key URLs
- Frontend: `http://localhost:5001`
- Preview Server: `http://localhost:5000`  
- Modal Server: `https://tonghuikang--live2d-action-server-fastapi-app.modal.run`
- Modal Status: `https://tonghuikang--live2d-action-server-fastapi-app.modal.run/status`

### Project Structure
```
/
├── .claude/settings.json    # Claude Code hooks configuration
├── actions/                 # Bash scripts for triggering animations
├── Core/                    # Live2D Cubism Core (must be populated)
├── Framework/               # Cubism Framework source
├── Samples/
│   ├── Resources/          # Live2D models and assets
│   ├── TypeScript/Demo/    # Main application
│   │   ├── src/           # TypeScript source files
│   │   ├── public/        # Built assets
│   │   └── package.json   # Build configuration
│   └── backend/           # Modal server backend
│       ├── modal_server.py    # Modal deployment script
│       └── requirements.txt   # Python dependencies
```

## Additional Context

This project combines Live2D's powerful animation system with Claude Code's hook system to create an engaging visual companion. The character's reactions are designed to provide non-intrusive feedback about AI operations, making the coding experience more interactive and enjoyable.

The Modal server acts as a message queue, decoupling the Claude Code hooks from the Live2D frontend, ensuring smooth animations without blocking AI operations. The 100ms polling ensures near-instant visual feedback while maintaining reasonable resource usage.

For any modifications, always test locally first using the action scripts before integrating with Claude Code hooks. The `/actions/all.sh` file serves as the definitive reference for all available motions and their emotional mappings.