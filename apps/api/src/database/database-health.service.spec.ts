import type { ConfigService } from '@nestjs/config';
import { DatabaseHealthService } from './database-health.service';
import type { PrismaService } from './prisma.service';

function createConfig(timeoutMs = 3000): ConfigService {
  return { get: jest.fn().mockReturnValue(timeoutMs) } as unknown as ConfigService;
}

describe('DatabaseHealthService', () => {
  it('reports up with latency when the query succeeds', async () => {
    const prisma = {
      $queryRaw: jest.fn().mockResolvedValue([{ '?column?': 1 }]),
    } as unknown as PrismaService;

    const service = new DatabaseHealthService(prisma, createConfig());
    const result = await service.check();

    expect(result.status).toBe('up');
    expect(result.latencyMs).toBeGreaterThanOrEqual(0);
  });

  it('reports down without leaking error details when the query fails', async () => {
    const prisma = {
      $queryRaw: jest.fn().mockRejectedValue(new Error('password authentication failed')),
    } as unknown as PrismaService;

    const service = new DatabaseHealthService(prisma, createConfig());
    const result = await service.check();

    expect(result).toEqual({ status: 'down', latencyMs: expect.any(Number) });
  });

  it('reports down when the query exceeds the configured timeout', async () => {
    const prisma = {
      $queryRaw: jest.fn().mockReturnValue(new Promise(() => undefined)),
    } as unknown as PrismaService;

    const service = new DatabaseHealthService(prisma, createConfig(100));
    const result = await service.check();

    expect(result.status).toBe('down');
  });
});
