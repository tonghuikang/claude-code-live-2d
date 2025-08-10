#!/bin/bash
# Thinking - play thinking motion

# Use SESSION_ID from environment, or 'default' if not set
SESSION_ID=${SESSION_ID:-default}

# Array with the specific thinking motion
MOTIONS=(
  '{"type":"motion","group":"FlickRight","index":0}'
)

# Select a random motion (in this case, just one)
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action with session_id
curl -X POST "https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action?session_id=$SESSION_ID" -H "Content-Type: application/json" -d "$RANDOM_MOTION" &