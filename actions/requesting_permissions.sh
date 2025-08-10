#!/bin/bash
# Requesting permissions (loud) - play a random attention-getting motion with sound

# Use SESSION_ID from environment, or 'default' if not set
SESSION_ID=${SESSION_ID:-default}

# Array of loud/attention-getting motions with specific indices
MOTIONS=(
  '{"type":"motion","group":"Tap","index":4}'
  '{"type":"motion","group":"Tap","index":5}'
  '{"type":"motion","group":"FlickRight","index":1}'
  '{"type":"motion","group":"FlickRight","index":2}'
)

# Select a random motion
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action with session_id
curl -X POST "https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action?session_id=$SESSION_ID" -H "Content-Type: application/json" -d "$RANDOM_MOTION" &
