#!/bin/bash

# Array of motions
MOTIONS=(
  '{"type":"motion","group":"Idle","index":0}' # Idle
  '{"type":"motion","group":"Idle","index":1}' # Idle
  '{"type":"motion","group":"Idle","index":2}' # Idle
)


# Select a random motion
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action
curl -X POST https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action -H "Content-Type: application/json" -d "$RANDOM_MOTION" &
