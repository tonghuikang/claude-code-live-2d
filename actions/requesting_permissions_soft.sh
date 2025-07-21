#!/bin/bash
# Requesting permissions (soft) - play a random gentle motion with sound

# Array of soft/gentle motions with specific indices
MOTIONS=(
  '{"type":"motion","group":"Tap","index":4}'
  '{"type":"motion","group":"Tap","index":5}'
  '{"type":"motion","group":"FlickRight","index":2}'
)

# Select a random motion
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d "$RANDOM_MOTION"
