import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { DatabaseHealthService } from '../database/database-health.service';
import type { ReadinessReport } from './health.types';

@Injectable()
export class ReadinessService {
  constructor(
    private readonly databaseHealth: DatabaseHealthService,
    private readonly config: ConfigService,
  ) {}

  async check(): Promise<ReadinessReport> {
    const database = await this.databaseHealth.check();

    return {
      status: database.status === 'up' ? 'ok' : 'degraded',
      service: 'api',
      version: this.config.get<string>('APP_VERSION') ?? '0.0.0',
      uptimeSeconds: Math.round(process.uptime()),
      timestamp: new Date().toISOString(),
      checks: { database },
    };
  }
}
