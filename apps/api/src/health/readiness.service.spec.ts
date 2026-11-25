import type { ConfigService } from '@nestjs/config';
import type { DatabaseHealthService } from '../database/database-health.service';
import { ReadinessService } from './readiness.service';

function createConfig(): ConfigService {
  return {
    get: jest.fn((key: string) => (key === 'APP_VERSION' ? '1.0.0-test' : undefined)),
  } as unknown as ConfigService;
}

describe('ReadinessService', () => {
  it('reports ok when the database is reachable', async () => {
    const databaseHealth = {
      check: jest.fn().mockResolvedValue({ status: 'up', latencyMs: 4 }),
    } as unknown as DatabaseHealthService;

    const report = await new ReadinessService(databaseHealth, createConfig()).check();

    expect(report.status).toBe('ok');
    expect(report.version).toBe('1.0.0-test');
    expect(report.checks.database).toEqual({ status: 'up', latencyMs: 4 });
  });

  it('reports degraded when the database is unreachable', async () => {
    const databaseHealth = {
      check: jest.fn().mockResolvedValue({ status: 'down', latencyMs: 3000 }),
    } as unknown as DatabaseHealthService;

    const report = await new ReadinessService(databaseHealth, createConfig()).check();

    expect(report.status).toBe('degraded');
    expect(report.checks.database.status).toBe('down');
  });
});
