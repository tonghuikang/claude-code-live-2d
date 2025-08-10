#!/bin/bash

# Generate a unique session ID using timestamp + random string
SESSION_ID="session-$(date +%s)-$(openssl rand -hex 4)"

# Export the session ID for use by other scripts
export SESSION_ID="$SESSION_ID"

# Only write to /tmp/claude_session_id if SESSION_ID doesn't already exist there
if [ ! -f /tmp/claude_session_id ] || ! grep -q "SESSION_ID=" /tmp/claude_session_id; then
    echo "export SESSION_ID=\"$SESSION_ID\"" > /tmp/claude_session_id
fi

# Display the URL with session ID to the user
echo " "
echo "Visit your companion at: https://claude-code-live-2d.vercel.app/?session_id=$SESSION_ID"
echo "Your companion will react to Claude Code actions during this session."
echo " "
