import { validateEnv } from './env.validation';

const validDatabaseUrl = 'postgresql://arp:secret@localhost:5432/adaptive_retail?schema=public';

describe('validateEnv', () => {
  it('applies safe development defaults', () => {
    const env = validateEnv({ DATABASE_URL: validDatabaseUrl });

    expect(env.NODE_ENV).toBe('development');
    expect(env.PORT).toBe(4000);
    expect(env.READINESS_TIMEOUT_MS).toBe(3000);
    expect(env.CORS_ORIGINS).toEqual(['http://localhost:5173']);
  });

  it('coerces numeric values and splits comma-separated origins', () => {
    const env = validateEnv({
      DATABASE_URL: validDatabaseUrl,
      PORT: '4100',
      READINESS_TIMEOUT_MS: '1500',
      CORS_ORIGINS: 'http://localhost:5173, https://admin.example.com',
      APP_VERSION: '1.2.3',
    });

    expect(env.PORT).toBe(4100);
    expect(env.READINESS_TIMEOUT_MS).toBe(1500);
    expect(env.CORS_ORIGINS).toEqual(['http://localhost:5173', 'https://admin.example.com']);
    expect(env.APP_VERSION).toBe('1.2.3');
  });

  it('rejects a missing DATABASE_URL', () => {
    expect(() => validateEnv({})).toThrow(/DATABASE_URL/);
  });

  it('rejects a non-PostgreSQL DATABASE_URL', () => {
    expect(() => validateEnv({ DATABASE_URL: 'mysql://localhost/db' })).toThrow(
      /PostgreSQL connection string/,
    );
  });

  it('rejects an out-of-range port', () => {
    expect(() => validateEnv({ DATABASE_URL: validDatabaseUrl, PORT: '70000' })).toThrow(/PORT/);
  });

  it('rejects invalid CORS origins', () => {
    expect(() =>
      validateEnv({ DATABASE_URL: validDatabaseUrl, CORS_ORIGINS: 'not-a-url' }),
    ).toThrow(/CORS_ORIGINS/);
  });
});
