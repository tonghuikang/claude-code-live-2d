# Shocked
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":2}'

# Angry
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":0}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":3}'
