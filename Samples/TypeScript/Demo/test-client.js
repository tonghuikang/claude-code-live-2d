const http = require('http');

function sendAction(action) {
  const data = JSON.stringify(action);
  
  const options = {
    hostname: 'localhost',
    port: 3000,
    path: '/action',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': data.length
    }
  };

  const req = http.request(options, (res) => {
    let body = '';
    res.on('data', (chunk) => {
      body += chunk;
    });
    res.on('end', () => {
      console.log('Response:', body);
    });
  });

  req.on('error', (error) => {
    console.error('Error:', error);
  });

  req.write(data);
  req.end();
}

// Example usage
console.log('Sending test actions to the server...\n');

// Test different types of actions
setTimeout(() => {
  console.log('1. Sending tap body motion...');
  sendAction({ type: 'motion', group: 'TapBody' });
}, 1000);

setTimeout(() => {
  console.log('2. Sending expression change...');
  sendAction({ type: 'expression', name: 'F01' });
}, 3000);

setTimeout(() => {
  console.log('3. Sending tap action...');
  sendAction({ type: 'tap', x: 0.5, y: 0.5 });
}, 5000);

setTimeout(() => {
  console.log('4. Sending idle motion...');
  sendAction({ type: 'motion', group: 'Idle' });
}, 7000);

console.log('\nYou can also manually send actions using curl:');
console.log('curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d \'{"type":"motion","group":"TapBody"}\'');
console.log('curl -X POST http://localhost:3000/action -H "Content-Type: application/json" -d \'{"type":"expression","name":"F01"}\'');
console.log('curl -X GET http://localhost:3000/status');