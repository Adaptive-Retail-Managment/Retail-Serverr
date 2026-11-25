import { Controller, Get, Header, ServiceUnavailableException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import type { LivenessReport, ReadinessReport } from './health.types';
import { ReadinessService } from './readiness.service';

/**
 * Probe endpoints intentionally live outside the /api prefix so that
 * orchestrators can hit stable, unversioned paths.
 */
@Controller()
export class HealthController {
  constructor(
    private readonly readinessService: ReadinessService,
    private readonly config: ConfigService,
  ) {}

  @Get('health')
  @Header('Cache-Control', 'no-store')
  liveness(): LivenessReport {
    return {
      status: 'ok',
      service: 'api',
      version: this.config.get<string>('APP_VERSION') ?? '0.0.0',
      uptimeSeconds: Math.round(process.uptime()),
      timestamp: new Date().toISOString(),
    };
  }

  @Get('ready')
  @Header('Cache-Control', 'no-store')
  async readiness(): Promise<ReadinessReport> {
    const report = await this.readinessService.check();

    if (report.status !== 'ok') {
      throw new ServiceUnavailableException(report);
    }

    return report;
  }
}
