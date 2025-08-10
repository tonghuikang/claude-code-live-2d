#!/bin/bash
# Requesting permissions (loud) - play a random attention-getting motion with sound

# Array of loud/attention-getting motions with specific indices
MOTIONS=(
  '{"type":"motion","group":"Tap","index":4}'
  '{"type":"motion","group":"Tap","index":5}'
  '{"type":"motion","group":"FlickRight","index":1}'
  '{"type":"motion","group":"FlickRight","index":2}'
)

# Select a random motion
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action
curl -X POST https://tonghuikang--live2d-action-server-fastapi-app.modal.run/action -H "Content-Type: application/json" -d "$RANDOM_MOTION" &
