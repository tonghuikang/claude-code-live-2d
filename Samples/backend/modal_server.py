import modal
from typing import List, Dict, Any
import time
import random
import string
import json
from fastapi import FastAPI, Response
from fastapi.middleware.cors import CORSMiddleware

app = modal.App("live2d-action-server")

# Create a Modal Volume to persist the action queue
volume = modal.Volume.from_name("live2d-actions", create_if_missing=True)

# Create the image with required dependencies
image = modal.Image.debian_slim().pip_install("fastapi[standard]")

# Action queue stored in memory (will reset on cold starts)
# For persistence across invocations, you'd need to use Modal's storage
action_queue = []

def generate_id():
    """Generate a random ID for actions"""
    return ''.join(random.choices(string.ascii_lowercase + string.digits, k=9))

@app.function(
    image=image,
    volumes={"/data": volume},
    min_containers=1,  # Keep one instance warm to reduce cold starts
    max_containers=1,  # Because the queue is kept in memory
)
@modal.asgi_app()
def fastapi_app():
    web_app = FastAPI()
    
    # Add CORS middleware
    web_app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
    
    @web_app.post("/action")
    async def add_action(action: Dict[str, Any]):
        """Add an action to the queue"""
        action["id"] = generate_id()
        action["timestamp"] = int(time.time() * 1000)
        action_queue.append(action)
        
        print(f"[ActionQueue] Added action: {json.dumps(action)}")
        
        return {"success": True, "actionId": action["id"]}
    
    @web_app.get("/actions")
    async def get_actions():
        """Get all queued actions and clear the queue"""
        global action_queue
        actions = action_queue.copy()
        action_queue = []
        return {"actions": actions}
    
    @web_app.get("/status")
    async def get_status():
        """Get queue status"""
        return {
            "queueSize": len(action_queue),
            "timestamp": int(time.time() * 1000)
        }
    
    @web_app.get("/")
    async def root():
        """Root endpoint with API info"""
        return {
            "service": "Live2D Action Server",
            "endpoints": {
                "POST /action": "Add an action to the queue",
                "GET /actions": "Get all queued actions (and clear queue)",
                "GET /status": "Get queue status"
            },
            "examples": {
                "motion": {"type": "motion", "group": "TapBody"},
                "expression": {"type": "expression", "name": "F01"},
                "tap": {"type": "tap", "x": 0.5, "y": 0.5}
            }
        }
    
    return web_app

# For local testing with modal serve
@app.local_entrypoint()
def main():
    print("To deploy this app, run: modal deploy modal_server.py")
    print("To serve locally for testing, run: modal serve modal_server.py")