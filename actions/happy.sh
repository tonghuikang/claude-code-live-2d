#!/bin/bash
# Random motion - play a random shocked or angry motion

# Use SESSION_ID from environment, or 'default' if not set
SESSION_ID=${SESSION_ID:-default}

# Array of motions (shocked and angry)
MOTIONS=(
  '{"type":"motion","group":"Flick3","index":2}'
  '{"type":"motion","group":"Tap","index":1}'
  '{"type":"motion","group":"Flick3","index":0}'
)

# Select a random motion
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action with session_id
curl -X POST "https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action?session_id=$SESSION_ID" -H "Content-Type: application/json" -d "$RANDOM_MOTION" &
