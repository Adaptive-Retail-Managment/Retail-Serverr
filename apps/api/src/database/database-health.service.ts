import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PrismaService } from './prisma.service';

export interface DatabaseHealth {
  status: 'up' | 'down';
  latencyMs: number;
}

@Injectable()
export class DatabaseHealthService {
  private readonly logger = new Logger(DatabaseHealthService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly config: ConfigService,
  ) {}

  async check(): Promise<DatabaseHealth> {
    const timeoutMs = this.config.get<number>('READINESS_TIMEOUT_MS') ?? 3000;
    const startedAt = Date.now();

    try {
      await this.withTimeout(this.prisma.$queryRaw`SELECT 1`, timeoutMs);
      return { status: 'up', latencyMs: Date.now() - startedAt };
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Unknown database error';
      // Details stay in server logs; probes receive only a status.
      this.logger.warn(`Database readiness check failed: ${message}`);
      return { status: 'down', latencyMs: Date.now() - startedAt };
    }
  }

  private withTimeout<T>(operation: Promise<T>, timeoutMs: number): Promise<T> {
    return new Promise<T>((resolve, reject) => {
      const timer = setTimeout(() => {
        reject(new Error(`Database check timed out after ${timeoutMs}ms`));
      }, timeoutMs);

      operation.then(
        (value) => {
          clearTimeout(timer);
          resolve(value);
        },
        (error: unknown) => {
          clearTimeout(timer);
          reject(error);
        },
      );
    });
  }
}
