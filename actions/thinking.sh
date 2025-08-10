#!/bin/bash
# Thinking - play thinking motion

# Source the session ID from the temp file
if [ -f /tmp/claude_session_id ]; then
  source /tmp/claude_session_id
else
  echo "Error: Session ID file not found at /tmp/claude_session_id" >&2
  echo "Please run init_session.sh first to initialize the session." >&2
  exit 1
fi

# Array with the specific thinking motion
MOTIONS=(
  '{"type":"motion","group":"FlickRight","index":0}'
)

# Select a random motion (in this case, just one)
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action with session_id
curl -X POST "https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action?session_id=$SESSION_ID" -H "Content-Type: application/json" -d "$RANDOM_MOTION" &