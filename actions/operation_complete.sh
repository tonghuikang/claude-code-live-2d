# On complete (with sound)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Flick3","index":1}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickLeft","index":1}'
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickLeft","index":2}'
