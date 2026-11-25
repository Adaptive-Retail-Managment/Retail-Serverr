import { ConfigModule } from '@nestjs/config';
import { Test, type TestingModule } from '@nestjs/testing';
import { validateEnv } from '../../src/config/env.validation';
import { DatabaseHealthService } from '../../src/database/database-health.service';
import { DatabaseModule } from '../../src/database/prisma.module';
import { PrismaService } from '../../src/database/prisma.service';

/**
 * Requires a running PostgreSQL instance (pnpm db:up). Run via
 * `pnpm test:integration`; CI provides the database as a service container.
 */
describe('Database integration', () => {
  let moduleRef: TestingModule;

  beforeAll(async () => {
    moduleRef = await Test.createTestingModule({
      imports: [
        ConfigModule.forRoot({
          isGlobal: true,
          envFilePath: ['.env', '../../.env'],
          validate: validateEnv,
        }),
        DatabaseModule,
      ],
    }).compile();
  });

  afterAll(async () => {
    await moduleRef.close();
  });

  it('connects and answers SELECT 1 through the readiness check', async () => {
    const health = moduleRef.get(DatabaseHealthService);

    const result = await health.check();

    expect(result.status).toBe('up');
  });

  it('executes a real query against the configured database', async () => {
    const prisma = moduleRef.get(PrismaService);

    const rows = await prisma.$queryRaw<
      Array<{ current_database: string }>
    >`SELECT current_database()`;

    expect(rows).toHaveLength(1);
    expect(rows[0]?.current_database).toBeTruthy();
  });
});
