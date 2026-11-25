# Local development

## Prerequisites

- Node.js >= 22.12 (Node 24 works)
- pnpm 11.28.13 via corepack: `corepack enable` (may require elevated shell on Windows) or prefix
  commands with `corepack pnpm`
- Docker Desktop / Docker Engine with Compose v2

## First run

```bash
cp .env.example .env
pnpm install
pnpm db:up
pnpm prisma:generate
pnpm dev
```

- API: http://localhost:4000 — `GET /health`, `GET /ready`
- Web: http://localhost:5173
- PostgreSQL: `localhost:5432`, database/user `adaptive_retail`/`arp` by default

`pnpm dev` runs the API and web in parallel. The desktop shell is separate:
`pnpm dev:desktop` (loads http://localhost:5173, so the web dev server must be running).

## Database lifecycle

```bash
pnpm db:up                       # start PostgreSQL and wait for healthy
pnpm db:logs                     # follow logs
pnpm db:down                     # stop the container, keep data
docker compose -f infra/docker/compose.dev.yml down -v   # destructive: drops the volume
```

There are no migrations yet. When the first schema lands, migrations are applied with
`prisma migrate dev` against this database.

## Verification commands

```bash
pnpm lint
pnpm typecheck
pnpm test:unit
pnpm test:e2e
pnpm test:integration   # requires pnpm db:up
pnpm build
pnpm format:check
```

## Troubleshooting

| Symptom                                     | Likely cause / fix                                                                             |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `pnpm: command not found`                   | Corepack shims are not enabled. Run `corepack enable` or use `corepack pnpm <command>`.        |
| Port 5432 already in use                    | Another PostgreSQL is running. Set `POSTGRES_PORT` (and the port in `DATABASE_URL`) in `.env`. |
| `@prisma/client` types missing              | Run `pnpm prisma:generate` after install or schema changes.                                    |
| `/ready` returns 503                        | PostgreSQL is not running or `DATABASE_URL` is wrong. Check `pnpm db:logs`.                    |
| Web shows "The API could not be reached"    | The API is not on port 4000, or the Vite proxy target changed.                                 |
| Electron window blank in `pnpm dev:desktop` | The web dev server is not running; start `pnpm dev` first.                                     |
| CI fails on `format:check`                  | Run `pnpm format` and commit the result.                                                       |
