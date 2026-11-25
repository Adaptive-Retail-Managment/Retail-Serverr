// Deterministic defaults for tests. Real values from the shell/CI always win.
process.env.NODE_ENV = process.env.NODE_ENV ?? 'test';
process.env.DATABASE_URL =
  process.env.DATABASE_URL ??
  'postgresql://arp:arp_dev_password@localhost:5432/adaptive_retail?schema=public';
process.env.CORS_ORIGINS = process.env.CORS_ORIGINS ?? 'http://localhost:5173';
process.env.APP_VERSION = process.env.APP_VERSION ?? 'test';
process.env.READINESS_TIMEOUT_MS = process.env.READINESS_TIMEOUT_MS ?? '3000';
