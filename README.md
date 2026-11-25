# Retail Server

Backend project for the **Adaptive Retail Intelligence Platform** — a NestJS modular monolith with PostgreSQL and Prisma ORM.

## Stack

| Area     | Choice                                 |
| -------- | -------------------------------------- |
| Backend  | NestJS 11 (Express), modular monolith  |
| Database | PostgreSQL 17, Prisma 6.19             |
| Tests    | Jest, Supertest                        |
| Tooling  | pnpm 11 workspaces, ESLint 9, Prettier |

## Prerequisites

- Node.js **>= 22.12**
- pnpm **11.28.13** — pinned via `packageManager`; enable with `corepack enable`
- Docker (for the development PostgreSQL instance)

## Quick start

```bash
cp .env.example .env          # local only; .env is git-ignored
pnpm install
pnpm db:up                    # PostgreSQL 17 on localhost:5432
pnpm prisma:generate
pnpm dev                      # API on :4000
```

## Commands

| Command                  | Purpose                                                |
| ------------------------ | ------------------------------------------------------ |
| `pnpm dev`               | Start API in watch mode                                |
| `pnpm build`             | Build the API                                          |
| `pnpm lint`              | ESLint across all workspaces                           |
| `pnpm typecheck`         | tsc --noEmit across all workspaces                     |
| `pnpm test:unit`         | API unit tests                                         |
| `pnpm test:e2e`          | API HTTP e2e with Supertest                            |
| `pnpm test:integration`  | Real PostgreSQL integration tests (`pnpm db:up` first) |
| `pnpm db:up` / `db:down` | Start/stop the dev database                            |
| `pnpm prisma:generate`   | Generate the Prisma client                             |
| `pnpm prisma:validate`   | Validate the Prisma schema                             |

## Layout

```
apps/api          NestJS modular monolith (health, config, database access)
apps/api/prisma   Prisma schema (159 models, 94 enums)
packages/config   Shared TypeScript, ESLint and Prettier configuration
docs/             Architecture, database, API, requirements, operations
infra/docker      Development database
```

## Documentation

- [System architecture](docs/architecture/SYSTEM_ARCHITECTURE.md)
- [Backend architecture](docs/architecture/BACKEND_ARCHITECTURE.md)
- [API architecture](docs/api/API_ARCHITECTURE.md)
- [Database design](docs/database/CONCEPTUAL_DATA_MODEL.md)
- [Architecture decision records](docs/architecture/ARCHITECTURE_DECISION_RECORDS.md)
- [Master Requirements & Decision Document](docs/requirements/MASTER_PROJECT_REQUIREMENTS_AND_DECISION_DOCUMENT.md)
