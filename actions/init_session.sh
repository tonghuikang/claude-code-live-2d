#!/bin/bash

# Generate a unique session ID using timestamp + random string
SESSION_ID="session-$(date +%s)-$(openssl rand -hex 4)"

# Export the session ID for use by other scripts
export SESSION_ID="$SESSION_ID"
echo "export SESSION_ID=\"$SESSION_ID\"" > /tmp/claude_session_id

# Display the URL with session ID to the user
echo "🎭 Live2D Claude Companion is ready!"
echo "📱 Open your companion at: http://localhost:5001?session_id=$SESSION_ID"
echo "🆔 Session ID: $SESSION_ID"
echo ""
echo "Your Live2D character will react to Claude Code actions during this session."