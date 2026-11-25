import type { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppModule } from '../../src/app.module';
import { DatabaseHealthService } from '../../src/database/database-health.service';

describe('Health endpoints (e2e)', () => {
  let app: INestApplication;
  const databaseHealth = { check: jest.fn() };

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({ imports: [AppModule] })
      .overrideProvider(DatabaseHealthService)
      .useValue(databaseHealth)
      .compile();

    app = moduleRef.createNestApplication();
    app.setGlobalPrefix('api', { exclude: ['health', 'ready'] });
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  it('GET /health returns liveness without touching the database', async () => {
    databaseHealth.check.mockReset();

    const response = await request(app.getHttpServer()).get('/health').expect(200);

    expect(response.body).toMatchObject({ status: 'ok', service: 'api' });
    expect(typeof response.body.uptimeSeconds).toBe('number');
    expect(databaseHealth.check).not.toHaveBeenCalled();
  });

  it('GET /ready returns 200 when the database is up', async () => {
    databaseHealth.check.mockResolvedValue({ status: 'up', latencyMs: 2 });

    const response = await request(app.getHttpServer()).get('/ready').expect(200);

    expect(response.body).toMatchObject({
      status: 'ok',
      checks: { database: { status: 'up', latencyMs: 2 } },
    });
  });

  it('GET /ready returns 503 when the database is down', async () => {
    databaseHealth.check.mockResolvedValue({ status: 'down', latencyMs: 3000 });

    const response = await request(app.getHttpServer()).get('/ready').expect(503);

    expect(response.body).toMatchObject({
      status: 'degraded',
      checks: { database: { status: 'down' } },
    });
  });

  it('keeps probe endpoints outside the /api prefix', async () => {
    await request(app.getHttpServer()).get('/api/health').expect(404);
  });
});
