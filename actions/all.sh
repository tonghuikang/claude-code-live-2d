# Shocked
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":2}'

# Angry
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":0}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":3}'

# Thinking
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickRight","index":0}'

# Happy (the first has sound)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Flick3","index":2}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":1}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Flick3","index":0}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickLeft","index":0}'

# Idle
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Idle","index":0}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Idle","index":1}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Idle","index":2}'

# On complete (with sound)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Flick3","index":1}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickLeft","index":1}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickLeft","index":2}'

# Requesting permissions (with sound, soft)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":4}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":5}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickRight","index":2}'

# Requesting permissions (with sound, loud)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickRight","index":1}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Shake","index":0}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Shake","index":1}'
