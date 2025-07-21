# Requesting permissions (with sound, soft)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":4}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":5}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickRight","index":2}'
