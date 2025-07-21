# Shocked
# haru_m_07.motion3.json
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":2}'

# Angry
# haru_m_02.motion3.json
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":0}'
# haru_m_10.motion3.json
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":3}'

# Sad
# haru_m_09.motion3.json
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickLeft","index":0}'

# Thinking
# haru_m_05.motion3.json
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickRight","index":0}'

# Happy
# haru_normal_06.motion3.json (with sound)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Flick3","index":2}'
# haru_m_06.motion3.json
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":1}'
# haru_m_08.motion3.json
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Flick3","index":0}'

# Idle
# haru_idle_01.motion3.json
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Idle","index":0}'
# haru_idle_02.motion3.json
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Idle","index":1}'
# haru_idle_03.motion3.json
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Idle","index":2}'

# On complete (with sound)
# haru_normal_01.motion3.json (with sound)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Flick3","index":1}'
# haru_normal_09.motion3.json (with sound)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickLeft","index":1}'
# haru_normal_10.motion3.json (with sound)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickLeft","index":2}'

# Requesting permissions (with sound, soft)
# haru_normal_02.motion3.json (with sound)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":4}'
# haru_normal_05.motion3.json (with sound)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Tap","index":5}'
# haru_normal_04.motion3.json (with sound)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickRight","index":2}'

# Requesting permissions (with sound, loud)
# haru_normal_03.motion3.json (with sound)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"FlickRight","index":1}'
# haru_normal_07.motion3.json (with sound - too loud)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Shake","index":0}'
# haru_normal_08.motion3.json (with sound - too loud)
curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d '{"type":"motion","group":"Shake","index":1}'
