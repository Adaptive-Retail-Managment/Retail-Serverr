export type ReadinessStatus = 'ok' | 'degraded';

export interface LivenessReport {
  status: 'ok';
  service: 'api';
  version: string;
  uptimeSeconds: number;
  timestamp: string;
}

export interface ReadinessReport {
  status: ReadinessStatus;
  service: 'api';
  version: string;
  uptimeSeconds: number;
  timestamp: string;
  checks: {
    database: {
      status: 'up' | 'down';
      latencyMs: number;
    };
  };
}
