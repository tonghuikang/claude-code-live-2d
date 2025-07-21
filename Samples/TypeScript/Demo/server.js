const { createServer } = require('http');
const { parse } = require('url');

class ActionQueue {
  constructor() {
    this.queue = [];
  }

  add(action) {
    this.queue.push(action);
    console.log(`[ActionQueue] Added action: ${JSON.stringify(action)}`);
  }

  getAll() {
    const actions = [...this.queue];
    this.queue = [];
    return actions;
  }

  size() {
    return this.queue.length;
  }
}

const actionQueue = new ActionQueue();
const PORT = 3000;

const server = createServer((req, res) => {
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'OPTIONS, POST, GET',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Content-Type': 'application/json'
  };

  if (req.method === 'OPTIONS') {
    res.writeHead(204, headers);
    res.end();
    return;
  }

  const { pathname } = parse(req.url || '');

  if (req.method === 'POST' && pathname === '/action') {
    let body = '';
    req.on('data', chunk => {
      body += chunk.toString();
    });
    req.on('end', () => {
      try {
        const action = JSON.parse(body);
        action.id = Math.random().toString(36).substr(2, 9);
        action.timestamp = Date.now();
        actionQueue.add(action);
        
        res.writeHead(200, headers);
        res.end(JSON.stringify({ success: true, actionId: action.id }));
      } catch (error) {
        res.writeHead(400, headers);
        res.end(JSON.stringify({ error: 'Invalid JSON' }));
      }
    });
  } else if (req.method === 'GET' && pathname === '/actions') {
    const actions = actionQueue.getAll();
    res.writeHead(200, headers);
    res.end(JSON.stringify({ actions }));
  } else if (req.method === 'GET' && pathname === '/status') {
    res.writeHead(200, headers);
    res.end(JSON.stringify({ 
      queueSize: actionQueue.size(),
      timestamp: Date.now()
    }));
  } else {
    res.writeHead(404, headers);
    res.end(JSON.stringify({ error: 'Not found' }));
  }
});

server.listen(PORT, () => {
  console.log(`Action server running at http://localhost:${PORT}`);
  console.log('Available endpoints:');
  console.log('  POST /action - Add an action to the queue');
  console.log('  GET /actions - Get all queued actions (and clear queue)');
  console.log('  GET /status - Get queue status');
  console.log('\nExample actions:');
  console.log('  Motion: { "type": "motion", "group": "TapBody" }');
  console.log('  Expression: { "type": "expression", "name": "F01" }');
  console.log('  Tap: { "type": "tap", "x": 0.5, "y": 0.5 }');
});