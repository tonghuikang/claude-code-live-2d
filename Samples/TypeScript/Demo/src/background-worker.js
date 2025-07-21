// Web Worker to maintain timing in background tabs
let intervalId = null;

self.addEventListener('message', (e) => {
  if (e.data.command === 'start') {
    if (intervalId) {
      clearInterval(intervalId);
    }
    
    // Send tick messages at 60 FPS (approximately 16.67ms)
    intervalId = setInterval(() => {
      self.postMessage({ type: 'tick' });
    }, 16.67);
  } else if (e.data.command === 'stop') {
    if (intervalId) {
      clearInterval(intervalId);
      intervalId = null;
    }
  }
});