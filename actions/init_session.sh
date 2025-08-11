#!/bin/bash

# If file doesn't exist, generate session ID and write it
if [ ! -f /tmp/claude_session_id ]; then
    SESSION_ID="session-$(date +%s)-$(openssl rand -hex 4)"
    echo "SESSION_ID=\"$SESSION_ID\"" > /tmp/claude_session_id
fi

# Read the session ID from the file
source /tmp/claude_session_id

# Display the URL with session ID to the user
echo " "
echo "Visit your companion at: https://claude-code-live-2d.vercel.app/?session_id=$SESSION_ID"
echo "Your companion will react to Claude Code actions during this session."
echo " "
