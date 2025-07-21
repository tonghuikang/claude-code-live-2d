#!/bin/bash
# Random motion - play a random shocked or angry motion

# Array of motions (shocked and angry)
MOTIONS=(
  '{"type":"motion","group":"Tap","index":2}'  # Shocked
  '{"type":"motion","group":"Tap","index":0}'  # Angry
  '{"type":"motion","group":"Tap","index":3}'  # Angry
)

# Select a random motion
RANDOM_MOTION=${MOTIONS[$RANDOM % ${#MOTIONS[@]}]}

# Send the action
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d "$RANDOM_MOTION"
