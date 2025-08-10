#!/bin/bash
# Random motion - play a random shocked or angry motion

# Array of motions (shocked and angry)
MOTIONS=(
  '{"type":"motion","group":"Flick3","index":2}'
  '{"type":"motion","group":"Tap","index":1}'
  '{"type":"motion","group":"Flick3","index":0}'
)

# Select a random motion
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action
curl -X POST https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action -H "Content-Type: application/json" -d "$RANDOM_MOTION" &
