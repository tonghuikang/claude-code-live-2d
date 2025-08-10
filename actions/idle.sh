#!/bin/bash

# Use SESSION_ID from environment, or 'default' if not set
SESSION_ID=${SESSION_ID:-default}

# Array of motions
MOTIONS=(
  '{"type":"motion","group":"Idle","index":0}' # Idle
  '{"type":"motion","group":"Idle","index":1}' # Idle
  '{"type":"motion","group":"Idle","index":2}' # Idle
)


# Select a random motion
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action with session_id
curl -X POST "https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action?session_id=$SESSION_ID" -H "Content-Type: application/json" -d "$RANDOM_MOTION" &
