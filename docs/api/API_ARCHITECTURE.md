# API architecture

**Status:** Step 2 contract design. The API today exposes only `/health`, `/ready` and a global
`api` prefix with validation and CORS. Every business endpoint below is a contract to implement, not
a working route. This document supersedes the former `api-conventions.md`, which is deleted.

Related decisions: D-010, D-018, D-024, D-031. Isolation rules are in
[`../architecture/MULTI_TENANT_SECURITY_ARCHITECTURE.md`](../architecture/MULTI_TENANT_SECURITY_ARCHITECTURE.md).

## 1. Base path and versioning

| Route               | Purpose                                | Versioned |
| ------------------- | -------------------------------------- | --------- |
| `/health`           | Liveness; never touches the database   | No        |
| `/ready`            | Readiness; bounded database probe      | No        |
| `/api/v1/...`       | All business endpoints                 | Yes       |
| `/api/docs`         | Swagger UI (non-production by default) | No        |
| `/api/openapi.json` | Generated OpenAPI document             | No        |

- Versioning is in the URL path. Controllers mount `v1` under the global `api` prefix.
- Additive changes (new optional fields, new endpoints, new enum values the client must tolerate) stay
  in `v1`. Removing a field, changing a type, changing semantics or tightening validation requires
  `v2`.
- Deprecated endpoints return `Deprecation` and `Sunset` headers and stay available for the announced
  window. The desktop client may lag; the web client is expected to update fastest.
- Probes are never versioned and never require authentication.

## 2. Resource naming and methods

- Resources are plural nouns in kebab-case: `/products`, `/purchase-orders`, `/stock-movements`.
- Business-scoped resources nest under the business: `/businesses/{businessId}/products`.
- Branch-scoped collections nest under the branch:
  `/businesses/{businessId}/branches/{branchId}/sales`.
- Non-CRUD commands are action sub-resources with a verb in the last segment:
  `/purchase-orders/{id}/approve`, `/sales/{id}/void`, `/returns/{id}/approve`.
- Methods: `GET` read (no side effects), `POST` create or command, `PATCH` partial update with
  optimistic concurrency, `PUT` only for full replacement where explicitly documented, `DELETE` only
  for genuinely removable records (most business records are archived or voided instead).
- `DELETE` must never remove financial or stock history. Returns, sales, movements, invoices and
  audit rows are immutable facts; corrections are compensating records.

## 3. Data conventions

| Concern        | Convention                                                                                                  |
| -------------- | ----------------------------------------------------------------------------------------------------------- |
| IDs            | Opaque UUID strings. Clients must not parse or construct them.                                              |
| Timestamps     | ISO 8601 UTC with `Z`, e.g. `2026-11-21T08:30:00Z`. Business-local dates are explicit fields.               |
| Money          | `{ "amountMinor": 1250, "currency": "ETB" }`; integer minor units, never floating point.                    |
| Quantities     | Decimal strings with up to three fraction digits, e.g. `"2.500"`, plus a unit reference. Never JSON floats. |
| Percentages    | Decimal string, e.g. `"12.5"`, or integer basis points where the contract says so.                          |
| Booleans       | `true`/`false`, never `0`/`1`.                                                                              |
| Null vs absent | `null` clears an optional field in `PATCH`; an absent field leaves it unchanged.                            |
| Locale         | `Accept-Language` may localize messages; enums and codes stay English and stable.                           |
| Field names    | `camelCase` in JSON, `snake_case` in the database. Mapping happens in the module mapper.                    |

## 4. Request validation

- The global `ValidationPipe` runs with `whitelist`, `forbidNonWhitelisted` and `transform`
  (implemented for the shell). Unknown fields are rejected, not ignored.
- DTOs declare types, bounds, string lengths, enum membership and format. Validation happens before
  the controller body.
- Server-side validation is authoritative. Client validation is UX only.
- Totals, prices, permissions, business IDs and stock effects are never accepted from the client as
  truth. The server recomputes them.
- File uploads are multipart with a size limit and an allowlist; metadata is validated separately from
  bytes.

## 5. Success responses

All successful responses use a `data` envelope so metadata can be added without breaking clients.

Single resource:

```json
{
  "data": {
    "id": "018f4c1e-...",
    "name": "Paracetamol 500mg",
    "status": "active",
    "version": 3,
    "createdAt": "2026-11-21T08:30:00Z",
    "updatedAt": "2026-11-21T09:15:00Z"
  }
}
```

Collection, page-based (default for admin and report lists):

```json
{
  "data": [{ "id": "..." }],
  "page": { "page": 1, "pageSize": 20, "total": 134, "totalPages": 7 }
}
```

Collection, cursor-based (sync feeds, audit streams, large activity lists):

```json
{
  "data": [{ "id": "..." }],
  "nextCursor": "eyJpZCI6IjAxOGY0..."
}
```

Status codes: `200` read/update/command success, `201` create with `Location`, `202` accepted for
asynchronous work, `204` only where a body is meaningless. Never return `200` with an error body.

## 6. Error contract

Errors use an RFC 9457-style problem document. No stack traces, SQL, internal paths or other tenants'
identifiers.

```json
{
  "type": "https://errors.arp.example/insufficient-stock",
  "title": "Insufficient stock",
  "status": 422,
  "detail": "Branch stock for variant 018f... is 1.000 and the requested quantity is 2.000.",
  "code": "INSUFFICIENT_STOCK",
  "correlationId": "9f2c4d1e-...",
  "errors": [
    {
      "field": "items[0].quantity",
      "code": "insufficient",
      "message": "Requested quantity exceeds available stock."
    }
  ]
}
```

| Status | Use                                                                                         |
| ------ | ------------------------------------------------------------------------------------------- |
| 400    | Malformed request or field validation failure                                               |
| 401    | Missing, invalid or expired authentication                                                  |
| 403    | Authenticated, membership known, permission or branch denied                                |
| 404    | Resource missing **or** outside the caller's membership (existence is not confirmed)        |
| 409    | Version conflict, duplicate idempotency key with a different body, illegal concurrent state |
| 422    | Well-formed request that violates a business rule (insufficient stock, invalid transition)  |
| 429    | Rate limit exceeded; includes `Retry-After`                                                 |
| 500    | Unexpected failure; generic detail plus correlation ID                                      |
| 503    | Dependency unavailable; readiness uses the same shape with a `degraded` code                |

`type` values are stable documentation URIs; clients branch on `code`, not `title` or `detail`.

## 7. Authentication and authorization

- Access token: short-lived bearer token sent as `Authorization: Bearer <token>`.
- Refresh: web keeps the refresh token in an httpOnly, Secure, SameSite cookie; the access token lives
  in memory. Desktop keeps the refresh token in the OS credential vault through the main process.
- No token is stored in `localStorage`; no token claim carries tenant or role authority.
- `401` triggers a single refresh attempt, then sign-out. Refresh is rotation-based with reuse
  detection.
- Every business endpoint declares a permission. A route without a declared permission is forbidden by
  default.
- Business and branch context come from the URL and are validated on every request. A client cannot
  select a business by header.

## 8. Pagination, filtering, sorting and search

| Concern    | Rule                                                                                                                                   |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| Pagination | `page` (1-based) and `pageSize` (default 20, max 100) for admin lists; `cursor` + `limit` (max 100) for sync, audit and activity feeds |
| Response   | `page` object or `nextCursor` exactly as in Section 5                                                                                  |
| Filtering  | Explicit allowlisted query parameters per endpoint; unknown filters are `400`                                                          |
| Sorting    | `sort=-createdAt` or `sort=name`; only allowlisted fields; default always deterministic                                                |
| Search     | `q` with a documented minimum length, searching only allowlisted indexed fields; no raw SQL fragments                                  |
| Dates      | `from`/`to` inclusive, ISO 8601, bounded to a maximum range per endpoint                                                               |
| Totals     | Expensive counts are opt-in (`includeTotal=true`) or served from a read model                                                          |

Pagination is mandatory on every collection. An endpoint that can return unbounded rows is a defect.

## 9. Idempotency and concurrency

- Unsafe operations that create money or stock effects accept `Idempotency-Key` (a client-generated
  UUID). The server stores key, request hash and response for the documented retention window.
  - Same key + same body: return the original response (and status) without re-executing.
  - Same key + different body: `409 IDEMPOTENCY_KEY_REUSED`.
- Offline sync uses the same mechanism through the operation envelope's `operationId`; the effective
  key is `(deviceId, operationId)`.
- Mutable resources expose `version`. `PATCH` requires `If-Match` or an explicit `version`; a stale
  version returns `409 VERSION_CONFLICT` with the current resource in `detail` metadata, never a
  silent last-write-wins.
- State transitions (`approve`, `receive`, `void`, `refund`) are validated against current state inside
  the transaction; two concurrent approvals cannot both succeed.

## 10. Rate limiting and abuse control

| Surface                    | Limit (initial, configurable)        | Response |
| -------------------------- | ------------------------------------ | -------- |
| Login, password reset, OTP | Per IP and per account, with backoff | 429      |
| Refresh                    | Per session                          | 429      |
| General authenticated API  | Per user and per business            | 429      |
| Webhooks                   | Per IP, generous but bounded         | 429      |
| Exports and reports        | Per user, plus a concurrent-job cap  | 429/202  |
| Uploads                    | Per user, plus size and count limits | 413/429  |

`429` responses include `Retry-After`. Rate limiting is not an authorization control; it never
replaces membership or permission checks.

## 11. Documentation

- Swagger/OpenAPI is generated from decorated controllers and DTOs. It documents success bodies, the
  problem shape, required permissions, scope (business/branch) and idempotency.
- Swagger UI is enabled outside production by default; in production it is either disabled or behind
  platform authentication. The JSON document may remain available for client generation.
- The contract examples in this document are the review reference; the generated document must match.

## 12. Representative contracts

All examples assume `Authorization: Bearer <token>` unless noted. Paths omit the `/api` prefix for
readability; the real path is `/api/v1/...`.

### 12.1 Authentication

```http
POST /v1/auth/login
Content-Type: application/json

{ "email": "owner@example.com", "password": "<secret>" }
```

`200`:

```json
{
  "data": {
    "accessToken": "<short-lived>",
    "expiresIn": 900,
    "user": { "id": "018f...", "email": "owner@example.com", "displayName": "Sara" }
  }
}
```

The refresh token is set as an httpOnly cookie on web; the desktop client receives it through the
main-process flow, never in a renderer-readable body. Errors: `401 INVALID_CREDENTIALS` (generic,
never reveals whether the email exists), `429 TOO_MANY_ATTEMPTS`. Permission: public, rate-limited.

```http
POST /v1/auth/refresh     -> rotates the refresh token, returns a new access token
POST /v1/auth/logout      -> revokes the current session family
POST /v1/auth/password-reset/request  -> always 202, never reveals existence
```

### 12.2 Business registration

```http
POST /v1/businesses
Permission: any authenticated user may create a business, subject to the platform's business limit
Content-Type: application/json

{
  "name": "Selam Mart",
  "businessType": "grocery",
  "currency": "ETB",
  "timezone": "Africa/Addis_Ababa",
  "firstBranch": { "name": "Bole", "code": "BOL-01" }
}
```

`201` with `Location: /api/v1/businesses/{businessId}`:

```json
{
  "data": {
    "business": {
      "id": "018f...",
      "name": "Selam Mart",
      "businessType": "grocery",
      "status": "active"
    },
    "membership": { "id": "018f...", "role": "owner", "branchAccess": "all" },
    "branch": { "id": "018f...", "name": "Bole", "code": "BOL-01" }
  }
}
```

The creator receives the Owner membership in the same transaction. Errors: `409 BUSINESS_LIMIT`
unless the plan allows more, `422 INVALID_BUSINESS_TYPE`. Permission: authenticated; the result is
audited as `tenancy.business-created`.

### 12.3 Business switching

There is no token exchange. The client lists memberships once and then addresses the chosen business
in the URL; every request re-validates membership.

```http
GET /v1/me/businesses
Permission: authenticated

200
{
  "data": [
    {
      "businessId": "018f...",
      "name": "Selam Mart",
      "businessType": "grocery",
      "role": "owner",
      "branchAccess": "all",
      "lastUsedAt": "2026-11-20T18:02:00Z"
    },
    {
      "businessId": "018f...",
      "name": "Bole Pharmacy",
      "businessType": "pharmacy",
      "role": "manager",
      "branchAccess": ["018f..."],
      "lastUsedAt": "2026-11-18T09:10:00Z"
    }
  ]
}
```

After a switch, the client calls `GET /v1/businesses/{businessId}/context`:

```json
{
  "data": {
    "business": { "id": "018f...", "name": "Selam Mart", "businessType": "grocery" },
    "membership": { "role": "owner", "branchAccess": "all" },
    "branches": [{ "id": "018f...", "name": "Bole", "code": "BOL-01" }],
    "capabilities": ["inventory.batch", "catalog.variants"],
    "permissions": ["catalog:product:write", "inventory:stock:adjust", "..."]
  }
}
```

Permissions in this response shape navigation only. The server re-checks on every request. A revoked
membership returns `404` on the next business call.

### 12.4 Product creation

```http
POST /v1/businesses/{businessId}/products
Permission: catalog:product:write (Owner, Business Admin)
Content-Type: application/json

{
  "name": "Paracetamol 500mg",
  "categoryId": "018f...",
  "brandId": null,
  "unit": { "baseUnitId": "018f...", "display": "tablet" },
  "attributes": [{ "key": "strength", "value": "500mg" }],
  "variants": [
    { "sku": "PARA-500-20", "barcode": "8901234567890", "packSize": "20.000" }
  ]
}
```

`201` returns the product with `version: 1` and generated IDs. Validation follows the business type's
profile: a pharmacy requires the configured attributes, a fashion product may require size/color
variants, a grocery product uses weight units. Errors: `409 DUPLICATE_SKU`, `422 ATTRIBUTE_REQUIRED`,
`422 INVALID_UNIT`. Archiving never deletes sale or movement history.

### 12.5 Inventory updates

Receiving is the normal way stock increases; adjustment is for counts and corrections. Both create
append-only movements.

```http
POST /v1/businesses/{businessId}/branches/{branchId}/inventory/adjustments
Permission: inventory:stock:adjust (Owner, Manager — never Business Admin)
Idempotency-Key: 018f0f0e-...
Content-Type: application/json

{
  "reason": "stocktake",
  "note": "Monthly count",
  "lines": [
    { "productId": "018f...", "variantId": "018f...", "quantityDelta": "-2.000", "unitId": "018f..." }
  ]
}
```

`201`:

```json
{
  "data": {
    "movementId": "018f...",
    "branchId": "018f...",
    "lines": [{ "variantId": "018f...", "quantityBefore": "10.000", "quantityAfter": "8.000" }],
    "recordedBy": "018f...",
    "recordedAt": "2026-11-21T10:00:00Z"
  }
}
```

Any accepted adjustment that would drive stock below zero is rejected with `422 INSUFFICIENT_STOCK`.
An offline sale whose sync would do the same is refused at ingest under the approved D-025: no sale
or stock movement is written and the transaction becomes an explicit reconciliation exception — it
is never converted into a silent adjustment. Permission checks also verify the branch assignment.
Every adjustment is audited.

### 12.6 Purchase orders and receiving

```http
POST /v1/businesses/{businessId}/purchase-orders
Permission: procurement:po:write (Owner, Business Admin prepares, Manager executes)
Content-Type: application/json

{
  "supplierId": "018f...",
  "branchId": "018f...",
  "expectedAt": "2026-12-01",
  "lines": [
    { "productId": "018f...", "variantId": "018f...", "quantity": "48.000", "unitCost": { "amountMinor": 1200, "currency": "ETB" } }
  ]
}
```

`201` returns the order as `draft` with `version: 1`. Then:

```http
POST /v1/businesses/{businessId}/purchase-orders/{id}/approve
Permission: procurement:po:approve (Owner, Manager)

POST /v1/businesses/{businessId}/purchase-orders/{id}/receivings
Permission: procurement:receiving:accept (Owner, Manager — never Business Admin)
Idempotency-Key: 018f0f0e-...

{
  "receivedAt": "2026-12-01T09:00:00Z",
  "lines": [{ "poLineId": "018f...", "quantity": "48.000", "batch": { "lot": "L-2026-12", "expiresOn": "2028-12-01" } }]
}
```

Approving a PO **does not change stock**. Only an accepted receiving creates the positive movement
through `inventory` and updates the supplier payable. Partial receiving is allowed up to the ordered
quantity. Errors: `409 PO_NOT_APPROVED`, `422 OVER_RECEIPT`, `409 VERSION_CONFLICT`.

### 12.7 POS sale (online and offline origin)

```http
POST /v1/businesses/{businessId}/branches/{branchId}/sales
Permission: sales:sale:create (Owner, Manager, Cashier)
Idempotency-Key: 018f0f0e-...
Content-Type: application/json

{
  "terminalId": "018f...",
  "shiftId": "018f...",
  "customerId": null,
  "items": [
    {
      "productId": "018f...",
      "variantId": "018f...",
      "quantity": "2.000",
      "unitPrice": { "amountMinor": 2500, "currency": "ETB" }
    }
  ],
  "payments": [{ "method": "cash", "amount": { "amountMinor": 5000, "currency": "ETB" } }],
  "clientCreatedAt": "2026-11-21T10:05:00Z"
}
```

`201`:

```json
{
  "data": {
    "saleId": "018f...",
    "receiptNumber": "BOL-000148",
    "status": "completed",
    "total": { "amountMinor": 5000, "currency": "ETB" },
    "change": { "amountMinor": 0, "currency": "ETB" },
    "items": [
      {
        "variantId": "018f...",
        "quantity": "2.000",
        "lineTotal": { "amountMinor": 5000, "currency": "ETB" }
      }
    ],
    "completedAt": "2026-11-21T10:05:02Z"
  }
}
```

The server does not accept the client's `unitPrice` as truth: if it differs from the resolved price,
the request returns `422 PRICE_CHANGED` with the authoritative price and requires confirmation. It
applies stock issues and
payment rows in one transaction, and returns the original result on replay. An offline-origin sale
arrives through the sync envelope with the same idempotency semantics. Its stock is re-checked
inside the atomic commit; if shared stock has since fallen, the sale is not created, no stock
movement is written, and the operation is returned as `conflicted` with code `INSUFFICIENT_STOCK`
and a reconciliation exception reference (D-025). The transaction is preserved on the device and in
the exception record, never silently altered or deleted.

### 12.8 Returns and refunds

```http
POST /v1/businesses/{businessId}/returns
Permission: after-sales:return:create (Owner, Manager, Cashier initiates)
Content-Type: application/json

{
  "saleId": "018f...",
  "branchId": "018f...",
  "reason": "damaged",
  "lines": [{ "saleItemId": "018f...", "quantity": "1.000" }]
}
```

`201` creates a `requested` return; stock is **not** restocked yet.

```http
POST /v1/businesses/{businessId}/returns/{id}/inspect
Permission: after-sales:return:inspect (Owner, Manager)
{ "lines": [{ "saleItemId": "018f...", "accepted": true, "inspectionNote": "sealed" }] }

POST /v1/businesses/{businessId}/returns/{id}/approve
Permission: after-sales:refund:approve (Owner, Manager — never Business Admin)
Idempotency-Key: 018f0f0e-...
{ "refunds": [{ "method": "cash", "amount": { "amountMinor": 2500, "currency": "ETB" } }] }
```

Refund cannot exceed the paid amount; approved restock creates an inventory movement; the original
sale is immutable and a compensating record is written. Sensitive-limit refunds require step-up
confirmation. Errors: `422 REFUND_EXCEEDS_PAID`, `409 INVALID_RETURN_STATE`.

### 12.9 Forecasting (advisory)

```http
GET /v1/businesses/{businessId}/intelligence/forecasts?productId=018f...&branchId=018f...&horizonDays=28
Permission: intelligence:forecast:read (Owner, Manager, Business Admin view)

200
{
  "data": {
    "forecastRunId": "018f...",
    "generatedAt": "2026-11-21T02:00:00Z",
    "horizonDays": 28,
    "model": { "name": "baseline-v1", "version": "2026.11" },
    "points": [
      { "date": "2026-11-22", "expected": "12.400", "lower": "9.000", "upper": "16.000" }
    ],
    "confidence": "medium",
    "explanation": "Based on 90 days of sales and current stock."
  }
}
```

Forecasts are read-only. A recommendation is a separate proposal:

```http
GET  /v1/businesses/{businessId}/intelligence/recommendations?status=proposed
POST /v1/businesses/{businessId}/intelligence/recommendations/{id}/review
Permission: intelligence:recommendation:review (Owner, Manager)

{ "decision": "accepted", "note": "Reorder 48 units" }
```

Accepting a recommendation does **not** create a purchase order automatically. An authorized user
creates the order through `procurement`. No AI path can change stock, price or payment.

### 12.10 Subscription payment (contract only)

```http
POST /v1/businesses/{businessId}/subscription/checkout-sessions
Permission: billing:subscription:manage (Owner only)
Idempotency-Key: 018f0f0e-...

{ "planId": "018f...", "billingCycle": "monthly" }

201
{
  "data": {
    "paymentAttemptId": "018f...",
    "provider": "chapa",
    "checkoutUrl": "https://checkout.chapa.co/...",
    "expiresAt": "2026-11-21T11:00:00Z"
  }
}
```

The browser is redirected to the hosted checkout. Activation happens only after a **server-verified**
webhook or an explicit provider reconciliation:

```http
POST /v1/webhooks/chapa
Chapa-Signature: <provider signature>
Content-Type: application/json

{ "event": "charge.success", "tx_ref": "arp_sub_018f...", "status": "success", "amount": 49900, "currency": "ETB" }
```

`200` acknowledges; duplicate delivery is idempotent by `tx_ref`; a forged or mismatched signature is
`401` and audited. The webhook is public, signature-verified, rate-limited and never trusts the
redirect alone. The client cannot activate a subscription. No Chapa call is claimed to work until it
is verified against the sandbox.

### 12.11 Offline sync envelope

```http
POST /v1/businesses/{businessId}/sync/operations
Device-Authorization: <device credential>
Content-Type: application/json

{
  "deviceId": "018f...",
  "branchId": "018f...",
  "operations": [
    {
      "operationId": "018f0f0e-...",
      "type": "sale.completed",
      "occurredAt": "2026-11-21T10:05:00Z",
      "payload": { "...": "same shape as the sale command" }
    }
  ]
}
```

The response reports per-operation outcomes (`accepted`, `duplicate`, `conflicted`, `rejected`) and
the server's canonical record. Example shortfall result:

```json
{
  "operationId": "018f0f0e-...",
  "outcome": "conflicted",
  "code": "INSUFFICIENT_STOCK",
  "reconciliationExceptionId": "018f...",
  "message": "Authoritative stock is insufficient; the sale was not committed."
}
```

A stock shortfall is `conflicted`, not `rejected`: no sale or stock movement is committed, and the
operation has a manual resolution path. A rejected operation with no resolution path is never
deleted from the device; it stays visible for export or support. Full semantics are in
[`../architecture/OFFLINE_SYNCHRONIZATION_ARCHITECTURE.md`](../architecture/OFFLINE_SYNCHRONIZATION_ARCHITECTURE.md).

## 13. What exists today

| Capability                        | State       |
| --------------------------------- | ----------- |
| `/health`, `/ready`               | Implemented |
| Global `api` prefix               | Implemented |
| Global validation pipe            | Implemented |
| CORS allowlist from validated env | Implemented |
| `/api/v1` business routes         | Planned     |
| Authentication and refresh        | Planned     |
| Problem-details errors            | Planned     |
| Idempotency middleware            | Planned     |
| Swagger/OpenAPI                   | Planned     |
| Rate limiting                     | Planned     |
