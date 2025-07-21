#!/bin/bash
# Thinking - play thinking motion

# Array with the specific thinking motion
MOTIONS=(
  '{"type":"motion","group":"FlickRight","index":0}'
)

# Select a random motion (in this case, just one)
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d "$RANDOM_MOTION" &