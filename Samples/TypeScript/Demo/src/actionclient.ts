export interface Action {
  id: string;
  type: 'motion' | 'expression' | 'tap';
  group?: string;
  index?: number;
  name?: string;
  x?: number;
  y?: number;
  timestamp: number;
}

export class ActionClient {
  private serverUrl: string;
  private pollInterval: number;
  private intervalId: number | null = null;
  private onAction: (action: Action) => void;

  constructor(serverUrl: string = 'https://tonghuikang--live2d-action-server-fastapi-app.modal.run', pollInterval: number = 100) {
    this.serverUrl = serverUrl;
    this.pollInterval = pollInterval;
  }

  public startPolling(onAction: (action: Action) => void): void {
    this.onAction = onAction;
    
    if (this.intervalId !== null) {
      this.stopPolling();
    }

    this.intervalId = window.setInterval(() => {
      this.fetchActions();
    }, this.pollInterval);

    // Fetch immediately
    this.fetchActions();
  }

  public stopPolling(): void {
    if (this.intervalId !== null) {
      window.clearInterval(this.intervalId);
      this.intervalId = null;
    }
  }

  private async fetchActions(): Promise<void> {
    try {
      const response = await fetch(`${this.serverUrl}/actions`);
      if (!response.ok) {
        console.error('[ActionClient] Failed to fetch actions:', response.statusText);
        return;
      }

      const data = await response.json();
      const actions = data.actions as Action[];

      if (actions && actions.length > 0) {
        console.log(`[ActionClient] Retrieved ${actions.length} actions`);
        actions.forEach(action => {
          try {
            this.onAction(action);
          } catch (error) {
            console.error('[ActionClient] Error processing action:', error);
          }
        });
      }
    } catch (error) {
      console.error('[ActionClient] Error fetching actions:', error);
    }
  }

  public async sendAction(action: Omit<Action, 'id' | 'timestamp'>): Promise<string | null> {
    try {
      const response = await fetch(`${this.serverUrl}/action`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(action),
      });

      if (!response.ok) {
        console.error('[ActionClient] Failed to send action:', response.statusText);
        return null;
      }

      const data = await response.json();
      return data.actionId;
    } catch (error) {
      console.error('[ActionClient] Error sending action:', error);
      return null;
    }
  }
}
