# Environment configuration

One git-ignored `.env` at the repository root is the local source of truth. `.env.example` is
committed. The API validates the file at boot with Zod (`apps/api/src/config/env.validation.ts`)
and refuses to start with missing or malformed values.

| Variable               | Consumer      | Default (example)                                                                | Rules                                                                                               |
| ---------------------- | ------------- | -------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `NODE_ENV`             | API, Vite     | `development`                                                                    | `development`, `test`, `production`                                                                 |
| `PORT`                 | API           | `4000`                                                                           | 1–65535                                                                                             |
| `APP_VERSION`          | API probes    | `0.1.0-foundation`                                                               | Non-empty; supplied by CI/release tooling                                                           |
| `DATABASE_URL`         | API, Prisma   | `postgresql://arp:arp_dev_password@localhost:5432/adaptive_retail?schema=public` | Must start with `postgresql://` or `postgres://`. Add `connect_timeout=5` in deployed environments. |
| `READINESS_TIMEOUT_MS` | API readiness | `3000`                                                                           | 100–60000                                                                                           |
| `CORS_ORIGINS`         | API           | `http://localhost:5173,http://127.0.0.1:5173`                                    | Comma-separated absolute URLs, at least one                                                         |
| `POSTGRES_USER`        | Compose       | `arp`                                                                            | Dev only                                                                                            |
| `POSTGRES_PASSWORD`    | Compose       | `arp_dev_password`                                                               | Dev only, never reused outside local                                                                |
| `POSTGRES_DB`          | Compose       | `adaptive_retail`                                                                | Dev only                                                                                            |
| `POSTGRES_PORT`        | Compose       | `5432`                                                                           | Host port                                                                                           |
| `VITE_API_URL`         | Web           | unset (same-origin / Vite proxy)                                                 | Absolute API URL when the web app is served from a different origin                                 |
| `WEB_DEV_URL`          | Desktop       | `http://localhost:5173`                                                          | Only used with `electron . --dev`                                                                   |

Rules:

- Secrets never enter the repository. `.env` is git-ignored; CI provides variables through the
  workflow environment or platform secret store.
- The API validates configuration once at boot; a bad value is a startup failure, not a runtime
  surprise.
- Web variables must be prefixed `VITE_` to be exposed to the browser. Never put secrets in them.
- `POSTGRES_*` values are consumed by Docker Compose, not by the API.
