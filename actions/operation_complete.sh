#!/bin/bash
# Operation complete - play a random celebratory motion with sound

# Array of celebration/completion motions with specific indices
MOTIONS=(
  '{"type":"motion","group":"Flick3","index":1}'
  '{"type":"motion","group":"FlickLeft","index":1}'
  '{"type":"motion","group":"FlickLeft","index":2}'
)

# Select a random motion
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action
curl -X POST https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action -H "Content-Type: application/json" -d "$RANDOM_MOTION" &
