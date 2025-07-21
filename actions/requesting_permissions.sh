#!/bin/bash
# Requesting permissions (loud) - play a random attention-getting motion with sound

# Array of loud/attention-getting motions with specific indices
MOTIONS=(
  '{"type":"motion","group":"FlickRight","index":1}'
  '{"type":"motion","group":"Shake","index":0}'
  '{"type":"motion","group":"Shake","index":1}'
  '{"type":"motion","group":"Tap","index":4}'
  '{"type":"motion","group":"Tap","index":5}'
  '{"type":"motion","group":"FlickRight","index":2}'
)

# Select a random motion
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d "$RANDOM_MOTION" &
