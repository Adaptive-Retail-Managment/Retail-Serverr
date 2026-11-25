-- CreateEnum
CREATE TYPE "OutboxStatus" AS ENUM ('PENDING', 'PROCESSING', 'PROCESSED', 'FAILED', 'DEAD');

-- CreateEnum
CREATE TYPE "IdempotencyScope" AS ENUM ('API', 'SYNC', 'WEBHOOK');

-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('ACTIVE', 'INVITED', 'SUSPENDED', 'DEACTIVATED');

-- CreateEnum
CREATE TYPE "BusinessType" AS ENUM ('GROCERY', 'FASHION', 'PHARMACY', 'COSMETICS');

-- CreateEnum
CREATE TYPE "BusinessStatus" AS ENUM ('ACTIVE', 'SUSPENDED', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "MembershipStatus" AS ENUM ('INVITED', 'ACTIVE', 'SUSPENDED', 'DEACTIVATED');

-- CreateEnum
CREATE TYPE "InvitationStatus" AS ENUM ('PENDING', 'ACCEPTED', 'EXPIRED', 'REVOKED');

-- CreateEnum
CREATE TYPE "PermissionScope" AS ENUM ('PLATFORM', 'BUSINESS', 'BRANCH');

-- CreateEnum
CREATE TYPE "EmployeeStatus" AS ENUM ('ACTIVE', 'ON_LEAVE', 'SUSPENDED', 'TERMINATED');

-- CreateEnum
CREATE TYPE "PlanStatus" AS ENUM ('DRAFT', 'ACTIVE', 'RETIRED');

-- CreateEnum
CREATE TYPE "BillingCycle" AS ENUM ('MONTHLY', 'ANNUAL');

-- CreateEnum
CREATE TYPE "SubscriptionStatus" AS ENUM ('TRIALING', 'ACTIVE', 'PAST_DUE', 'SUSPENDED', 'CANCELLED', 'EXPIRED');

-- CreateEnum
CREATE TYPE "SubscriptionEventType" AS ENUM ('TRIAL_STARTED', 'ACTIVATED', 'RENEWED', 'PAYMENT_FAILED', 'PAST_DUE', 'SUSPENDED', 'CANCELLED', 'EXPIRED', 'PLAN_CHANGED');

-- CreateEnum
CREATE TYPE "InvoiceStatus" AS ENUM ('DRAFT', 'ISSUED', 'PAID', 'VOID', 'OVERDUE');

-- CreateEnum
CREATE TYPE "PaymentProvider" AS ENUM ('CHAPA', 'MANUAL');

-- CreateEnum
CREATE TYPE "PaymentAttemptStatus" AS ENUM ('PENDING', 'SUCCESS', 'FAILED', 'CANCELLED', 'EXPIRED');

-- CreateEnum
CREATE TYPE "WebhookStatus" AS ENUM ('RECEIVED', 'PROCESSED', 'IGNORED', 'FAILED');

-- CreateEnum
CREATE TYPE "AttributeEntityType" AS ENUM ('PRODUCT', 'VARIANT', 'CUSTOMER', 'SUPPLIER', 'BUSINESS');

-- CreateEnum
CREATE TYPE "AttributeDataType" AS ENUM ('TEXT', 'NUMBER', 'BOOLEAN', 'DATE', 'SELECT', 'MULTI_SELECT');

-- CreateEnum
CREATE TYPE "UnitKind" AS ENUM ('COUNT', 'WEIGHT', 'VOLUME', 'LENGTH', 'TIME');

-- CreateEnum
CREATE TYPE "ProductStatus" AS ENUM ('DRAFT', 'ACTIVE', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "ProductType" AS ENUM ('STANDARD', 'VARIANT', 'SERVICE', 'BUNDLE');

-- CreateEnum
CREATE TYPE "MediaRole" AS ENUM ('IMAGE', 'VIDEO', 'DOCUMENT', 'ATTACHMENT');

-- CreateEnum
CREATE TYPE "ImportStatus" AS ENUM ('PENDING', 'VALIDATING', 'VALIDATED', 'IMPORTING', 'COMPLETED', 'FAILED');

-- CreateEnum
CREATE TYPE "PriceListStatus" AS ENUM ('DRAFT', 'ACTIVE', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "DiscountType" AS ENUM ('PERCENTAGE', 'FIXED_AMOUNT');

-- CreateEnum
CREATE TYPE "DiscountScope" AS ENUM ('ORDER', 'LINE', 'PRODUCT', 'CATEGORY', 'CUSTOMER');

-- CreateEnum
CREATE TYPE "FileStatus" AS ENUM ('PENDING', 'UPLOADED', 'AVAILABLE', 'QUARANTINED', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "FileLinkRole" AS ENUM ('PRIMARY', 'GALLERY', 'ATTACHMENT', 'DOCUMENT', 'EVIDENCE');

-- CreateEnum
CREATE TYPE "StockLocationType" AS ENUM ('SELLABLE', 'BACKROOM', 'QUARANTINE', 'DAMAGED', 'IN_TRANSIT');

-- CreateEnum
CREATE TYPE "StockMovementType" AS ENUM ('RECEIPT', 'SALE', 'RETURN', 'ADJUSTMENT', 'TRANSFER_OUT', 'TRANSFER_IN', 'STOCKTAKE', 'LOSS', 'RESERVATION_RELEASE', 'RECONCILIATION');

-- CreateEnum
CREATE TYPE "BatchStatus" AS ENUM ('ACTIVE', 'QUARANTINED', 'EXPIRED', 'DEPLETED', 'DISPOSED');

-- CreateEnum
CREATE TYPE "StocktakeStatus" AS ENUM ('DRAFT', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "AdjustmentType" AS ENUM ('INCREASE', 'DECREASE');

-- CreateEnum
CREATE TYPE "AdjustmentReason" AS ENUM ('COUNT_VARIANCE', 'DAMAGE', 'EXPIRY', 'THEFT', 'FOUND', 'CORRECTION', 'RECONCILIATION');

-- CreateEnum
CREATE TYPE "AdjustmentStatus" AS ENUM ('DRAFT', 'PENDING_APPROVAL', 'APPROVED', 'APPLIED', 'REJECTED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "TransferStatus" AS ENUM ('DRAFT', 'PENDING_APPROVAL', 'APPROVED', 'IN_TRANSIT', 'PARTIALLY_RECEIVED', 'RECEIVED', 'CANCELLED', 'DISPUTED');

-- CreateEnum
CREATE TYPE "AlertType" AS ENUM ('LOW_STOCK', 'OUT_OF_STOCK', 'EXPIRY_RISK', 'OVERSTOCK', 'RECONCILIATION');

-- CreateEnum
CREATE TYPE "AlertStatus" AS ENUM ('OPEN', 'ACKNOWLEDGED', 'RESOLVED', 'DISMISSED');

-- CreateEnum
CREATE TYPE "ReservationStatus" AS ENUM ('ACTIVE', 'RELEASED', 'CONSUMED', 'EXPIRED');

-- CreateEnum
CREATE TYPE "LossType" AS ENUM ('DAMAGE', 'EXPIRY', 'THEFT', 'LOST', 'OTHER');

-- CreateEnum
CREATE TYPE "SupplierStatus" AS ENUM ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "AgreementStatus" AS ENUM ('DRAFT', 'ACTIVE', 'EXPIRED', 'TERMINATED');

-- CreateEnum
CREATE TYPE "DisputeStatus" AS ENUM ('OPEN', 'INVESTIGATING', 'RESOLVED', 'CLOSED');

-- CreateEnum
CREATE TYPE "QuotationStatus" AS ENUM ('REQUESTED', 'RECEIVED', 'SELECTED', 'REJECTED', 'EXPIRED');

-- CreateEnum
CREATE TYPE "PurchaseRequestStatus" AS ENUM ('DRAFT', 'SUBMITTED', 'APPROVED', 'REJECTED', 'CONVERTED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "RfqStatus" AS ENUM ('DRAFT', 'ISSUED', 'CLOSED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "PurchaseOrderStatus" AS ENUM ('DRAFT', 'PENDING_APPROVAL', 'APPROVED', 'SENT', 'CONFIRMED', 'PARTIALLY_RECEIVED', 'RECEIVED', 'CLOSED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "GoodsReceiptStatus" AS ENUM ('DRAFT', 'PENDING_INSPECTION', 'ACCEPTED', 'PARTIALLY_ACCEPTED', 'REJECTED', 'POSTED');

-- CreateEnum
CREATE TYPE "SupplierInvoiceStatus" AS ENUM ('RECEIVED', 'MATCHED', 'DISPUTED', 'APPROVED', 'PAID', 'VOID');

-- CreateEnum
CREATE TYPE "InvoiceMatchStatus" AS ENUM ('UNMATCHED', 'PARTIAL', 'MATCHED', 'EXCEPTION');

-- CreateEnum
CREATE TYPE "SupplierPaymentStatus" AS ENUM ('SCHEDULED', 'PROCESSING', 'PAID', 'FAILED', 'VOID');

-- CreateEnum
CREATE TYPE "CustomerStatus" AS ENUM ('ACTIVE', 'INACTIVE', 'MERGED', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "DeviceStatus" AS ENUM ('PENDING', 'ACTIVE', 'SUSPENDED', 'REVOKED');

-- CreateEnum
CREATE TYPE "SyncSessionStatus" AS ENUM ('OPEN', 'COMPLETED', 'FAILED', 'ABANDONED');

-- CreateEnum
CREATE TYPE "SyncOperationStatus" AS ENUM ('PENDING', 'PROCESSING', 'ACCEPTED', 'DUPLICATE', 'CONFLICTED', 'REJECTED', 'FAILED');

-- CreateEnum
CREATE TYPE "ReconciliationStatus" AS ENUM ('OPEN', 'INVESTIGATING', 'STOCK_CORRECTED', 'RELEASED', 'COMMITTED', 'NOT_FULFILLED');

-- CreateEnum
CREATE TYPE "ReconciliationEventType" AS ENUM ('CREATED', 'ASSIGNED', 'INVESTIGATION_STARTED', 'STOCK_CORRECTION_POSTED', 'RELEASED', 'REVALIDATION_PASSED', 'COMMITTED', 'REVALIDATION_FAILED', 'NOT_FULFILLED', 'NOTE_ADDED');

-- CreateEnum
CREATE TYPE "ConflictType" AS ENUM ('STOCK_SHORTFALL', 'PRICE_CHANGED', 'DUPLICATE', 'VALIDATION', 'VERSION_MISMATCH');

-- CreateEnum
CREATE TYPE "ConflictStatus" AS ENUM ('OPEN', 'INVESTIGATING', 'RESOLVED', 'DISMISSED');

-- CreateEnum
CREATE TYPE "FeedType" AS ENUM ('CATALOG', 'PRICING', 'STOCK', 'CONFIGURATION', 'PERMISSIONS', 'RECEIPT_TEMPLATE');

-- CreateEnum
CREATE TYPE "ShiftStatus" AS ENUM ('OPEN', 'CLOSING', 'CLOSED', 'RECONCILED');

-- CreateEnum
CREATE TYPE "CashMovementType" AS ENUM ('CASH_IN', 'CASH_OUT', 'FLOAT_IN', 'FLOAT_OUT', 'SALE', 'REFUND');

-- CreateEnum
CREATE TYPE "SaleStatus" AS ENUM ('DRAFT', 'COMPLETED', 'VOIDED', 'FAILED');

-- CreateEnum
CREATE TYPE "SaleOrigin" AS ENUM ('ONLINE', 'OFFLINE_SYNC');

-- CreateEnum
CREATE TYPE "PaymentMethod" AS ENUM ('CASH', 'CARD', 'BANK_TRANSFER', 'MOBILE_MONEY', 'STORE_CREDIT', 'MIXED');

-- CreateEnum
CREATE TYPE "SalePaymentStatus" AS ENUM ('PENDING', 'CAPTURED', 'FAILED', 'REFUNDED');

-- CreateEnum
CREATE TYPE "ReturnStatus" AS ENUM ('REQUESTED', 'INSPECTED', 'APPROVED', 'REJECTED', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "InspectionResult" AS ENUM ('PENDING', 'ACCEPTED', 'PARTIALLY_ACCEPTED', 'REJECTED');

-- CreateEnum
CREATE TYPE "RefundStatus" AS ENUM ('PENDING', 'APPROVED', 'COMPLETED', 'FAILED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "ExchangeStatus" AS ENUM ('OPEN', 'COMPLETED', 'CANCELLED', 'EXPIRED');

-- CreateEnum
CREATE TYPE "ExchangeDirection" AS ENUM ('OUTGOING', 'INCOMING');

-- CreateEnum
CREATE TYPE "FollowUpStatus" AS ENUM ('OPEN', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "NotificationChannel" AS ENUM ('IN_APP', 'EMAIL', 'SMS');

-- CreateEnum
CREATE TYPE "NotificationSeverity" AS ENUM ('INFO', 'WARNING', 'CRITICAL');

-- CreateEnum
CREATE TYPE "NotificationStatus" AS ENUM ('UNREAD', 'READ', 'DISMISSED', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "DeliveryStatus" AS ENUM ('PENDING', 'SENT', 'FAILED');

-- CreateEnum
CREATE TYPE "ExportFormat" AS ENUM ('CSV', 'XLSX', 'PDF');

-- CreateEnum
CREATE TYPE "ExportStatus" AS ENUM ('QUEUED', 'RUNNING', 'COMPLETED', 'FAILED', 'EXPIRED');

-- CreateEnum
CREATE TYPE "ForecastModelStatus" AS ENUM ('ACTIVE', 'RETIRED', 'FAILED');

-- CreateEnum
CREATE TYPE "ForecastRunStatus" AS ENUM ('QUEUED', 'RUNNING', 'COMPLETED', 'FAILED');

-- CreateEnum
CREATE TYPE "ForecastScope" AS ENUM ('BUSINESS', 'BRANCH', 'PRODUCT');

-- CreateEnum
CREATE TYPE "RecommendationType" AS ENUM ('REORDER', 'TRANSFER', 'REDUCE_STOCK', 'PRICE_REVIEW');

-- CreateEnum
CREATE TYPE "RecommendationStatus" AS ENUM ('PROPOSED', 'ACCEPTED', 'REJECTED', 'EXPIRED', 'SUPERSEDED');

-- CreateEnum
CREATE TYPE "SupportCaseStatus" AS ENUM ('OPEN', 'IN_PROGRESS', 'RESOLVED', 'CLOSED');

-- CreateEnum
CREATE TYPE "SupportGrantStatus" AS ENUM ('ACTIVE', 'EXPIRED', 'REVOKED');

-- CreateEnum
CREATE TYPE "AuditActorType" AS ENUM ('USER', 'SYSTEM', 'SUPER_ADMIN_SUPPORT');

-- CreateEnum
CREATE TYPE "AuditOutcome" AS ENUM ('SUCCESS', 'FAILURE', 'DENIED');

-- CreateEnum
CREATE TYPE "LossRecordStatus" AS ENUM ('RECORDED', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "PosTerminalStatus" AS ENUM ('ACTIVE', 'INACTIVE', 'RETIRED');

-- CreateEnum
CREATE TYPE "ReceiptBlockStatus" AS ENUM ('ACTIVE', 'EXHAUSTED', 'REVOKED');

-- CreateEnum
CREATE TYPE "CustomerMergeStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'COMPLETED');

-- CreateEnum
CREATE TYPE "PaymentReconciliationTaskStatus" AS ENUM ('OPEN', 'RESOLVED', 'IGNORED');

-- CreateEnum
CREATE TYPE "ApprovalDecision" AS ENUM ('APPROVED', 'REJECTED');

-- CreateTable
CREATE TABLE "OutboxEvent" (
    "id" UUID NOT NULL,
    "businessId" UUID,
    "aggregateType" VARCHAR(64) NOT NULL,
    "aggregateId" UUID NOT NULL,
    "eventType" VARCHAR(128) NOT NULL,
    "payload" JSONB NOT NULL,
    "status" "OutboxStatus" NOT NULL DEFAULT 'PENDING',
    "attempts" INTEGER NOT NULL DEFAULT 0,
    "availableAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lockedAt" TIMESTAMPTZ(6),
    "lockedBy" VARCHAR(128),
    "lastError" TEXT,
    "correlationId" UUID,
    "occurredAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processedAt" TIMESTAMPTZ(6),

    CONSTRAINT "OutboxEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "IdempotencyRecord" (
    "id" UUID NOT NULL,
    "businessId" UUID,
    "scope" "IdempotencyScope" NOT NULL,
    "key" VARCHAR(256) NOT NULL,
    "requestHash" VARCHAR(64) NOT NULL,
    "responseStatus" INTEGER NOT NULL,
    "responseBody" JSONB NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "IdempotencyRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" UUID NOT NULL,
    "email" VARCHAR(254) NOT NULL,
    "phone" VARCHAR(32),
    "fullName" VARCHAR(200) NOT NULL,
    "status" "UserStatus" NOT NULL DEFAULT 'ACTIVE',
    "emailVerifiedAt" TIMESTAMPTZ(6),
    "lastLoginAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,
    "deactivatedAt" TIMESTAMPTZ(6),

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserCredential" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "algorithm" VARCHAR(32) NOT NULL DEFAULT 'argon2id',
    "pepperVersion" INTEGER NOT NULL DEFAULT 1,
    "changedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserCredential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserSession" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "familyId" UUID NOT NULL,
    "refreshHash" VARCHAR(128) NOT NULL,
    "ipAddress" VARCHAR(45),
    "userAgent" VARCHAR(512),
    "expiresAt" TIMESTAMPTZ(6) NOT NULL,
    "revokedAt" TIMESTAMPTZ(6),
    "lastUsedAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserSession_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmailVerificationToken" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "tokenHash" VARCHAR(128) NOT NULL,
    "expiresAt" TIMESTAMPTZ(6) NOT NULL,
    "consumedAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "EmailVerificationToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PasswordResetToken" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "tokenHash" VARCHAR(128) NOT NULL,
    "expiresAt" TIMESTAMPTZ(6) NOT NULL,
    "consumedAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PasswordResetToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Business" (
    "id" UUID NOT NULL,
    "name" VARCHAR(200) NOT NULL,
    "slug" VARCHAR(80) NOT NULL,
    "type" "BusinessType" NOT NULL,
    "status" "BusinessStatus" NOT NULL DEFAULT 'ACTIVE',
    "defaultCurrency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "timezone" VARCHAR(64) NOT NULL DEFAULT 'Africa/Addis_Ababa',
    "ownerMembershipId" UUID,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,
    "archivedAt" TIMESTAMPTZ(6),

    CONSTRAINT "Business_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Branch" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "name" VARCHAR(200) NOT NULL,
    "code" VARCHAR(32) NOT NULL,
    "addressLine1" VARCHAR(200),
    "addressLine2" VARCHAR(200),
    "city" VARCHAR(100),
    "region" VARCHAR(100),
    "phone" VARCHAR(32),
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,
    "archivedAt" TIMESTAMPTZ(6),

    CONSTRAINT "Branch_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Membership" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "roleId" UUID NOT NULL,
    "roleBusinessId" UUID,
    "status" "MembershipStatus" NOT NULL DEFAULT 'INVITED',
    "isOwner" BOOLEAN NOT NULL DEFAULT false,
    "authorizationVersion" INTEGER NOT NULL DEFAULT 1,
    "joinedAt" TIMESTAMPTZ(6),
    "deactivatedAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Membership_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MembershipBranchAssignment" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "membershipId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "assignedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revokedAt" TIMESTAMPTZ(6),

    CONSTRAINT "MembershipBranchAssignment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Invitation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "email" VARCHAR(254) NOT NULL,
    "roleId" UUID NOT NULL,
    "roleBusinessId" UUID,
    "invitedByMembershipId" UUID,
    "tokenHash" VARCHAR(128) NOT NULL,
    "status" "InvitationStatus" NOT NULL DEFAULT 'PENDING',
    "expiresAt" TIMESTAMPTZ(6) NOT NULL,
    "acceptedAt" TIMESTAMPTZ(6),
    "revokedAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Invitation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Permission" (
    "id" UUID NOT NULL,
    "code" VARCHAR(120) NOT NULL,
    "resource" VARCHAR(40) NOT NULL,
    "subject" VARCHAR(40) NOT NULL,
    "action" VARCHAR(40) NOT NULL,
    "scope" "PermissionScope" NOT NULL DEFAULT 'BRANCH',
    "description" VARCHAR(300),
    "isPhysical" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Role" (
    "id" UUID NOT NULL,
    "businessId" UUID,
    "code" VARCHAR(40) NOT NULL,
    "name" VARCHAR(120) NOT NULL,
    "description" VARCHAR(300),
    "isSystem" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RolePermission" (
    "roleId" UUID NOT NULL,
    "permissionId" UUID NOT NULL,

    CONSTRAINT "RolePermission_pkey" PRIMARY KEY ("roleId","permissionId")
);

-- CreateTable
CREATE TABLE "Employee" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "userId" UUID,
    "employeeCode" VARCHAR(40) NOT NULL,
    "fullName" VARCHAR(200) NOT NULL,
    "phone" VARCHAR(32),
    "email" VARCHAR(254),
    "status" "EmployeeStatus" NOT NULL DEFAULT 'ACTIVE',
    "hiredAt" DATE,
    "deactivatedAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Employee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmployeeBranchAssignment" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "employeeId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "startAt" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "endAt" DATE,

    CONSTRAINT "EmployeeBranchAssignment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmploymentStatusHistory" (
    "id" UUID NOT NULL,
    "employeeId" UUID NOT NULL,
    "status" "EmployeeStatus" NOT NULL,
    "reason" VARCHAR(300),
    "changedByUserId" UUID,
    "changedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "EmploymentStatusHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Plan" (
    "id" UUID NOT NULL,
    "code" VARCHAR(40) NOT NULL,
    "name" VARCHAR(120) NOT NULL,
    "description" VARCHAR(500),
    "status" "PlanStatus" NOT NULL DEFAULT 'DRAFT',
    "isPublic" BOOLEAN NOT NULL DEFAULT true,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Plan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlanFeature" (
    "id" UUID NOT NULL,
    "planId" UUID NOT NULL,
    "featureKey" VARCHAR(80) NOT NULL,
    "limitValue" INTEGER,
    "isUnlimited" BOOLEAN NOT NULL DEFAULT false,
    "unit" VARCHAR(32),

    CONSTRAINT "PlanFeature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlanPrice" (
    "id" UUID NOT NULL,
    "planId" UUID NOT NULL,
    "billingCycle" "BillingCycle" NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "amount" DECIMAL(18,2) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "PlanPrice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Subscription" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "planId" UUID NOT NULL,
    "status" "SubscriptionStatus" NOT NULL DEFAULT 'TRIALING',
    "billingCycle" "BillingCycle" NOT NULL DEFAULT 'MONTHLY',
    "trialStartedAt" TIMESTAMPTZ(6),
    "trialEndsAt" TIMESTAMPTZ(6),
    "currentPeriodStart" TIMESTAMPTZ(6),
    "currentPeriodEnd" TIMESTAMPTZ(6),
    "graceEndsAt" TIMESTAMPTZ(6),
    "cancelAtPeriodEnd" BOOLEAN NOT NULL DEFAULT false,
    "cancelledAt" TIMESTAMPTZ(6),
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Subscription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubscriptionHistory" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "subscriptionId" UUID NOT NULL,
    "eventType" "SubscriptionEventType" NOT NULL,
    "fromPlanId" UUID,
    "toPlanId" UUID,
    "effectiveAt" TIMESTAMPTZ(6) NOT NULL,
    "actorUserId" UUID,
    "metadata" JSONB,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SubscriptionHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubscriptionInvoice" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "subscriptionId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "periodStart" DATE NOT NULL,
    "periodEnd" DATE NOT NULL,
    "subtotal" DECIMAL(18,2) NOT NULL,
    "total" DECIMAL(18,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "status" "InvoiceStatus" NOT NULL DEFAULT 'ISSUED',
    "dueAt" TIMESTAMPTZ(6) NOT NULL,
    "issuedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "paidAt" TIMESTAMPTZ(6),

    CONSTRAINT "SubscriptionInvoice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaymentAttempt" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "subscriptionId" UUID NOT NULL,
    "invoiceId" UUID,
    "planId" UUID NOT NULL,
    "billingCycle" "BillingCycle" NOT NULL,
    "provider" "PaymentProvider" NOT NULL DEFAULT 'CHAPA',
    "txRef" VARCHAR(120) NOT NULL,
    "idempotencyKey" VARCHAR(120) NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "status" "PaymentAttemptStatus" NOT NULL DEFAULT 'PENDING',
    "checkoutUrl" VARCHAR(1000),
    "providerReference" VARCHAR(120),
    "requestedByUserId" UUID,
    "failureReason" VARCHAR(300),
    "rawPayload" JSONB,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMPTZ(6),
    "verifiedAt" TIMESTAMPTZ(6),

    CONSTRAINT "PaymentAttempt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaymentWebhookEvent" (
    "id" UUID NOT NULL,
    "businessId" UUID,
    "attemptId" UUID,
    "provider" "PaymentProvider" NOT NULL,
    "providerEventId" VARCHAR(120) NOT NULL,
    "eventType" VARCHAR(80) NOT NULL,
    "txRef" VARCHAR(120) NOT NULL,
    "signatureValid" BOOLEAN NOT NULL,
    "status" "WebhookStatus" NOT NULL DEFAULT 'RECEIVED',
    "outcome" VARCHAR(200),
    "payload" JSONB NOT NULL,
    "receivedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processedAt" TIMESTAMPTZ(6),

    CONSTRAINT "PaymentWebhookEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TrialGrant" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "startedAt" TIMESTAMPTZ(6) NOT NULL,
    "endsAt" TIMESTAMPTZ(6) NOT NULL,
    "endedAt" TIMESTAMPTZ(6),
    "reason" VARCHAR(300),

    CONSTRAINT "TrialGrant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UsageCounter" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "featureKey" VARCHAR(80) NOT NULL,
    "periodStart" DATE NOT NULL,
    "periodEnd" DATE NOT NULL,
    "usedValue" INTEGER NOT NULL DEFAULT 0,
    "limitValue" INTEGER,

    CONSTRAINT "UsageCounter_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaymentReconciliationTask" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "attemptId" UUID NOT NULL,
    "reason" VARCHAR(300) NOT NULL,
    "status" "PaymentReconciliationTaskStatus" NOT NULL DEFAULT 'OPEN',
    "resolutionNote" VARCHAR(500),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resolvedAt" TIMESTAMPTZ(6),

    CONSTRAINT "PaymentReconciliationTask_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlatformSetting" (
    "id" UUID NOT NULL,
    "key" VARCHAR(120) NOT NULL,
    "value" JSONB NOT NULL,
    "description" VARCHAR(300),
    "updatedByUserId" UUID,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "PlatformSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupportCase" (
    "id" UUID NOT NULL,
    "businessId" UUID,
    "reference" VARCHAR(40) NOT NULL,
    "subject" VARCHAR(200) NOT NULL,
    "status" "SupportCaseStatus" NOT NULL DEFAULT 'OPEN',
    "openedByUserId" UUID NOT NULL,
    "assignedToUserId" UUID,
    "notes" TEXT,
    "openedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "closedAt" TIMESTAMPTZ(6),

    CONSTRAINT "SupportCase_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupportAccessGrant" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supportUserId" UUID NOT NULL,
    "grantedByUserId" UUID NOT NULL,
    "caseId" UUID,
    "reason" VARCHAR(500) NOT NULL,
    "status" "SupportGrantStatus" NOT NULL DEFAULT 'ACTIVE',
    "startsAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMPTZ(6) NOT NULL,
    "revokedAt" TIMESTAMPTZ(6),

    CONSTRAINT "SupportAccessGrant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuditEvent" (
    "id" UUID NOT NULL,
    "businessId" UUID,
    "branchId" UUID,
    "actorType" "AuditActorType" NOT NULL,
    "actorUserId" UUID,
    "actorMembershipId" UUID,
    "supportGrantId" UUID,
    "action" VARCHAR(120) NOT NULL,
    "targetType" VARCHAR(80) NOT NULL,
    "targetId" UUID,
    "outcome" "AuditOutcome" NOT NULL DEFAULT 'SUCCESS',
    "correlationId" UUID,
    "ipAddress" VARCHAR(45),
    "userAgent" VARCHAR(512),
    "before" JSONB,
    "after" JSONB,
    "metadata" JSONB,
    "occurredAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AuditEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BusinessConfiguration" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "businessType" "BusinessType" NOT NULL,
    "locale" VARCHAR(16) NOT NULL DEFAULT 'en-ET',
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "timezone" VARCHAR(64) NOT NULL DEFAULT 'Africa/Addis_Ababa',
    "receiptHeader" VARCHAR(500),
    "receiptFooter" VARCHAR(500),
    "defaultLowStockThreshold" DECIMAL(18,3),
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "BusinessConfiguration_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BusinessSetting" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "key" VARCHAR(120) NOT NULL,
    "value" JSONB NOT NULL,
    "updatedByUserId" UUID,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "BusinessSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BranchSetting" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "key" VARCHAR(120) NOT NULL,
    "value" JSONB NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "BranchSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AttributeDefinition" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "entityType" "AttributeEntityType" NOT NULL,
    "key" VARCHAR(80) NOT NULL,
    "label" VARCHAR(120) NOT NULL,
    "dataType" "AttributeDataType" NOT NULL,
    "isRequired" BOOLEAN NOT NULL DEFAULT false,
    "isVariantAxis" BOOLEAN NOT NULL DEFAULT false,
    "unitId" UUID,
    "options" JSONB,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "archivedAt" TIMESTAMPTZ(6),

    CONSTRAINT "AttributeDefinition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Unit" (
    "id" UUID NOT NULL,
    "businessId" UUID,
    "code" VARCHAR(32) NOT NULL,
    "name" VARCHAR(80) NOT NULL,
    "kind" "UnitKind" NOT NULL,
    "baseUnitId" UUID,
    "factor" DECIMAL(18,6) NOT NULL DEFAULT 1,
    "isSystem" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Unit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnitConversion" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "fromUnitId" UUID NOT NULL,
    "toUnitId" UUID NOT NULL,
    "factor" DECIMAL(18,6) NOT NULL,

    CONSTRAINT "UnitConversion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CapabilityFlag" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "capability" VARCHAR(80) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "config" JSONB,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "CapabilityFlag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Brand" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "code" VARCHAR(40) NOT NULL,
    "name" VARCHAR(160) NOT NULL,
    "archivedAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Brand_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "parentId" UUID,
    "slug" VARCHAR(120) NOT NULL,
    "name" VARCHAR(160) NOT NULL,
    "path" VARCHAR(500),
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "archivedAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "sku" VARCHAR(80) NOT NULL,
    "name" VARCHAR(200) NOT NULL,
    "description" TEXT,
    "productType" "ProductType" NOT NULL DEFAULT 'STANDARD',
    "status" "ProductStatus" NOT NULL DEFAULT 'DRAFT',
    "brandId" UUID,
    "categoryId" UUID,
    "unitId" UUID,
    "isPerishable" BOOLEAN NOT NULL DEFAULT false,
    "shelfLifeDays" INTEGER,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,
    "archivedAt" TIMESTAMPTZ(6),

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductVariant" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "productId" UUID NOT NULL,
    "sku" VARCHAR(80) NOT NULL,
    "name" VARCHAR(200) NOT NULL,
    "status" "ProductStatus" NOT NULL DEFAULT 'ACTIVE',
    "unitId" UUID,
    "size" VARCHAR(40),
    "color" VARCHAR(60),
    "shade" VARCHAR(60),
    "isDefault" BOOLEAN NOT NULL DEFAULT false,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,
    "archivedAt" TIMESTAMPTZ(6),

    CONSTRAINT "ProductVariant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductAttributeValue" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "productId" UUID,
    "variantId" UUID,
    "attributeDefinitionId" UUID NOT NULL,
    "valueText" TEXT,
    "valueNumber" DECIMAL(18,4),
    "valueBoolean" BOOLEAN,
    "valueDate" DATE,
    "valueOption" VARCHAR(120),

    CONSTRAINT "ProductAttributeValue_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Barcode" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "barcode" VARCHAR(64) NOT NULL,
    "symbology" VARCHAR(20) NOT NULL DEFAULT 'EAN13',
    "isPrimary" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Barcode_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductMedia" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "productId" UUID,
    "variantId" UUID,
    "fileId" UUID NOT NULL,
    "role" "MediaRole" NOT NULL DEFAULT 'IMAGE',
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ProductMedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductImportJob" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "fileId" UUID,
    "status" "ImportStatus" NOT NULL DEFAULT 'PENDING',
    "importType" VARCHAR(40) NOT NULL DEFAULT 'PRODUCTS',
    "totalRows" INTEGER NOT NULL DEFAULT 0,
    "validRows" INTEGER NOT NULL DEFAULT 0,
    "errorRows" INTEGER NOT NULL DEFAULT 0,
    "issues" JSONB,
    "summary" JSONB,
    "requestedByUserId" UUID,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "startedAt" TIMESTAMPTZ(6),
    "completedAt" TIMESTAMPTZ(6),

    CONSTRAINT "ProductImportJob_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PriceList" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "name" VARCHAR(120) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "isDefault" BOOLEAN NOT NULL DEFAULT false,
    "priority" INTEGER NOT NULL DEFAULT 0,
    "status" "PriceListStatus" NOT NULL DEFAULT 'DRAFT',
    "effectiveFrom" TIMESTAMPTZ(6),
    "effectiveTo" TIMESTAMPTZ(6),
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "PriceList_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductPrice" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "priceListId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "effectiveFrom" TIMESTAMPTZ(6) NOT NULL,
    "effectiveTo" TIMESTAMPTZ(6),
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "ProductPrice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BranchPriceOverride" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "effectiveFrom" TIMESTAMPTZ(6) NOT NULL,
    "effectiveTo" TIMESTAMPTZ(6),
    "approvedByMembershipId" UUID,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "BranchPriceOverride_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PriceChangeHistory" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "priceListId" UUID,
    "branchId" UUID,
    "oldAmount" DECIMAL(18,2),
    "newAmount" DECIMAL(18,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "source" VARCHAR(40) NOT NULL,
    "reason" VARCHAR(300),
    "changedByUserId" UUID,
    "changedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PriceChangeHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Discount" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "code" VARCHAR(40) NOT NULL,
    "name" VARCHAR(160) NOT NULL,
    "type" "DiscountType" NOT NULL,
    "value" DECIMAL(18,2) NOT NULL,
    "scope" "DiscountScope" NOT NULL DEFAULT 'ORDER',
    "appliesToId" UUID,
    "branchId" UUID,
    "minQuantity" DECIMAL(18,3),
    "minSubtotal" DECIMAL(18,2),
    "startsAt" TIMESTAMPTZ(6),
    "endsAt" TIMESTAMPTZ(6),
    "maxUses" INTEGER,
    "usedCount" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Discount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FileObject" (
    "id" UUID NOT NULL,
    "businessId" UUID,
    "storageKey" VARCHAR(500) NOT NULL,
    "originalName" VARCHAR(255) NOT NULL,
    "mimeType" VARCHAR(120) NOT NULL,
    "sizeBytes" BIGINT NOT NULL,
    "checksumSha256" VARCHAR(64) NOT NULL,
    "status" "FileStatus" NOT NULL DEFAULT 'PENDING',
    "uploadedByUserId" UUID,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "availableAt" TIMESTAMPTZ(6),
    "archivedAt" TIMESTAMPTZ(6),

    CONSTRAINT "FileObject_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FileLink" (
    "id" UUID NOT NULL,
    "businessId" UUID,
    "fileId" UUID NOT NULL,
    "entityType" VARCHAR(80) NOT NULL,
    "entityId" UUID NOT NULL,
    "role" "FileLinkRole" NOT NULL DEFAULT 'ATTACHMENT',
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FileLink_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FileUploadSession" (
    "id" UUID NOT NULL,
    "businessId" UUID,
    "fileId" UUID,
    "tokenHash" VARCHAR(128) NOT NULL,
    "expiresAt" TIMESTAMPTZ(6) NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMPTZ(6),

    CONSTRAINT "FileUploadSession_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StockLocation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "code" VARCHAR(40) NOT NULL,
    "name" VARCHAR(120) NOT NULL,
    "type" "StockLocationType" NOT NULL DEFAULT 'SELLABLE',
    "isSellable" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "archivedAt" TIMESTAMPTZ(6),

    CONSTRAINT "StockLocation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StockBalance" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "quantityOnHand" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "quantityReserved" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "quantityInTransit" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "lastMovementAt" TIMESTAMPTZ(6),
    "version" INTEGER NOT NULL DEFAULT 1,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "StockBalance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StockMovement" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "batchId" UUID,
    "type" "StockMovementType" NOT NULL,
    "quantityDelta" DECIMAL(18,3) NOT NULL,
    "unitCost" DECIMAL(18,4),
    "totalCost" DECIMAL(18,2),
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "referenceType" VARCHAR(60) NOT NULL,
    "referenceId" UUID NOT NULL,
    "sourceKey" VARCHAR(160),
    "reason" VARCHAR(300),
    "actorMembershipId" UUID,
    "occurredAt" TIMESTAMPTZ(6) NOT NULL,
    "recordedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "StockMovement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InventoryBatch" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "batchNumber" VARCHAR(80) NOT NULL,
    "expiryDate" DATE,
    "receivedAt" TIMESTAMPTZ(6),
    "unitCost" DECIMAL(18,4) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "quantityReceived" DECIMAL(18,3) NOT NULL,
    "quantityRemaining" DECIMAL(18,3) NOT NULL,
    "status" "BatchStatus" NOT NULL DEFAULT 'ACTIVE',
    "locationId" UUID,
    "supplierId" UUID,
    "receiptLineId" UUID,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "InventoryBatch_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BatchMovementAllocation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "movementId" UUID NOT NULL,
    "batchId" UUID NOT NULL,
    "quantity" DECIMAL(18,3) NOT NULL,

    CONSTRAINT "BatchMovementAllocation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StocktakeSession" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "status" "StocktakeStatus" NOT NULL DEFAULT 'DRAFT',
    "startedByUserId" UUID,
    "approvedByUserId" UUID,
    "startedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMPTZ(6),
    "notes" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "StocktakeSession_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StocktakeLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "sessionId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "batchId" UUID,
    "systemQuantity" DECIMAL(18,3) NOT NULL,
    "countedQuantity" DECIMAL(18,3),
    "variance" DECIMAL(18,3),
    "countedByUserId" UUID,
    "countedAt" TIMESTAMPTZ(6),
    "notes" VARCHAR(300),

    CONSTRAINT "StocktakeLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InventoryAdjustment" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "type" "AdjustmentType" NOT NULL,
    "reason" "AdjustmentReason" NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "status" "AdjustmentStatus" NOT NULL DEFAULT 'DRAFT',
    "reasonText" TEXT NOT NULL,
    "stocktakeSessionId" UUID,
    "reconciliationExceptionId" UUID,
    "requestedByUserId" UUID,
    "approvedByUserId" UUID,
    "approvedAt" TIMESTAMPTZ(6),
    "appliedAt" TIMESTAMPTZ(6),
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "InventoryAdjustment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InventoryAdjustmentLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "adjustmentId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "batchId" UUID,
    "quantityDelta" DECIMAL(18,3) NOT NULL,
    "unitCost" DECIMAL(18,4),
    "notes" VARCHAR(300),

    CONSTRAINT "InventoryAdjustmentLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StockTransfer" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "fromBranchId" UUID NOT NULL,
    "toBranchId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "status" "TransferStatus" NOT NULL DEFAULT 'DRAFT',
    "requestedByUserId" UUID,
    "approvedByUserId" UUID,
    "approvedAt" TIMESTAMPTZ(6),
    "dispatchedAt" TIMESTAMPTZ(6),
    "receivedAt" TIMESTAMPTZ(6),
    "notes" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "StockTransfer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StockTransferLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "transferId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "requestedQuantity" DECIMAL(18,3) NOT NULL,
    "dispatchedQuantity" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "receivedQuantity" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "acceptedQuantity" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "rejectedQuantity" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "notes" VARCHAR(300),

    CONSTRAINT "StockTransferLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TransferReceipt" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "transferId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "receivedByUserId" UUID,
    "receivedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notes" TEXT,

    CONSTRAINT "TransferReceipt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TransferReceiptLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "transferId" UUID NOT NULL,
    "receiptId" UUID NOT NULL,
    "transferLineId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "quantityReceived" DECIMAL(18,3) NOT NULL,
    "quantityAccepted" DECIMAL(18,3) NOT NULL,
    "quantityRejected" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "batchId" UUID,
    "notes" VARCHAR(300),

    CONSTRAINT "TransferReceiptLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InventoryAlert" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID,
    "type" "AlertType" NOT NULL,
    "status" "AlertStatus" NOT NULL DEFAULT 'OPEN',
    "threshold" DECIMAL(18,3),
    "message" VARCHAR(300),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acknowledgedAt" TIMESTAMPTZ(6),
    "resolvedAt" TIMESTAMPTZ(6),

    CONSTRAINT "InventoryAlert_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StockReservation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "quantity" DECIMAL(18,3) NOT NULL,
    "sourceType" VARCHAR(40) NOT NULL,
    "sourceId" UUID NOT NULL,
    "status" "ReservationStatus" NOT NULL DEFAULT 'ACTIVE',
    "expiresAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "StockReservation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MinStockSetting" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "minQuantity" DECIMAL(18,3) NOT NULL,
    "reorderPoint" DECIMAL(18,3),
    "reorderQuantity" DECIMAL(18,3),
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "MinStockSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StockLossRecord" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "variantId" UUID NOT NULL,
    "batchId" UUID,
    "type" "LossType" NOT NULL,
    "quantity" DECIMAL(18,3) NOT NULL,
    "unitCost" DECIMAL(18,4),
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "reason" VARCHAR(300) NOT NULL,
    "status" "LossRecordStatus" NOT NULL DEFAULT 'RECORDED',
    "requestedByUserId" UUID,
    "approvedByUserId" UUID,
    "approvedAt" TIMESTAMPTZ(6),
    "movementId" UUID,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "StockLossRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InventoryValuationSnapshot" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "asOfDate" DATE NOT NULL,
    "quantity" DECIMAL(18,3) NOT NULL,
    "unitCost" DECIMAL(18,4) NOT NULL,
    "totalValue" DECIMAL(18,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "method" VARCHAR(40) NOT NULL DEFAULT 'WEIGHTED_AVERAGE_COST',
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InventoryValuationSnapshot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Supplier" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "code" VARCHAR(40) NOT NULL,
    "name" VARCHAR(200) NOT NULL,
    "status" "SupplierStatus" NOT NULL DEFAULT 'ACTIVE',
    "email" VARCHAR(254),
    "phone" VARCHAR(32),
    "address" VARCHAR(500),
    "taxId" VARCHAR(60),
    "paymentTermsDays" SMALLINT,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "notes" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,
    "archivedAt" TIMESTAMPTZ(6),

    CONSTRAINT "Supplier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierContact" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "name" VARCHAR(160) NOT NULL,
    "role" VARCHAR(80),
    "email" VARCHAR(254),
    "phone" VARCHAR(32),
    "isPrimary" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SupplierContact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierDocument" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "fileId" UUID NOT NULL,
    "type" VARCHAR(60) NOT NULL,
    "expiresAt" DATE,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SupplierDocument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierProduct" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "supplierSku" VARCHAR(80),
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "lastPrice" DECIMAL(18,4),
    "minOrderQty" DECIMAL(18,3),
    "orderMultiple" DECIMAL(18,3),
    "packagingNote" VARCHAR(200),
    "leadTimeDays" SMALLINT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "SupplierProduct_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierPriceHistory" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierProductId" UUID NOT NULL,
    "price" DECIMAL(18,4) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "effectiveFrom" TIMESTAMPTZ(6) NOT NULL,
    "effectiveTo" TIMESTAMPTZ(6),
    "recordedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SupplierPriceHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierPricingAgreement" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "reference" VARCHAR(60) NOT NULL,
    "status" "AgreementStatus" NOT NULL DEFAULT 'DRAFT',
    "startsAt" DATE NOT NULL,
    "endsAt" DATE,
    "notes" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "SupplierPricingAgreement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierAgreementLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "agreementId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "agreedPrice" DECIMAL(18,4) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "minQuantity" DECIMAL(18,3),

    CONSTRAINT "SupplierAgreementLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierRating" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "periodStart" DATE NOT NULL,
    "periodEnd" DATE NOT NULL,
    "qualityScore" DECIMAL(5,2) NOT NULL,
    "deliveryScore" DECIMAL(5,2) NOT NULL,
    "priceScore" DECIMAL(5,2) NOT NULL,
    "overallScore" DECIMAL(5,2) NOT NULL,
    "notes" TEXT,
    "ratedByUserId" UUID,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SupplierRating_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierDispute" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "reference" VARCHAR(60) NOT NULL,
    "status" "DisputeStatus" NOT NULL DEFAULT 'OPEN',
    "description" TEXT NOT NULL,
    "amount" DECIMAL(18,2),
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "openedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resolvedAt" TIMESTAMPTZ(6),
    "resolution" TEXT,

    CONSTRAINT "SupplierDispute_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierStatement" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "periodStart" DATE NOT NULL,
    "periodEnd" DATE NOT NULL,
    "openingBalance" DECIMAL(18,2) NOT NULL,
    "closingBalance" DECIMAL(18,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "generatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fileId" UUID,

    CONSTRAINT "SupplierStatement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierPerformanceSnapshot" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "periodStart" DATE NOT NULL,
    "periodEnd" DATE NOT NULL,
    "onTimeRate" DECIMAL(5,2) NOT NULL,
    "fillRate" DECIMAL(5,2) NOT NULL,
    "defectRate" DECIMAL(5,2) NOT NULL,
    "avgLeadDays" DECIMAL(6,2) NOT NULL,
    "disputeCount" INTEGER NOT NULL DEFAULT 0,
    "computedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SupplierPerformanceSnapshot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PurchaseRequest" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "status" "PurchaseRequestStatus" NOT NULL DEFAULT 'DRAFT',
    "requestedByUserId" UUID,
    "approvedByUserId" UUID,
    "approvedAt" TIMESTAMPTZ(6),
    "neededBy" DATE,
    "notes" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "PurchaseRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PurchaseRequestLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "requestId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "quantity" DECIMAL(18,3) NOT NULL,
    "reason" VARCHAR(300),

    CONSTRAINT "PurchaseRequestLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Rfq" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "status" "RfqStatus" NOT NULL DEFAULT 'DRAFT',
    "dueAt" TIMESTAMPTZ(6),
    "createdByUserId" UUID,
    "awardedQuotationId" UUID,
    "notes" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Rfq_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RfqVersion" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "rfqId" UUID NOT NULL,
    "versionNumber" INTEGER NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RfqVersion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RfqLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "rfqVersionId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "quantity" DECIMAL(18,3) NOT NULL,
    "targetPrice" DECIMAL(18,4),

    CONSTRAINT "RfqLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierQuotation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "rfqVersionId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "revision" INTEGER NOT NULL DEFAULT 1,
    "status" "QuotationStatus" NOT NULL DEFAULT 'RECEIVED',
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "total" DECIMAL(18,2) NOT NULL,
    "validUntil" DATE,
    "notes" TEXT,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "SupplierQuotation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QuotationLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "quotationId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "quantity" DECIMAL(18,3) NOT NULL,
    "unitPrice" DECIMAL(18,4) NOT NULL,
    "leadTimeDays" SMALLINT,

    CONSTRAINT "QuotationLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QuotationComparison" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "rfqVersionId" UUID NOT NULL,
    "recommendedQuotationId" UUID,
    "comparison" JSONB NOT NULL,
    "createdByUserId" UUID,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "QuotationComparison_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NegotiationRecord" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "rfqVersionId" UUID,
    "supplierId" UUID NOT NULL,
    "round" INTEGER NOT NULL DEFAULT 1,
    "notes" TEXT NOT NULL,
    "proposedByUserId" UUID,
    "attachmentFileId" UUID,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "NegotiationRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PurchaseOrder" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "status" "PurchaseOrderStatus" NOT NULL DEFAULT 'DRAFT',
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "subtotal" DECIMAL(18,2) NOT NULL,
    "total" DECIMAL(18,2) NOT NULL,
    "expectedAt" DATE,
    "createdByUserId" UUID,
    "approvedByUserId" UUID,
    "approvedAt" TIMESTAMPTZ(6),
    "sentAt" TIMESTAMPTZ(6),
    "closedAt" TIMESTAMPTZ(6),
    "currentRevision" INTEGER NOT NULL DEFAULT 1,
    "notes" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "PurchaseOrder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PurchaseOrderRevision" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "purchaseOrderId" UUID NOT NULL,
    "revisionNumber" INTEGER NOT NULL,
    "reason" VARCHAR(300),
    "snapshot" JSONB NOT NULL,
    "createdByUserId" UUID,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PurchaseOrderRevision_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PurchaseOrderLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "purchaseOrderId" UUID NOT NULL,
    "revisionNumber" INTEGER NOT NULL DEFAULT 1,
    "variantId" UUID NOT NULL,
    "orderedQuantity" DECIMAL(18,3) NOT NULL,
    "unitCost" DECIMAL(18,4) NOT NULL,
    "lineTotal" DECIMAL(18,2) NOT NULL,
    "notes" VARCHAR(300),
    "supersededAt" TIMESTAMPTZ(6),

    CONSTRAINT "PurchaseOrderLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PurchaseOrderApproval" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "purchaseOrderId" UUID NOT NULL,
    "decision" "ApprovalDecision" NOT NULL,
    "approvedByUserId" UUID,
    "decidedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notes" VARCHAR(300),

    CONSTRAINT "PurchaseOrderApproval_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierConfirmation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "purchaseOrderId" UUID NOT NULL,
    "confirmedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expectedAt" DATE,
    "confirmedBySupplier" VARCHAR(160),
    "notes" TEXT,

    CONSTRAINT "SupplierConfirmation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GoodsReceipt" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "purchaseOrderId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "status" "GoodsReceiptStatus" NOT NULL DEFAULT 'DRAFT',
    "receivedByUserId" UUID,
    "receivedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "supplierDeliveryNote" VARCHAR(120),
    "notes" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "GoodsReceipt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GoodsReceiptLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "purchaseOrderId" UUID NOT NULL,
    "receiptId" UUID NOT NULL,
    "purchaseOrderLineId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "receivedQuantity" DECIMAL(18,3) NOT NULL,
    "acceptedQuantity" DECIMAL(18,3) NOT NULL,
    "rejectedQuantity" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "damagedQuantity" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "unitCost" DECIMAL(18,4) NOT NULL,
    "batchNumber" VARCHAR(80),
    "expiryDate" DATE,
    "rejectionReason" VARCHAR(300),

    CONSTRAINT "GoodsReceiptLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierInvoice" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "purchaseOrderId" UUID,
    "number" VARCHAR(40) NOT NULL,
    "supplierInvoiceNumber" VARCHAR(80) NOT NULL,
    "issueDate" DATE NOT NULL,
    "dueDate" DATE NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "subtotal" DECIMAL(18,2) NOT NULL,
    "total" DECIMAL(18,2) NOT NULL,
    "status" "SupplierInvoiceStatus" NOT NULL DEFAULT 'RECEIVED',
    "matchStatus" "InvoiceMatchStatus" NOT NULL DEFAULT 'UNMATCHED',
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "SupplierInvoice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierInvoiceLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "supplierInvoiceId" UUID NOT NULL,
    "purchaseOrderId" UUID,
    "purchaseOrderLineId" UUID,
    "variantId" UUID,
    "description" VARCHAR(300),
    "quantity" DECIMAL(18,3) NOT NULL,
    "unitCost" DECIMAL(18,4) NOT NULL,
    "lineTotal" DECIMAL(18,2) NOT NULL,

    CONSTRAINT "SupplierInvoiceLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierPayment" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "method" "PaymentMethod" NOT NULL DEFAULT 'BANK_TRANSFER',
    "status" "SupplierPaymentStatus" NOT NULL DEFAULT 'SCHEDULED',
    "reference" VARCHAR(120),
    "paidAt" TIMESTAMPTZ(6),
    "recordedByUserId" UUID,
    "notes" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "SupplierPayment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaymentAllocation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "supplierPaymentId" UUID NOT NULL,
    "supplierInvoiceId" UUID NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,

    CONSTRAINT "PaymentAllocation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Customer" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "code" VARCHAR(40),
    "fullName" VARCHAR(200) NOT NULL,
    "phone" VARCHAR(32),
    "email" VARCHAR(254),
    "status" "CustomerStatus" NOT NULL DEFAULT 'ACTIVE',
    "notes" TEXT,
    "preferences" JSONB,
    "mergedIntoId" UUID,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,
    "archivedAt" TIMESTAMPTZ(6),

    CONSTRAINT "Customer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomerContact" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "customerId" UUID NOT NULL,
    "type" VARCHAR(32) NOT NULL,
    "value" VARCHAR(254) NOT NULL,
    "isPrimary" BOOLEAN NOT NULL DEFAULT false,
    "verifiedAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CustomerContact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomerConsent" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "customerId" UUID NOT NULL,
    "channel" "NotificationChannel" NOT NULL,
    "granted" BOOLEAN NOT NULL,
    "source" VARCHAR(80),
    "recordedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CustomerConsent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomerMergeRequest" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "sourceCustomerId" UUID NOT NULL,
    "targetCustomerId" UUID NOT NULL,
    "status" "CustomerMergeStatus" NOT NULL DEFAULT 'PENDING',
    "requestedByUserId" UUID,
    "decidedByUserId" UUID,
    "reason" VARCHAR(300),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "decidedAt" TIMESTAMPTZ(6),

    CONSTRAINT "CustomerMergeRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomerBusinessSummary" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "customerId" UUID NOT NULL,
    "totalSpend" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "purchaseCount" INTEGER NOT NULL DEFAULT 0,
    "lastPurchaseAt" TIMESTAMPTZ(6),
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "CustomerBusinessSummary_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Device" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "enrolledUserId" UUID NOT NULL,
    "deviceFingerprint" VARCHAR(200) NOT NULL,
    "name" VARCHAR(120) NOT NULL,
    "platform" VARCHAR(40),
    "status" "DeviceStatus" NOT NULL DEFAULT 'ACTIVE',
    "credentialHash" VARCHAR(128) NOT NULL,
    "credentialExpiresAt" TIMESTAMPTZ(6),
    "lastSeenAt" TIMESTAMPTZ(6),
    "enrolledAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revokedAt" TIMESTAMPTZ(6),
    "version" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "Device_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SyncSession" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "deviceId" UUID NOT NULL,
    "status" "SyncSessionStatus" NOT NULL DEFAULT 'OPEN',
    "clientVersion" VARCHAR(40),
    "operationCount" INTEGER NOT NULL DEFAULT 0,
    "acceptedCount" INTEGER NOT NULL DEFAULT 0,
    "duplicateCount" INTEGER NOT NULL DEFAULT 0,
    "conflictedCount" INTEGER NOT NULL DEFAULT 0,
    "rejectedCount" INTEGER NOT NULL DEFAULT 0,
    "startedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMPTZ(6),
    "error" TEXT,

    CONSTRAINT "SyncSession_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SyncOperation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "deviceId" UUID NOT NULL,
    "syncSessionId" UUID,
    "operationId" UUID NOT NULL,
    "type" VARCHAR(80) NOT NULL,
    "occurredAt" TIMESTAMPTZ(6) NOT NULL,
    "receivedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "payload" JSONB NOT NULL,
    "payloadHash" VARCHAR(64) NOT NULL,
    "status" "SyncOperationStatus" NOT NULL DEFAULT 'PENDING',
    "outcomeCode" VARCHAR(80),
    "outcomeMessage" VARCHAR(500),
    "canonicalType" VARCHAR(60),
    "canonicalId" UUID,
    "saleId" UUID,
    "attempts" INTEGER NOT NULL DEFAULT 0,
    "processedAt" TIMESTAMPTZ(6),

    CONSTRAINT "SyncOperation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SyncAttempt" (
    "id" UUID NOT NULL,
    "syncOperationId" UUID NOT NULL,
    "attemptNumber" INTEGER NOT NULL,
    "outcome" VARCHAR(40) NOT NULL,
    "code" VARCHAR(80),
    "message" VARCHAR(500),
    "durationMs" INTEGER,
    "attemptedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SyncAttempt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReconciliationException" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "deviceId" UUID NOT NULL,
    "syncOperationId" UUID NOT NULL,
    "cashierMembershipId" UUID,
    "assignedToMembershipId" UUID,
    "status" "ReconciliationStatus" NOT NULL DEFAULT 'OPEN',
    "failureCode" VARCHAR(80) NOT NULL DEFAULT 'INSUFFICIENT_STOCK',
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "recordedTotal" DECIMAL(18,2) NOT NULL,
    "originalPayload" JSONB NOT NULL,
    "payloadHash" VARCHAR(64) NOT NULL,
    "occurredAt" TIMESTAMPTZ(6) NOT NULL,
    "receivedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "investigationStartedAt" TIMESTAMPTZ(6),
    "releasedAt" TIMESTAMPTZ(6),
    "resolvedAt" TIMESTAMPTZ(6),
    "revalidationCount" INTEGER NOT NULL DEFAULT 0,
    "committedSaleId" UUID,
    "correctiveStocktakeId" UUID,
    "dispositionNotes" TEXT,

    CONSTRAINT "ReconciliationException_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReconciliationShortfallLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "exceptionId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "requestedQuantity" DECIMAL(18,3) NOT NULL,
    "availableQuantity" DECIMAL(18,3) NOT NULL,
    "shortfallQuantity" DECIMAL(18,3) NOT NULL,
    "unitPrice" DECIMAL(18,2) NOT NULL,

    CONSTRAINT "ReconciliationShortfallLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReconciliationEvent" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "exceptionId" UUID NOT NULL,
    "type" "ReconciliationEventType" NOT NULL,
    "actorMembershipId" UUID,
    "notes" TEXT,
    "evidenceFileId" UUID,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ReconciliationEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ConflictRecord" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "deviceId" UUID NOT NULL,
    "syncOperationId" UUID,
    "type" "ConflictType" NOT NULL,
    "status" "ConflictStatus" NOT NULL DEFAULT 'OPEN',
    "details" JSONB NOT NULL,
    "resolvedByUserId" UUID,
    "resolvedAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ConflictRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SyncCursor" (
    "id" UUID NOT NULL,
    "deviceId" UUID NOT NULL,
    "feedType" "FeedType" NOT NULL,
    "cursor" VARCHAR(200) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "SyncCursor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FeedEvent" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID,
    "feedType" "FeedType" NOT NULL,
    "entityType" VARCHAR(60) NOT NULL,
    "entityId" UUID NOT NULL,
    "changeType" VARCHAR(20) NOT NULL,
    "version" BIGINT NOT NULL DEFAULT 1,
    "payload" JSONB,
    "occurredAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FeedEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PosTerminal" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "code" VARCHAR(40) NOT NULL,
    "name" VARCHAR(120) NOT NULL,
    "status" "PosTerminalStatus" NOT NULL DEFAULT 'ACTIVE',
    "deviceId" UUID,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "archivedAt" TIMESTAMPTZ(6),

    CONSTRAINT "PosTerminal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CashierShift" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "terminalId" UUID NOT NULL,
    "cashierMembershipId" UUID NOT NULL,
    "status" "ShiftStatus" NOT NULL DEFAULT 'OPEN',
    "openingCash" DECIMAL(18,2) NOT NULL,
    "closingCash" DECIMAL(18,2),
    "expectedCash" DECIMAL(18,2),
    "variance" DECIMAL(18,2),
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "openedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "closedAt" TIMESTAMPTZ(6),
    "version" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "CashierShift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShiftCashMovement" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "shiftId" UUID NOT NULL,
    "type" "CashMovementType" NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "reason" VARCHAR(300),
    "recordedByUserId" UUID,
    "occurredAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ShiftCashMovement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sale" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "terminalId" UUID,
    "shiftId" UUID,
    "customerId" UUID,
    "cashierMembershipId" UUID NOT NULL,
    "receiptNumber" VARCHAR(60) NOT NULL,
    "status" "SaleStatus" NOT NULL DEFAULT 'COMPLETED',
    "origin" "SaleOrigin" NOT NULL DEFAULT 'ONLINE',
    "offlineDeviceId" UUID,
    "operationId" UUID,
    "subtotal" DECIMAL(18,2) NOT NULL,
    "discountTotal" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "total" DECIMAL(18,2) NOT NULL,
    "paidTotal" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "changeTotal" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "completedAt" TIMESTAMPTZ(6) NOT NULL,
    "voidedAt" TIMESTAMPTZ(6),
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Sale_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SaleLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "saleId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "productNameSnapshot" VARCHAR(200) NOT NULL,
    "skuSnapshot" VARCHAR(80) NOT NULL,
    "quantity" DECIMAL(18,3) NOT NULL,
    "unitPrice" DECIMAL(18,2) NOT NULL,
    "discountAmount" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "lineTotal" DECIMAL(18,2) NOT NULL,
    "unitCostSnapshot" DECIMAL(18,4),
    "batchId" UUID,

    CONSTRAINT "SaleLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SalePayment" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "saleId" UUID NOT NULL,
    "method" "PaymentMethod" NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "reference" VARCHAR(120),
    "provider" VARCHAR(40),
    "status" "SalePaymentStatus" NOT NULL DEFAULT 'CAPTURED',
    "receivedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SalePayment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SaleDiscount" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "saleId" UUID NOT NULL,
    "discountId" UUID,
    "code" VARCHAR(40),
    "type" "DiscountType" NOT NULL,
    "value" DECIMAL(18,2) NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "appliedTo" VARCHAR(40) NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SaleDiscount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SaleVoid" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "saleId" UUID NOT NULL,
    "reason" TEXT NOT NULL,
    "requestedByUserId" UUID,
    "approvedByUserId" UUID,
    "voidedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SaleVoid_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Receipt" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "saleId" UUID NOT NULL,
    "receiptNumber" VARCHAR(60) NOT NULL,
    "templateVersion" VARCHAR(40),
    "fileId" UUID,
    "printedAt" TIMESTAMPTZ(6),
    "reprintCount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Receipt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReceiptBlock" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "deviceId" UUID NOT NULL,
    "prefix" VARCHAR(40) NOT NULL,
    "startNumber" INTEGER NOT NULL,
    "endNumber" INTEGER NOT NULL,
    "nextNumber" INTEGER NOT NULL,
    "status" "ReceiptBlockStatus" NOT NULL DEFAULT 'ACTIVE',
    "issuedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "exhaustedAt" TIMESTAMPTZ(6),

    CONSTRAINT "ReceiptBlock_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SaleCustomerAssociation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "saleId" UUID NOT NULL,
    "customerId" UUID NOT NULL,
    "associatedByUserId" UUID,
    "method" VARCHAR(40) NOT NULL DEFAULT 'MANUAL',
    "associatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SaleCustomerAssociation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReturnRequest" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "saleId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "status" "ReturnStatus" NOT NULL DEFAULT 'REQUESTED',
    "reason" VARCHAR(300) NOT NULL,
    "requestedByUserId" UUID,
    "approvedByUserId" UUID,
    "requestedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "approvedAt" TIMESTAMPTZ(6),
    "version" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "ReturnRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReturnLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "returnId" UUID NOT NULL,
    "saleId" UUID NOT NULL,
    "saleLineId" UUID NOT NULL,
    "quantityRequested" DECIMAL(18,3) NOT NULL,
    "quantityApproved" DECIMAL(18,3),
    "inspectionResult" "InspectionResult" NOT NULL DEFAULT 'PENDING',
    "inspectionNote" VARCHAR(300),
    "restockQuantity" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "unitPrice" DECIMAL(18,2) NOT NULL,

    CONSTRAINT "ReturnLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReturnInspection" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "returnId" UUID NOT NULL,
    "inspectedByUserId" UUID,
    "inspectedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "result" "InspectionResult" NOT NULL DEFAULT 'PENDING',
    "notes" TEXT,

    CONSTRAINT "ReturnInspection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Refund" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "returnId" UUID NOT NULL,
    "saleId" UUID NOT NULL,
    "number" VARCHAR(40) NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "method" "PaymentMethod" NOT NULL,
    "status" "RefundStatus" NOT NULL DEFAULT 'PENDING',
    "approvedByUserId" UUID,
    "providerReference" VARCHAR(120),
    "idempotencyKey" VARCHAR(120),
    "completedAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Refund_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RefundAllocation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "saleId" UUID NOT NULL,
    "refundId" UUID NOT NULL,
    "salePaymentId" UUID NOT NULL,
    "amount" DECIMAL(18,2) NOT NULL,

    CONSTRAINT "RefundAllocation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Exchange" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "saleId" UUID NOT NULL,
    "returnId" UUID,
    "number" VARCHAR(40) NOT NULL,
    "status" "ExchangeStatus" NOT NULL DEFAULT 'OPEN',
    "priceDifference" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "completedAt" TIMESTAMPTZ(6),
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Exchange_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ExchangeLine" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "exchangeId" UUID NOT NULL,
    "direction" "ExchangeDirection" NOT NULL,
    "variantId" UUID NOT NULL,
    "quantity" DECIMAL(18,3) NOT NULL,
    "unitPrice" DECIMAL(18,2) NOT NULL,
    "lineTotal" DECIMAL(18,2) NOT NULL,

    CONSTRAINT "ExchangeLine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ExchangeReservation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "exchangeId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "quantity" DECIMAL(18,3) NOT NULL,
    "status" "ReservationStatus" NOT NULL DEFAULT 'ACTIVE',
    "expiresAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ExchangeReservation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CollectionFollowUp" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID,
    "customerId" UUID,
    "saleId" UUID,
    "returnId" UUID,
    "type" VARCHAR(60) NOT NULL,
    "dueAt" TIMESTAMPTZ(6),
    "status" "FollowUpStatus" NOT NULL DEFAULT 'OPEN',
    "assignedToUserId" UUID,
    "notes" TEXT,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMPTZ(6),

    CONSTRAINT "CollectionFollowUp_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NotificationTemplate" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "code" VARCHAR(80) NOT NULL,
    "channel" "NotificationChannel" NOT NULL,
    "locale" VARCHAR(10) NOT NULL DEFAULT 'en',
    "version" INTEGER NOT NULL DEFAULT 1,
    "subjectTemplate" VARCHAR(300),
    "bodyTemplate" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "NotificationTemplate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Notification" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID,
    "recipientUserId" UUID NOT NULL,
    "templateId" UUID,
    "channel" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "severity" "NotificationSeverity" NOT NULL DEFAULT 'INFO',
    "status" "NotificationStatus" NOT NULL DEFAULT 'UNREAD',
    "category" VARCHAR(60) NOT NULL,
    "title" VARCHAR(300) NOT NULL,
    "body" TEXT NOT NULL,
    "entityType" VARCHAR(60),
    "entityId" UUID,
    "dedupeKey" VARCHAR(120),
    "readAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMPTZ(6),

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NotificationDelivery" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "notificationId" UUID NOT NULL,
    "channel" "NotificationChannel" NOT NULL,
    "status" "DeliveryStatus" NOT NULL DEFAULT 'PENDING',
    "attemptCount" INTEGER NOT NULL DEFAULT 0,
    "lastAttemptAt" TIMESTAMPTZ(6),
    "sentAt" TIMESTAMPTZ(6),
    "providerMessageId" VARCHAR(200),
    "lastError" VARCHAR(500),

    CONSTRAINT "NotificationDelivery_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NotificationPreference" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "channel" "NotificationChannel" NOT NULL,
    "category" VARCHAR(60) NOT NULL,
    "isEnabled" BOOLEAN NOT NULL DEFAULT true,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "NotificationPreference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NotificationEscalation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "notificationId" UUID NOT NULL,
    "level" INTEGER NOT NULL DEFAULT 1,
    "status" "FollowUpStatus" NOT NULL DEFAULT 'OPEN',
    "escalatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acknowledgedAt" TIMESTAMPTZ(6),
    "notes" TEXT,

    CONSTRAINT "NotificationEscalation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReportDefinition" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "code" VARCHAR(80) NOT NULL,
    "name" VARCHAR(200) NOT NULL,
    "description" TEXT,
    "sourceModule" VARCHAR(60) NOT NULL,
    "parameters" JSONB,
    "isSystem" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "ReportDefinition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ExportJob" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID,
    "reportDefinitionId" UUID,
    "requestedByUserId" UUID,
    "format" "ExportFormat" NOT NULL DEFAULT 'CSV',
    "status" "ExportStatus" NOT NULL DEFAULT 'QUEUED',
    "parameters" JSONB,
    "filtersHash" VARCHAR(64),
    "rowCount" INTEGER,
    "fileId" UUID,
    "error" VARCHAR(500),
    "requestedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "startedAt" TIMESTAMPTZ(6),
    "completedAt" TIMESTAMPTZ(6),
    "expiresAt" TIMESTAMPTZ(6),

    CONSTRAINT "ExportJob_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SalesDailyFact" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "businessDate" DATE NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "grossSales" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "discountsTotal" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "netSales" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "refundsTotal" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "transactionCount" INTEGER NOT NULL DEFAULT 0,
    "itemCount" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "computedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SalesDailyFact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductSalesDailyFact" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "businessDate" DATE NOT NULL,
    "quantitySold" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "grossSales" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "netSales" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "costTotal" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "transactionCount" INTEGER NOT NULL DEFAULT 0,
    "computedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ProductSalesDailyFact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InventoryDailyFact" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "businessDate" DATE NOT NULL,
    "quantityOnHand" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "quantityReserved" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "quantityInTransit" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "inventoryValue" DECIMAL(18,2) NOT NULL DEFAULT 0,
    "computedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InventoryDailyFact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StockoutEvent" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "detectedAt" TIMESTAMPTZ(6) NOT NULL,
    "endedAt" TIMESTAMPTZ(6),
    "quantityAtStart" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "estimatedLostSales" DECIMAL(18,2),
    "source" VARCHAR(40) NOT NULL DEFAULT 'BALANCE',
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "StockoutEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ExpiryRiskFact" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID NOT NULL,
    "variantId" UUID NOT NULL,
    "batchId" UUID,
    "asOfDate" DATE NOT NULL,
    "expiryDate" DATE,
    "daysToExpiry" INTEGER,
    "quantityAtRisk" DECIMAL(18,3) NOT NULL,
    "valueAtRisk" DECIMAL(18,2) NOT NULL,
    "computedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ExpiryRiskFact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierPerformanceFact" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,
    "periodStart" DATE NOT NULL,
    "periodEnd" DATE NOT NULL,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'ETB',
    "onTimeRate" DECIMAL(5,4),
    "fillRate" DECIMAL(5,4),
    "qualityScore" DECIMAL(5,2),
    "averageLeadDays" DECIMAL(6,2),
    "disputeCount" INTEGER NOT NULL DEFAULT 0,
    "computedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SupplierPerformanceFact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ForecastModel" (
    "id" UUID NOT NULL,
    "name" VARCHAR(80) NOT NULL,
    "version" VARCHAR(40) NOT NULL,
    "status" "ForecastModelStatus" NOT NULL DEFAULT 'ACTIVE',
    "description" TEXT,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "retiredAt" TIMESTAMPTZ(6),

    CONSTRAINT "ForecastModel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ForecastRun" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID,
    "modelId" UUID NOT NULL,
    "scope" "ForecastScope" NOT NULL DEFAULT 'PRODUCT',
    "status" "ForecastRunStatus" NOT NULL DEFAULT 'QUEUED',
    "horizonDays" INTEGER NOT NULL,
    "inputsSnapshot" JSONB NOT NULL,
    "confidence" VARCHAR(20),
    "explanation" TEXT,
    "generatedAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "failureReason" VARCHAR(500),

    CONSTRAINT "ForecastRun_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ForecastPoint" (
    "id" UUID NOT NULL,
    "forecastRunId" UUID NOT NULL,
    "pointDate" DATE NOT NULL,
    "expected" DECIMAL(18,3) NOT NULL,
    "lowerBound" DECIMAL(18,3) NOT NULL,
    "upperBound" DECIMAL(18,3) NOT NULL,

    CONSTRAINT "ForecastPoint_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Recommendation" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "branchId" UUID,
    "forecastRunId" UUID,
    "variantId" UUID,
    "type" "RecommendationType" NOT NULL,
    "status" "RecommendationStatus" NOT NULL DEFAULT 'PROPOSED',
    "title" VARCHAR(200) NOT NULL,
    "rationale" TEXT NOT NULL,
    "proposedAction" JSONB NOT NULL,
    "confidence" VARCHAR(20),
    "reviewedByMembershipId" UUID,
    "reviewedAt" TIMESTAMPTZ(6),
    "decisionNote" TEXT,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMPTZ(6),

    CONSTRAINT "Recommendation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FeatureSnapshot" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "variantId" UUID,
    "snapshotDate" DATE NOT NULL,
    "features" JSONB NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FeatureSnapshot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ModelMetric" (
    "id" UUID NOT NULL,
    "businessId" UUID NOT NULL,
    "modelId" UUID NOT NULL,
    "forecastRunId" UUID,
    "metricName" VARCHAR(80) NOT NULL,
    "metricValue" DECIMAL(18,6) NOT NULL,
    "recordedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ModelMetric_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "OutboxEvent_status_availableAt_idx" ON "OutboxEvent"("status", "availableAt");

-- CreateIndex
CREATE INDEX "OutboxEvent_businessId_eventType_occurredAt_idx" ON "OutboxEvent"("businessId", "eventType", "occurredAt");

-- CreateIndex
CREATE UNIQUE INDEX "OutboxEvent_businessId_id_key" ON "OutboxEvent"("businessId", "id");

-- CreateIndex
CREATE INDEX "IdempotencyRecord_scope_key_idx" ON "IdempotencyRecord"("scope", "key");

-- CreateIndex
CREATE INDEX "IdempotencyRecord_expiresAt_idx" ON "IdempotencyRecord"("expiresAt");

-- CreateIndex
CREATE UNIQUE INDEX "IdempotencyRecord_businessId_scope_key_key" ON "IdempotencyRecord"("businessId", "scope", "key");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_phone_key" ON "User"("phone");

-- CreateIndex
CREATE INDEX "User_status_idx" ON "User"("status");

-- CreateIndex
CREATE UNIQUE INDEX "UserCredential_userId_key" ON "UserCredential"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "UserSession_refreshHash_key" ON "UserSession"("refreshHash");

-- CreateIndex
CREATE INDEX "UserSession_userId_revokedAt_idx" ON "UserSession"("userId", "revokedAt");

-- CreateIndex
CREATE INDEX "UserSession_familyId_idx" ON "UserSession"("familyId");

-- CreateIndex
CREATE INDEX "UserSession_expiresAt_idx" ON "UserSession"("expiresAt");

-- CreateIndex
CREATE UNIQUE INDEX "EmailVerificationToken_tokenHash_key" ON "EmailVerificationToken"("tokenHash");

-- CreateIndex
CREATE INDEX "EmailVerificationToken_userId_expiresAt_idx" ON "EmailVerificationToken"("userId", "expiresAt");

-- CreateIndex
CREATE UNIQUE INDEX "PasswordResetToken_tokenHash_key" ON "PasswordResetToken"("tokenHash");

-- CreateIndex
CREATE INDEX "PasswordResetToken_userId_expiresAt_idx" ON "PasswordResetToken"("userId", "expiresAt");

-- CreateIndex
CREATE UNIQUE INDEX "Business_slug_key" ON "Business"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Business_ownerMembershipId_key" ON "Business"("ownerMembershipId");

-- CreateIndex
CREATE UNIQUE INDEX "Business_id_ownerMembershipId_key" ON "Business"("id", "ownerMembershipId");

-- CreateIndex
CREATE INDEX "Branch_businessId_isActive_idx" ON "Branch"("businessId", "isActive");

-- CreateIndex
CREATE UNIQUE INDEX "Branch_businessId_code_key" ON "Branch"("businessId", "code");

-- CreateIndex
CREATE UNIQUE INDEX "Branch_businessId_id_key" ON "Branch"("businessId", "id");

-- CreateIndex
CREATE INDEX "Membership_userId_status_idx" ON "Membership"("userId", "status");

-- CreateIndex
CREATE INDEX "Membership_businessId_roleId_idx" ON "Membership"("businessId", "roleId");

-- CreateIndex
CREATE UNIQUE INDEX "Membership_businessId_userId_key" ON "Membership"("businessId", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "Membership_businessId_id_key" ON "Membership"("businessId", "id");

-- CreateIndex
CREATE INDEX "MembershipBranchAssignment_businessId_branchId_idx" ON "MembershipBranchAssignment"("businessId", "branchId");

-- CreateIndex
CREATE INDEX "MembershipBranchAssignment_membershipId_branchId_idx" ON "MembershipBranchAssignment"("membershipId", "branchId");

-- CreateIndex
CREATE UNIQUE INDEX "MembershipBranchAssignment_businessId_id_key" ON "MembershipBranchAssignment"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "Invitation_tokenHash_key" ON "Invitation"("tokenHash");

-- CreateIndex
CREATE INDEX "Invitation_businessId_status_idx" ON "Invitation"("businessId", "status");

-- CreateIndex
CREATE INDEX "Invitation_businessId_email_idx" ON "Invitation"("businessId", "email");

-- CreateIndex
CREATE UNIQUE INDEX "Invitation_businessId_id_key" ON "Invitation"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "Permission_code_key" ON "Permission"("code");

-- CreateIndex
CREATE INDEX "Permission_resource_subject_idx" ON "Permission"("resource", "subject");

-- CreateIndex
CREATE INDEX "Role_businessId_isSystem_idx" ON "Role"("businessId", "isSystem");

-- CreateIndex
CREATE UNIQUE INDEX "Role_businessId_code_key" ON "Role"("businessId", "code");

-- CreateIndex
CREATE UNIQUE INDEX "Role_businessId_id_key" ON "Role"("businessId", "id");

-- CreateIndex
CREATE INDEX "RolePermission_permissionId_idx" ON "RolePermission"("permissionId");

-- CreateIndex
CREATE INDEX "Employee_businessId_status_idx" ON "Employee"("businessId", "status");

-- CreateIndex
CREATE INDEX "Employee_userId_idx" ON "Employee"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_businessId_employeeCode_key" ON "Employee"("businessId", "employeeCode");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_businessId_id_key" ON "Employee"("businessId", "id");

-- CreateIndex
CREATE INDEX "EmployeeBranchAssignment_businessId_branchId_idx" ON "EmployeeBranchAssignment"("businessId", "branchId");

-- CreateIndex
CREATE UNIQUE INDEX "EmployeeBranchAssignment_employeeId_branchId_startAt_key" ON "EmployeeBranchAssignment"("employeeId", "branchId", "startAt");

-- CreateIndex
CREATE UNIQUE INDEX "EmployeeBranchAssignment_businessId_id_key" ON "EmployeeBranchAssignment"("businessId", "id");

-- CreateIndex
CREATE INDEX "EmploymentStatusHistory_employeeId_changedAt_idx" ON "EmploymentStatusHistory"("employeeId", "changedAt");

-- CreateIndex
CREATE UNIQUE INDEX "Plan_code_key" ON "Plan"("code");

-- CreateIndex
CREATE UNIQUE INDEX "PlanFeature_planId_featureKey_key" ON "PlanFeature"("planId", "featureKey");

-- CreateIndex
CREATE UNIQUE INDEX "PlanPrice_planId_billingCycle_currency_key" ON "PlanPrice"("planId", "billingCycle", "currency");

-- CreateIndex
CREATE UNIQUE INDEX "Subscription_businessId_key" ON "Subscription"("businessId");

-- CreateIndex
CREATE INDEX "Subscription_status_currentPeriodEnd_idx" ON "Subscription"("status", "currentPeriodEnd");

-- CreateIndex
CREATE UNIQUE INDEX "Subscription_businessId_id_key" ON "Subscription"("businessId", "id");

-- CreateIndex
CREATE INDEX "SubscriptionHistory_subscriptionId_effectiveAt_idx" ON "SubscriptionHistory"("subscriptionId", "effectiveAt");

-- CreateIndex
CREATE UNIQUE INDEX "SubscriptionHistory_businessId_id_key" ON "SubscriptionHistory"("businessId", "id");

-- CreateIndex
CREATE INDEX "SubscriptionInvoice_businessId_status_dueAt_idx" ON "SubscriptionInvoice"("businessId", "status", "dueAt");

-- CreateIndex
CREATE UNIQUE INDEX "SubscriptionInvoice_businessId_number_key" ON "SubscriptionInvoice"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "SubscriptionInvoice_businessId_id_key" ON "SubscriptionInvoice"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentAttempt_txRef_key" ON "PaymentAttempt"("txRef");

-- CreateIndex
CREATE INDEX "PaymentAttempt_businessId_status_createdAt_idx" ON "PaymentAttempt"("businessId", "status", "createdAt");

-- CreateIndex
CREATE INDEX "PaymentAttempt_txRef_idx" ON "PaymentAttempt"("txRef");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentAttempt_businessId_idempotencyKey_key" ON "PaymentAttempt"("businessId", "idempotencyKey");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentAttempt_provider_providerReference_key" ON "PaymentAttempt"("provider", "providerReference");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentAttempt_businessId_id_key" ON "PaymentAttempt"("businessId", "id");

-- CreateIndex
CREATE INDEX "PaymentWebhookEvent_txRef_receivedAt_idx" ON "PaymentWebhookEvent"("txRef", "receivedAt");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentWebhookEvent_provider_providerEventId_key" ON "PaymentWebhookEvent"("provider", "providerEventId");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentWebhookEvent_businessId_id_key" ON "PaymentWebhookEvent"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "TrialGrant_businessId_key" ON "TrialGrant"("businessId");

-- CreateIndex
CREATE UNIQUE INDEX "UsageCounter_businessId_featureKey_periodStart_key" ON "UsageCounter"("businessId", "featureKey", "periodStart");

-- CreateIndex
CREATE UNIQUE INDEX "UsageCounter_businessId_id_key" ON "UsageCounter"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentReconciliationTask_attemptId_key" ON "PaymentReconciliationTask"("attemptId");

-- CreateIndex
CREATE INDEX "PaymentReconciliationTask_businessId_status_idx" ON "PaymentReconciliationTask"("businessId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentReconciliationTask_businessId_id_key" ON "PaymentReconciliationTask"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentReconciliationTask_businessId_attemptId_key" ON "PaymentReconciliationTask"("businessId", "attemptId");

-- CreateIndex
CREATE UNIQUE INDEX "PlatformSetting_key_key" ON "PlatformSetting"("key");

-- CreateIndex
CREATE UNIQUE INDEX "SupportCase_reference_key" ON "SupportCase"("reference");

-- CreateIndex
CREATE UNIQUE INDEX "SupportCase_businessId_id_key" ON "SupportCase"("businessId", "id");

-- CreateIndex
CREATE INDEX "SupportAccessGrant_businessId_status_expiresAt_idx" ON "SupportAccessGrant"("businessId", "status", "expiresAt");

-- CreateIndex
CREATE INDEX "SupportAccessGrant_supportUserId_idx" ON "SupportAccessGrant"("supportUserId");

-- CreateIndex
CREATE UNIQUE INDEX "SupportAccessGrant_businessId_id_key" ON "SupportAccessGrant"("businessId", "id");

-- CreateIndex
CREATE INDEX "AuditEvent_businessId_branchId_occurredAt_idx" ON "AuditEvent"("businessId", "branchId", "occurredAt");

-- CreateIndex
CREATE INDEX "AuditEvent_actorUserId_occurredAt_idx" ON "AuditEvent"("actorUserId", "occurredAt");

-- CreateIndex
CREATE INDEX "AuditEvent_targetType_targetId_idx" ON "AuditEvent"("targetType", "targetId");

-- CreateIndex
CREATE INDEX "AuditEvent_action_occurredAt_idx" ON "AuditEvent"("action", "occurredAt");

-- CreateIndex
CREATE UNIQUE INDEX "AuditEvent_businessId_id_key" ON "AuditEvent"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "BusinessConfiguration_businessId_key" ON "BusinessConfiguration"("businessId");

-- CreateIndex
CREATE UNIQUE INDEX "BusinessSetting_businessId_key_key" ON "BusinessSetting"("businessId", "key");

-- CreateIndex
CREATE UNIQUE INDEX "BusinessSetting_businessId_id_key" ON "BusinessSetting"("businessId", "id");

-- CreateIndex
CREATE INDEX "BranchSetting_businessId_key_idx" ON "BranchSetting"("businessId", "key");

-- CreateIndex
CREATE UNIQUE INDEX "BranchSetting_branchId_key_key" ON "BranchSetting"("branchId", "key");

-- CreateIndex
CREATE UNIQUE INDEX "BranchSetting_businessId_id_key" ON "BranchSetting"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "AttributeDefinition_businessId_entityType_key_key" ON "AttributeDefinition"("businessId", "entityType", "key");

-- CreateIndex
CREATE UNIQUE INDEX "AttributeDefinition_businessId_id_key" ON "AttributeDefinition"("businessId", "id");

-- CreateIndex
CREATE INDEX "Unit_businessId_kind_idx" ON "Unit"("businessId", "kind");

-- CreateIndex
CREATE UNIQUE INDEX "Unit_businessId_code_key" ON "Unit"("businessId", "code");

-- CreateIndex
CREATE UNIQUE INDEX "Unit_businessId_id_key" ON "Unit"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "UnitConversion_businessId_fromUnitId_toUnitId_key" ON "UnitConversion"("businessId", "fromUnitId", "toUnitId");

-- CreateIndex
CREATE UNIQUE INDEX "UnitConversion_businessId_id_key" ON "UnitConversion"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "CapabilityFlag_businessId_capability_key" ON "CapabilityFlag"("businessId", "capability");

-- CreateIndex
CREATE UNIQUE INDEX "CapabilityFlag_businessId_id_key" ON "CapabilityFlag"("businessId", "id");

-- CreateIndex
CREATE INDEX "Brand_businessId_name_idx" ON "Brand"("businessId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "Brand_businessId_code_key" ON "Brand"("businessId", "code");

-- CreateIndex
CREATE UNIQUE INDEX "Brand_businessId_id_key" ON "Brand"("businessId", "id");

-- CreateIndex
CREATE INDEX "Category_businessId_parentId_sortOrder_idx" ON "Category"("businessId", "parentId", "sortOrder");

-- CreateIndex
CREATE UNIQUE INDEX "Category_businessId_slug_key" ON "Category"("businessId", "slug");

-- CreateIndex
CREATE UNIQUE INDEX "Category_businessId_id_key" ON "Category"("businessId", "id");

-- CreateIndex
CREATE INDEX "Product_businessId_status_idx" ON "Product"("businessId", "status");

-- CreateIndex
CREATE INDEX "Product_businessId_categoryId_idx" ON "Product"("businessId", "categoryId");

-- CreateIndex
CREATE INDEX "Product_businessId_brandId_idx" ON "Product"("businessId", "brandId");

-- CreateIndex
CREATE INDEX "Product_businessId_name_idx" ON "Product"("businessId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "Product_businessId_sku_key" ON "Product"("businessId", "sku");

-- CreateIndex
CREATE UNIQUE INDEX "Product_businessId_id_key" ON "Product"("businessId", "id");

-- CreateIndex
CREATE INDEX "ProductVariant_businessId_productId_idx" ON "ProductVariant"("businessId", "productId");

-- CreateIndex
CREATE INDEX "ProductVariant_businessId_status_idx" ON "ProductVariant"("businessId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "ProductVariant_businessId_sku_key" ON "ProductVariant"("businessId", "sku");

-- CreateIndex
CREATE UNIQUE INDEX "ProductVariant_businessId_id_key" ON "ProductVariant"("businessId", "id");

-- CreateIndex
CREATE INDEX "ProductAttributeValue_businessId_attributeDefinitionId_idx" ON "ProductAttributeValue"("businessId", "attributeDefinitionId");

-- CreateIndex
CREATE UNIQUE INDEX "ProductAttributeValue_productId_attributeDefinitionId_key" ON "ProductAttributeValue"("productId", "attributeDefinitionId");

-- CreateIndex
CREATE UNIQUE INDEX "ProductAttributeValue_variantId_attributeDefinitionId_key" ON "ProductAttributeValue"("variantId", "attributeDefinitionId");

-- CreateIndex
CREATE UNIQUE INDEX "ProductAttributeValue_businessId_id_key" ON "ProductAttributeValue"("businessId", "id");

-- CreateIndex
CREATE INDEX "Barcode_businessId_variantId_idx" ON "Barcode"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "Barcode_businessId_barcode_key" ON "Barcode"("businessId", "barcode");

-- CreateIndex
CREATE UNIQUE INDEX "Barcode_businessId_id_key" ON "Barcode"("businessId", "id");

-- CreateIndex
CREATE INDEX "ProductMedia_businessId_productId_idx" ON "ProductMedia"("businessId", "productId");

-- CreateIndex
CREATE INDEX "ProductMedia_businessId_variantId_idx" ON "ProductMedia"("businessId", "variantId");

-- CreateIndex
CREATE INDEX "ProductMedia_fileId_idx" ON "ProductMedia"("fileId");

-- CreateIndex
CREATE UNIQUE INDEX "ProductMedia_businessId_id_key" ON "ProductMedia"("businessId", "id");

-- CreateIndex
CREATE INDEX "ProductImportJob_businessId_status_idx" ON "ProductImportJob"("businessId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "ProductImportJob_businessId_id_key" ON "ProductImportJob"("businessId", "id");

-- CreateIndex
CREATE INDEX "PriceList_businessId_status_priority_idx" ON "PriceList"("businessId", "status", "priority");

-- CreateIndex
CREATE UNIQUE INDEX "PriceList_businessId_name_key" ON "PriceList"("businessId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "PriceList_businessId_id_key" ON "PriceList"("businessId", "id");

-- CreateIndex
CREATE INDEX "ProductPrice_businessId_variantId_effectiveFrom_idx" ON "ProductPrice"("businessId", "variantId", "effectiveFrom");

-- CreateIndex
CREATE UNIQUE INDEX "ProductPrice_priceListId_variantId_effectiveFrom_key" ON "ProductPrice"("priceListId", "variantId", "effectiveFrom");

-- CreateIndex
CREATE UNIQUE INDEX "ProductPrice_businessId_id_key" ON "ProductPrice"("businessId", "id");

-- CreateIndex
CREATE INDEX "BranchPriceOverride_businessId_variantId_effectiveFrom_idx" ON "BranchPriceOverride"("businessId", "variantId", "effectiveFrom");

-- CreateIndex
CREATE UNIQUE INDEX "BranchPriceOverride_branchId_variantId_effectiveFrom_key" ON "BranchPriceOverride"("branchId", "variantId", "effectiveFrom");

-- CreateIndex
CREATE UNIQUE INDEX "BranchPriceOverride_businessId_id_key" ON "BranchPriceOverride"("businessId", "id");

-- CreateIndex
CREATE INDEX "PriceChangeHistory_businessId_variantId_changedAt_idx" ON "PriceChangeHistory"("businessId", "variantId", "changedAt");

-- CreateIndex
CREATE INDEX "PriceChangeHistory_businessId_branchId_changedAt_idx" ON "PriceChangeHistory"("businessId", "branchId", "changedAt");

-- CreateIndex
CREATE UNIQUE INDEX "PriceChangeHistory_businessId_id_key" ON "PriceChangeHistory"("businessId", "id");

-- CreateIndex
CREATE INDEX "Discount_businessId_isActive_startsAt_endsAt_idx" ON "Discount"("businessId", "isActive", "startsAt", "endsAt");

-- CreateIndex
CREATE UNIQUE INDEX "Discount_businessId_code_key" ON "Discount"("businessId", "code");

-- CreateIndex
CREATE UNIQUE INDEX "Discount_businessId_id_key" ON "Discount"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "FileObject_storageKey_key" ON "FileObject"("storageKey");

-- CreateIndex
CREATE INDEX "FileObject_businessId_status_idx" ON "FileObject"("businessId", "status");

-- CreateIndex
CREATE INDEX "FileObject_createdAt_idx" ON "FileObject"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "FileObject_businessId_id_key" ON "FileObject"("businessId", "id");

-- CreateIndex
CREATE INDEX "FileLink_businessId_entityType_entityId_idx" ON "FileLink"("businessId", "entityType", "entityId");

-- CreateIndex
CREATE UNIQUE INDEX "FileLink_fileId_entityType_entityId_role_key" ON "FileLink"("fileId", "entityType", "entityId", "role");

-- CreateIndex
CREATE UNIQUE INDEX "FileLink_businessId_id_key" ON "FileLink"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "FileUploadSession_tokenHash_key" ON "FileUploadSession"("tokenHash");

-- CreateIndex
CREATE INDEX "FileUploadSession_expiresAt_idx" ON "FileUploadSession"("expiresAt");

-- CreateIndex
CREATE UNIQUE INDEX "FileUploadSession_businessId_id_key" ON "FileUploadSession"("businessId", "id");

-- CreateIndex
CREATE INDEX "StockLocation_businessId_branchId_idx" ON "StockLocation"("businessId", "branchId");

-- CreateIndex
CREATE UNIQUE INDEX "StockLocation_branchId_code_key" ON "StockLocation"("branchId", "code");

-- CreateIndex
CREATE UNIQUE INDEX "StockLocation_businessId_id_key" ON "StockLocation"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "StockLocation_businessId_branchId_id_key" ON "StockLocation"("businessId", "branchId", "id");

-- CreateIndex
CREATE INDEX "StockBalance_businessId_branchId_quantityOnHand_idx" ON "StockBalance"("businessId", "branchId", "quantityOnHand");

-- CreateIndex
CREATE INDEX "StockBalance_businessId_variantId_idx" ON "StockBalance"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "StockBalance_branchId_variantId_key" ON "StockBalance"("branchId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "StockBalance_businessId_id_key" ON "StockBalance"("businessId", "id");

-- CreateIndex
CREATE INDEX "StockMovement_businessId_branchId_variantId_occurredAt_idx" ON "StockMovement"("businessId", "branchId", "variantId", "occurredAt");

-- CreateIndex
CREATE INDEX "StockMovement_businessId_referenceType_referenceId_idx" ON "StockMovement"("businessId", "referenceType", "referenceId");

-- CreateIndex
CREATE INDEX "StockMovement_businessId_batchId_recordedAt_idx" ON "StockMovement"("businessId", "batchId", "recordedAt");

-- CreateIndex
CREATE UNIQUE INDEX "StockMovement_businessId_id_key" ON "StockMovement"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "StockMovement_businessId_branchId_variantId_id_key" ON "StockMovement"("businessId", "branchId", "variantId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "StockMovement_businessId_sourceKey_key" ON "StockMovement"("businessId", "sourceKey");

-- CreateIndex
CREATE INDEX "InventoryBatch_businessId_branchId_expiryDate_idx" ON "InventoryBatch"("businessId", "branchId", "expiryDate");

-- CreateIndex
CREATE INDEX "InventoryBatch_businessId_variantId_status_idx" ON "InventoryBatch"("businessId", "variantId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "InventoryBatch_businessId_id_key" ON "InventoryBatch"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "InventoryBatch_businessId_branchId_variantId_id_key" ON "InventoryBatch"("businessId", "branchId", "variantId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "InventoryBatch_branchId_variantId_batchNumber_key" ON "InventoryBatch"("branchId", "variantId", "batchNumber");

-- CreateIndex
CREATE INDEX "BatchMovementAllocation_businessId_batchId_idx" ON "BatchMovementAllocation"("businessId", "batchId");

-- CreateIndex
CREATE INDEX "BatchMovementAllocation_businessId_branchId_variantId_idx" ON "BatchMovementAllocation"("businessId", "branchId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "BatchMovementAllocation_movementId_batchId_key" ON "BatchMovementAllocation"("movementId", "batchId");

-- CreateIndex
CREATE UNIQUE INDEX "BatchMovementAllocation_businessId_id_key" ON "BatchMovementAllocation"("businessId", "id");

-- CreateIndex
CREATE INDEX "StocktakeSession_businessId_branchId_status_idx" ON "StocktakeSession"("businessId", "branchId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "StocktakeSession_businessId_number_key" ON "StocktakeSession"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "StocktakeSession_businessId_id_key" ON "StocktakeSession"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "StocktakeSession_businessId_branchId_id_key" ON "StocktakeSession"("businessId", "branchId", "id");

-- CreateIndex
CREATE INDEX "StocktakeLine_businessId_variantId_idx" ON "StocktakeLine"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "StocktakeLine_sessionId_variantId_batchId_key" ON "StocktakeLine"("sessionId", "variantId", "batchId");

-- CreateIndex
CREATE UNIQUE INDEX "StocktakeLine_businessId_id_key" ON "StocktakeLine"("businessId", "id");

-- CreateIndex
CREATE INDEX "InventoryAdjustment_businessId_branchId_status_idx" ON "InventoryAdjustment"("businessId", "branchId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "InventoryAdjustment_businessId_number_key" ON "InventoryAdjustment"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "InventoryAdjustment_businessId_id_key" ON "InventoryAdjustment"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "InventoryAdjustment_businessId_branchId_id_key" ON "InventoryAdjustment"("businessId", "branchId", "id");

-- CreateIndex
CREATE INDEX "InventoryAdjustmentLine_businessId_variantId_idx" ON "InventoryAdjustmentLine"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "InventoryAdjustmentLine_businessId_id_key" ON "InventoryAdjustmentLine"("businessId", "id");

-- CreateIndex
CREATE INDEX "StockTransfer_businessId_status_idx" ON "StockTransfer"("businessId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "StockTransfer_businessId_number_key" ON "StockTransfer"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "StockTransfer_businessId_id_key" ON "StockTransfer"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "StockTransfer_businessId_id_toBranchId_key" ON "StockTransfer"("businessId", "id", "toBranchId");

-- CreateIndex
CREATE INDEX "StockTransferLine_businessId_variantId_idx" ON "StockTransferLine"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "StockTransferLine_transferId_variantId_key" ON "StockTransferLine"("transferId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "StockTransferLine_businessId_id_key" ON "StockTransferLine"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "StockTransferLine_businessId_transferId_id_variantId_key" ON "StockTransferLine"("businessId", "transferId", "id", "variantId");

-- CreateIndex
CREATE INDEX "TransferReceipt_businessId_transferId_idx" ON "TransferReceipt"("businessId", "transferId");

-- CreateIndex
CREATE UNIQUE INDEX "TransferReceipt_businessId_number_key" ON "TransferReceipt"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "TransferReceipt_businessId_id_key" ON "TransferReceipt"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "TransferReceipt_businessId_transferId_id_key" ON "TransferReceipt"("businessId", "transferId", "id");

-- CreateIndex
CREATE INDEX "TransferReceiptLine_businessId_variantId_idx" ON "TransferReceiptLine"("businessId", "variantId");

-- CreateIndex
CREATE INDEX "TransferReceiptLine_businessId_transferId_idx" ON "TransferReceiptLine"("businessId", "transferId");

-- CreateIndex
CREATE UNIQUE INDEX "TransferReceiptLine_receiptId_transferLineId_key" ON "TransferReceiptLine"("receiptId", "transferLineId");

-- CreateIndex
CREATE UNIQUE INDEX "TransferReceiptLine_businessId_id_key" ON "TransferReceiptLine"("businessId", "id");

-- CreateIndex
CREATE INDEX "InventoryAlert_businessId_branchId_status_idx" ON "InventoryAlert"("businessId", "branchId", "status");

-- CreateIndex
CREATE INDEX "InventoryAlert_businessId_variantId_type_idx" ON "InventoryAlert"("businessId", "variantId", "type");

-- CreateIndex
CREATE UNIQUE INDEX "InventoryAlert_businessId_id_key" ON "InventoryAlert"("businessId", "id");

-- CreateIndex
CREATE INDEX "StockReservation_businessId_branchId_status_idx" ON "StockReservation"("businessId", "branchId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "StockReservation_sourceType_sourceId_variantId_key" ON "StockReservation"("sourceType", "sourceId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "StockReservation_businessId_id_key" ON "StockReservation"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "MinStockSetting_branchId_variantId_key" ON "MinStockSetting"("branchId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "MinStockSetting_businessId_id_key" ON "MinStockSetting"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "StockLossRecord_movementId_key" ON "StockLossRecord"("movementId");

-- CreateIndex
CREATE INDEX "StockLossRecord_businessId_branchId_type_createdAt_idx" ON "StockLossRecord"("businessId", "branchId", "type", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "StockLossRecord_businessId_number_key" ON "StockLossRecord"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "StockLossRecord_businessId_id_key" ON "StockLossRecord"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "StockLossRecord_businessId_movementId_key" ON "StockLossRecord"("businessId", "movementId");

-- CreateIndex
CREATE UNIQUE INDEX "StockLossRecord_businessId_branchId_variantId_movementId_key" ON "StockLossRecord"("businessId", "branchId", "variantId", "movementId");

-- CreateIndex
CREATE INDEX "InventoryValuationSnapshot_businessId_asOfDate_idx" ON "InventoryValuationSnapshot"("businessId", "asOfDate");

-- CreateIndex
CREATE UNIQUE INDEX "InventoryValuationSnapshot_branchId_variantId_asOfDate_key" ON "InventoryValuationSnapshot"("branchId", "variantId", "asOfDate");

-- CreateIndex
CREATE UNIQUE INDEX "InventoryValuationSnapshot_businessId_id_key" ON "InventoryValuationSnapshot"("businessId", "id");

-- CreateIndex
CREATE INDEX "Supplier_businessId_status_idx" ON "Supplier"("businessId", "status");

-- CreateIndex
CREATE INDEX "Supplier_businessId_name_idx" ON "Supplier"("businessId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "Supplier_businessId_code_key" ON "Supplier"("businessId", "code");

-- CreateIndex
CREATE UNIQUE INDEX "Supplier_businessId_id_key" ON "Supplier"("businessId", "id");

-- CreateIndex
CREATE INDEX "SupplierContact_businessId_supplierId_idx" ON "SupplierContact"("businessId", "supplierId");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierContact_businessId_id_key" ON "SupplierContact"("businessId", "id");

-- CreateIndex
CREATE INDEX "SupplierDocument_businessId_supplierId_idx" ON "SupplierDocument"("businessId", "supplierId");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierDocument_supplierId_fileId_type_key" ON "SupplierDocument"("supplierId", "fileId", "type");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierDocument_businessId_id_key" ON "SupplierDocument"("businessId", "id");

-- CreateIndex
CREATE INDEX "SupplierProduct_businessId_variantId_idx" ON "SupplierProduct"("businessId", "variantId");

-- CreateIndex
CREATE INDEX "SupplierProduct_businessId_supplierSku_idx" ON "SupplierProduct"("businessId", "supplierSku");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierProduct_supplierId_variantId_key" ON "SupplierProduct"("supplierId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierProduct_businessId_id_key" ON "SupplierProduct"("businessId", "id");

-- CreateIndex
CREATE INDEX "SupplierPriceHistory_supplierProductId_effectiveFrom_idx" ON "SupplierPriceHistory"("supplierProductId", "effectiveFrom");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierPriceHistory_businessId_id_key" ON "SupplierPriceHistory"("businessId", "id");

-- CreateIndex
CREATE INDEX "SupplierPricingAgreement_businessId_supplierId_status_idx" ON "SupplierPricingAgreement"("businessId", "supplierId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierPricingAgreement_businessId_reference_key" ON "SupplierPricingAgreement"("businessId", "reference");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierPricingAgreement_businessId_id_key" ON "SupplierPricingAgreement"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierAgreementLine_agreementId_variantId_key" ON "SupplierAgreementLine"("agreementId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierAgreementLine_businessId_id_key" ON "SupplierAgreementLine"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierRating_supplierId_periodStart_periodEnd_key" ON "SupplierRating"("supplierId", "periodStart", "periodEnd");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierRating_businessId_id_key" ON "SupplierRating"("businessId", "id");

-- CreateIndex
CREATE INDEX "SupplierDispute_businessId_supplierId_status_idx" ON "SupplierDispute"("businessId", "supplierId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierDispute_businessId_reference_key" ON "SupplierDispute"("businessId", "reference");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierDispute_businessId_id_key" ON "SupplierDispute"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierStatement_supplierId_periodStart_periodEnd_key" ON "SupplierStatement"("supplierId", "periodStart", "periodEnd");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierStatement_businessId_id_key" ON "SupplierStatement"("businessId", "id");

-- CreateIndex
CREATE INDEX "SupplierPerformanceSnapshot_businessId_periodEnd_idx" ON "SupplierPerformanceSnapshot"("businessId", "periodEnd");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierPerformanceSnapshot_supplierId_periodStart_periodEn_key" ON "SupplierPerformanceSnapshot"("supplierId", "periodStart", "periodEnd");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierPerformanceSnapshot_businessId_id_key" ON "SupplierPerformanceSnapshot"("businessId", "id");

-- CreateIndex
CREATE INDEX "PurchaseRequest_businessId_branchId_status_idx" ON "PurchaseRequest"("businessId", "branchId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseRequest_businessId_number_key" ON "PurchaseRequest"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseRequest_businessId_id_key" ON "PurchaseRequest"("businessId", "id");

-- CreateIndex
CREATE INDEX "PurchaseRequestLine_businessId_variantId_idx" ON "PurchaseRequestLine"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseRequestLine_businessId_id_key" ON "PurchaseRequestLine"("businessId", "id");

-- CreateIndex
CREATE INDEX "Rfq_businessId_branchId_status_idx" ON "Rfq"("businessId", "branchId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "Rfq_businessId_number_key" ON "Rfq"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "Rfq_businessId_id_key" ON "Rfq"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "RfqVersion_rfqId_versionNumber_key" ON "RfqVersion"("rfqId", "versionNumber");

-- CreateIndex
CREATE UNIQUE INDEX "RfqVersion_businessId_id_key" ON "RfqVersion"("businessId", "id");

-- CreateIndex
CREATE INDEX "RfqLine_businessId_variantId_idx" ON "RfqLine"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "RfqLine_businessId_id_key" ON "RfqLine"("businessId", "id");

-- CreateIndex
CREATE INDEX "SupplierQuotation_businessId_supplierId_status_idx" ON "SupplierQuotation"("businessId", "supplierId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierQuotation_rfqVersionId_supplierId_revision_key" ON "SupplierQuotation"("rfqVersionId", "supplierId", "revision");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierQuotation_businessId_id_key" ON "SupplierQuotation"("businessId", "id");

-- CreateIndex
CREATE INDEX "QuotationLine_businessId_variantId_idx" ON "QuotationLine"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "QuotationLine_businessId_id_key" ON "QuotationLine"("businessId", "id");

-- CreateIndex
CREATE INDEX "QuotationComparison_businessId_rfqVersionId_idx" ON "QuotationComparison"("businessId", "rfqVersionId");

-- CreateIndex
CREATE UNIQUE INDEX "QuotationComparison_businessId_id_key" ON "QuotationComparison"("businessId", "id");

-- CreateIndex
CREATE INDEX "NegotiationRecord_businessId_supplierId_createdAt_idx" ON "NegotiationRecord"("businessId", "supplierId", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "NegotiationRecord_businessId_id_key" ON "NegotiationRecord"("businessId", "id");

-- CreateIndex
CREATE INDEX "PurchaseOrder_businessId_branchId_status_idx" ON "PurchaseOrder"("businessId", "branchId", "status");

-- CreateIndex
CREATE INDEX "PurchaseOrder_businessId_supplierId_status_idx" ON "PurchaseOrder"("businessId", "supplierId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseOrder_businessId_number_key" ON "PurchaseOrder"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseOrder_businessId_id_key" ON "PurchaseOrder"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseOrder_businessId_id_branchId_key" ON "PurchaseOrder"("businessId", "id", "branchId");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseOrder_businessId_supplierId_id_key" ON "PurchaseOrder"("businessId", "supplierId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseOrderRevision_purchaseOrderId_revisionNumber_key" ON "PurchaseOrderRevision"("purchaseOrderId", "revisionNumber");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseOrderRevision_businessId_id_key" ON "PurchaseOrderRevision"("businessId", "id");

-- CreateIndex
CREATE INDEX "PurchaseOrderLine_businessId_variantId_idx" ON "PurchaseOrderLine"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseOrderLine_purchaseOrderId_variantId_revisionNumber_key" ON "PurchaseOrderLine"("purchaseOrderId", "variantId", "revisionNumber");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseOrderLine_businessId_id_key" ON "PurchaseOrderLine"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseOrderLine_businessId_purchaseOrderId_id_key" ON "PurchaseOrderLine"("businessId", "purchaseOrderId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseOrderLine_businessId_purchaseOrderId_id_variantId_key" ON "PurchaseOrderLine"("businessId", "purchaseOrderId", "id", "variantId");

-- CreateIndex
CREATE INDEX "PurchaseOrderApproval_businessId_purchaseOrderId_decidedAt_idx" ON "PurchaseOrderApproval"("businessId", "purchaseOrderId", "decidedAt");

-- CreateIndex
CREATE UNIQUE INDEX "PurchaseOrderApproval_businessId_id_key" ON "PurchaseOrderApproval"("businessId", "id");

-- CreateIndex
CREATE INDEX "SupplierConfirmation_businessId_purchaseOrderId_confirmedAt_idx" ON "SupplierConfirmation"("businessId", "purchaseOrderId", "confirmedAt");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierConfirmation_businessId_id_key" ON "SupplierConfirmation"("businessId", "id");

-- CreateIndex
CREATE INDEX "GoodsReceipt_businessId_branchId_status_idx" ON "GoodsReceipt"("businessId", "branchId", "status");

-- CreateIndex
CREATE INDEX "GoodsReceipt_businessId_purchaseOrderId_idx" ON "GoodsReceipt"("businessId", "purchaseOrderId");

-- CreateIndex
CREATE UNIQUE INDEX "GoodsReceipt_businessId_number_key" ON "GoodsReceipt"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "GoodsReceipt_businessId_id_key" ON "GoodsReceipt"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "GoodsReceipt_businessId_purchaseOrderId_branchId_id_key" ON "GoodsReceipt"("businessId", "purchaseOrderId", "branchId", "id");

-- CreateIndex
CREATE INDEX "GoodsReceiptLine_businessId_variantId_idx" ON "GoodsReceiptLine"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "GoodsReceiptLine_businessId_id_key" ON "GoodsReceiptLine"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "GoodsReceiptLine_businessId_branchId_variantId_id_key" ON "GoodsReceiptLine"("businessId", "branchId", "variantId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "GoodsReceiptLine_receiptId_purchaseOrderLineId_batchNumber_key" ON "GoodsReceiptLine"("receiptId", "purchaseOrderLineId", "batchNumber");

-- CreateIndex
CREATE INDEX "SupplierInvoice_businessId_supplierId_status_dueDate_idx" ON "SupplierInvoice"("businessId", "supplierId", "status", "dueDate");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierInvoice_businessId_number_key" ON "SupplierInvoice"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierInvoice_businessId_supplierInvoiceNumber_key" ON "SupplierInvoice"("businessId", "supplierInvoiceNumber");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierInvoice_businessId_id_key" ON "SupplierInvoice"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierInvoice_businessId_supplierId_id_key" ON "SupplierInvoice"("businessId", "supplierId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierInvoice_businessId_supplierId_id_purchaseOrderId_key" ON "SupplierInvoice"("businessId", "supplierId", "id", "purchaseOrderId");

-- CreateIndex
CREATE INDEX "SupplierInvoiceLine_businessId_variantId_idx" ON "SupplierInvoiceLine"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierInvoiceLine_businessId_id_key" ON "SupplierInvoiceLine"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierInvoiceLine_supplierInvoiceId_purchaseOrderLineId_key" ON "SupplierInvoiceLine"("supplierInvoiceId", "purchaseOrderLineId");

-- CreateIndex
CREATE INDEX "SupplierPayment_businessId_supplierId_status_paidAt_idx" ON "SupplierPayment"("businessId", "supplierId", "status", "paidAt");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierPayment_businessId_number_key" ON "SupplierPayment"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierPayment_businessId_id_key" ON "SupplierPayment"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierPayment_businessId_supplierId_id_key" ON "SupplierPayment"("businessId", "supplierId", "id");

-- CreateIndex
CREATE INDEX "PaymentAllocation_businessId_supplierInvoiceId_idx" ON "PaymentAllocation"("businessId", "supplierInvoiceId");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentAllocation_supplierPaymentId_supplierInvoiceId_key" ON "PaymentAllocation"("supplierPaymentId", "supplierInvoiceId");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentAllocation_businessId_id_key" ON "PaymentAllocation"("businessId", "id");

-- CreateIndex
CREATE INDEX "Customer_businessId_phone_idx" ON "Customer"("businessId", "phone");

-- CreateIndex
CREATE INDEX "Customer_businessId_fullName_idx" ON "Customer"("businessId", "fullName");

-- CreateIndex
CREATE INDEX "Customer_businessId_status_idx" ON "Customer"("businessId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "Customer_businessId_code_key" ON "Customer"("businessId", "code");

-- CreateIndex
CREATE UNIQUE INDEX "Customer_businessId_id_key" ON "Customer"("businessId", "id");

-- CreateIndex
CREATE INDEX "CustomerContact_businessId_value_idx" ON "CustomerContact"("businessId", "value");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerContact_customerId_type_value_key" ON "CustomerContact"("customerId", "type", "value");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerContact_businessId_id_key" ON "CustomerContact"("businessId", "id");

-- CreateIndex
CREATE INDEX "CustomerConsent_customerId_channel_recordedAt_idx" ON "CustomerConsent"("customerId", "channel", "recordedAt");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerConsent_businessId_id_key" ON "CustomerConsent"("businessId", "id");

-- CreateIndex
CREATE INDEX "CustomerMergeRequest_businessId_status_idx" ON "CustomerMergeRequest"("businessId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerMergeRequest_businessId_id_key" ON "CustomerMergeRequest"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerBusinessSummary_customerId_key" ON "CustomerBusinessSummary"("customerId");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerBusinessSummary_businessId_id_key" ON "CustomerBusinessSummary"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerBusinessSummary_businessId_customerId_key" ON "CustomerBusinessSummary"("businessId", "customerId");

-- CreateIndex
CREATE INDEX "Device_businessId_branchId_status_idx" ON "Device"("businessId", "branchId", "status");

-- CreateIndex
CREATE INDEX "Device_enrolledUserId_idx" ON "Device"("enrolledUserId");

-- CreateIndex
CREATE UNIQUE INDEX "Device_businessId_id_key" ON "Device"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "Device_businessId_deviceFingerprint_key" ON "Device"("businessId", "deviceFingerprint");

-- CreateIndex
CREATE UNIQUE INDEX "Device_businessId_branchId_id_key" ON "Device"("businessId", "branchId", "id");

-- CreateIndex
CREATE INDEX "SyncSession_businessId_deviceId_startedAt_idx" ON "SyncSession"("businessId", "deviceId", "startedAt");

-- CreateIndex
CREATE INDEX "SyncSession_status_idx" ON "SyncSession"("status");

-- CreateIndex
CREATE UNIQUE INDEX "SyncSession_businessId_id_key" ON "SyncSession"("businessId", "id");

-- CreateIndex
CREATE INDEX "SyncOperation_businessId_status_receivedAt_idx" ON "SyncOperation"("businessId", "status", "receivedAt");

-- CreateIndex
CREATE INDEX "SyncOperation_businessId_branchId_status_idx" ON "SyncOperation"("businessId", "branchId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "SyncOperation_businessId_id_key" ON "SyncOperation"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SyncOperation_businessId_saleId_key" ON "SyncOperation"("businessId", "saleId");

-- CreateIndex
CREATE UNIQUE INDEX "SyncOperation_businessId_deviceId_operationId_key" ON "SyncOperation"("businessId", "deviceId", "operationId");

-- CreateIndex
CREATE UNIQUE INDEX "SyncAttempt_syncOperationId_attemptNumber_key" ON "SyncAttempt"("syncOperationId", "attemptNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ReconciliationException_syncOperationId_key" ON "ReconciliationException"("syncOperationId");

-- CreateIndex
CREATE UNIQUE INDEX "ReconciliationException_committedSaleId_key" ON "ReconciliationException"("committedSaleId");

-- CreateIndex
CREATE INDEX "ReconciliationException_businessId_branchId_status_received_idx" ON "ReconciliationException"("businessId", "branchId", "status", "receivedAt");

-- CreateIndex
CREATE INDEX "ReconciliationException_businessId_deviceId_status_idx" ON "ReconciliationException"("businessId", "deviceId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "ReconciliationException_businessId_id_key" ON "ReconciliationException"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "ReconciliationException_businessId_syncOperationId_key" ON "ReconciliationException"("businessId", "syncOperationId");

-- CreateIndex
CREATE UNIQUE INDEX "ReconciliationException_businessId_committedSaleId_key" ON "ReconciliationException"("businessId", "committedSaleId");

-- CreateIndex
CREATE INDEX "ReconciliationShortfallLine_businessId_variantId_idx" ON "ReconciliationShortfallLine"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "ReconciliationShortfallLine_businessId_id_key" ON "ReconciliationShortfallLine"("businessId", "id");

-- CreateIndex
CREATE INDEX "ReconciliationEvent_businessId_exceptionId_createdAt_idx" ON "ReconciliationEvent"("businessId", "exceptionId", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "ReconciliationEvent_businessId_id_key" ON "ReconciliationEvent"("businessId", "id");

-- CreateIndex
CREATE INDEX "ConflictRecord_businessId_branchId_status_idx" ON "ConflictRecord"("businessId", "branchId", "status");

-- CreateIndex
CREATE INDEX "ConflictRecord_businessId_deviceId_createdAt_idx" ON "ConflictRecord"("businessId", "deviceId", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "ConflictRecord_businessId_id_key" ON "ConflictRecord"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SyncCursor_deviceId_feedType_key" ON "SyncCursor"("deviceId", "feedType");

-- CreateIndex
CREATE INDEX "FeedEvent_businessId_branchId_feedType_occurredAt_id_idx" ON "FeedEvent"("businessId", "branchId", "feedType", "occurredAt", "id");

-- CreateIndex
CREATE INDEX "FeedEvent_businessId_entityType_entityId_idx" ON "FeedEvent"("businessId", "entityType", "entityId");

-- CreateIndex
CREATE UNIQUE INDEX "FeedEvent_businessId_id_key" ON "FeedEvent"("businessId", "id");

-- CreateIndex
CREATE INDEX "PosTerminal_businessId_branchId_idx" ON "PosTerminal"("businessId", "branchId");

-- CreateIndex
CREATE UNIQUE INDEX "PosTerminal_branchId_code_key" ON "PosTerminal"("branchId", "code");

-- CreateIndex
CREATE UNIQUE INDEX "PosTerminal_businessId_id_key" ON "PosTerminal"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "PosTerminal_businessId_branchId_id_key" ON "PosTerminal"("businessId", "branchId", "id");

-- CreateIndex
CREATE INDEX "CashierShift_businessId_branchId_status_idx" ON "CashierShift"("businessId", "branchId", "status");

-- CreateIndex
CREATE INDEX "CashierShift_businessId_terminalId_openedAt_idx" ON "CashierShift"("businessId", "terminalId", "openedAt");

-- CreateIndex
CREATE UNIQUE INDEX "CashierShift_businessId_id_key" ON "CashierShift"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "CashierShift_businessId_branchId_id_key" ON "CashierShift"("businessId", "branchId", "id");

-- CreateIndex
CREATE INDEX "ShiftCashMovement_businessId_shiftId_occurredAt_idx" ON "ShiftCashMovement"("businessId", "shiftId", "occurredAt");

-- CreateIndex
CREATE UNIQUE INDEX "ShiftCashMovement_businessId_id_key" ON "ShiftCashMovement"("businessId", "id");

-- CreateIndex
CREATE INDEX "Sale_businessId_branchId_completedAt_idx" ON "Sale"("businessId", "branchId", "completedAt");

-- CreateIndex
CREATE INDEX "Sale_businessId_customerId_completedAt_idx" ON "Sale"("businessId", "customerId", "completedAt");

-- CreateIndex
CREATE INDEX "Sale_businessId_shiftId_idx" ON "Sale"("businessId", "shiftId");

-- CreateIndex
CREATE INDEX "Sale_businessId_status_idx" ON "Sale"("businessId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "Sale_businessId_id_key" ON "Sale"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "Sale_businessId_receiptNumber_key" ON "Sale"("businessId", "receiptNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Sale_businessId_offlineDeviceId_operationId_key" ON "Sale"("businessId", "offlineDeviceId", "operationId");

-- CreateIndex
CREATE UNIQUE INDEX "Sale_businessId_branchId_id_key" ON "Sale"("businessId", "branchId", "id");

-- CreateIndex
CREATE INDEX "SaleLine_businessId_variantId_saleId_idx" ON "SaleLine"("businessId", "variantId", "saleId");

-- CreateIndex
CREATE INDEX "SaleLine_businessId_batchId_idx" ON "SaleLine"("businessId", "batchId");

-- CreateIndex
CREATE UNIQUE INDEX "SaleLine_businessId_id_key" ON "SaleLine"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SaleLine_businessId_saleId_id_key" ON "SaleLine"("businessId", "saleId", "id");

-- CreateIndex
CREATE INDEX "SalePayment_businessId_saleId_idx" ON "SalePayment"("businessId", "saleId");

-- CreateIndex
CREATE INDEX "SalePayment_businessId_reference_idx" ON "SalePayment"("businessId", "reference");

-- CreateIndex
CREATE UNIQUE INDEX "SalePayment_businessId_id_key" ON "SalePayment"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SalePayment_businessId_saleId_id_key" ON "SalePayment"("businessId", "saleId", "id");

-- CreateIndex
CREATE INDEX "SaleDiscount_businessId_saleId_idx" ON "SaleDiscount"("businessId", "saleId");

-- CreateIndex
CREATE UNIQUE INDEX "SaleDiscount_businessId_id_key" ON "SaleDiscount"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SaleVoid_saleId_key" ON "SaleVoid"("saleId");

-- CreateIndex
CREATE UNIQUE INDEX "SaleVoid_businessId_id_key" ON "SaleVoid"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "SaleVoid_businessId_saleId_key" ON "SaleVoid"("businessId", "saleId");

-- CreateIndex
CREATE UNIQUE INDEX "Receipt_saleId_key" ON "Receipt"("saleId");

-- CreateIndex
CREATE INDEX "Receipt_businessId_receiptNumber_idx" ON "Receipt"("businessId", "receiptNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Receipt_businessId_saleId_key" ON "Receipt"("businessId", "saleId");

-- CreateIndex
CREATE UNIQUE INDEX "Receipt_businessId_id_key" ON "Receipt"("businessId", "id");

-- CreateIndex
CREATE INDEX "ReceiptBlock_businessId_deviceId_status_idx" ON "ReceiptBlock"("businessId", "deviceId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "ReceiptBlock_deviceId_prefix_startNumber_key" ON "ReceiptBlock"("deviceId", "prefix", "startNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ReceiptBlock_businessId_id_key" ON "ReceiptBlock"("businessId", "id");

-- CreateIndex
CREATE INDEX "SaleCustomerAssociation_businessId_customerId_idx" ON "SaleCustomerAssociation"("businessId", "customerId");

-- CreateIndex
CREATE UNIQUE INDEX "SaleCustomerAssociation_saleId_customerId_key" ON "SaleCustomerAssociation"("saleId", "customerId");

-- CreateIndex
CREATE UNIQUE INDEX "SaleCustomerAssociation_businessId_id_key" ON "SaleCustomerAssociation"("businessId", "id");

-- CreateIndex
CREATE INDEX "ReturnRequest_businessId_branchId_status_idx" ON "ReturnRequest"("businessId", "branchId", "status");

-- CreateIndex
CREATE INDEX "ReturnRequest_businessId_saleId_idx" ON "ReturnRequest"("businessId", "saleId");

-- CreateIndex
CREATE UNIQUE INDEX "ReturnRequest_businessId_number_key" ON "ReturnRequest"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "ReturnRequest_businessId_id_key" ON "ReturnRequest"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "ReturnRequest_businessId_saleId_id_key" ON "ReturnRequest"("businessId", "saleId", "id");

-- CreateIndex
CREATE INDEX "ReturnLine_businessId_saleLineId_idx" ON "ReturnLine"("businessId", "saleLineId");

-- CreateIndex
CREATE INDEX "ReturnLine_businessId_saleId_idx" ON "ReturnLine"("businessId", "saleId");

-- CreateIndex
CREATE UNIQUE INDEX "ReturnLine_returnId_saleLineId_key" ON "ReturnLine"("returnId", "saleLineId");

-- CreateIndex
CREATE UNIQUE INDEX "ReturnLine_businessId_id_key" ON "ReturnLine"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "ReturnInspection_returnId_key" ON "ReturnInspection"("returnId");

-- CreateIndex
CREATE UNIQUE INDEX "ReturnInspection_businessId_id_key" ON "ReturnInspection"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "ReturnInspection_businessId_returnId_key" ON "ReturnInspection"("businessId", "returnId");

-- CreateIndex
CREATE INDEX "Refund_businessId_branchId_status_idx" ON "Refund"("businessId", "branchId", "status");

-- CreateIndex
CREATE INDEX "Refund_businessId_saleId_idx" ON "Refund"("businessId", "saleId");

-- CreateIndex
CREATE UNIQUE INDEX "Refund_businessId_number_key" ON "Refund"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "Refund_businessId_id_key" ON "Refund"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "Refund_businessId_idempotencyKey_key" ON "Refund"("businessId", "idempotencyKey");

-- CreateIndex
CREATE UNIQUE INDEX "Refund_businessId_saleId_id_key" ON "Refund"("businessId", "saleId", "id");

-- CreateIndex
CREATE INDEX "RefundAllocation_businessId_salePaymentId_idx" ON "RefundAllocation"("businessId", "salePaymentId");

-- CreateIndex
CREATE INDEX "RefundAllocation_businessId_saleId_idx" ON "RefundAllocation"("businessId", "saleId");

-- CreateIndex
CREATE UNIQUE INDEX "RefundAllocation_refundId_salePaymentId_key" ON "RefundAllocation"("refundId", "salePaymentId");

-- CreateIndex
CREATE UNIQUE INDEX "RefundAllocation_businessId_id_key" ON "RefundAllocation"("businessId", "id");

-- CreateIndex
CREATE INDEX "Exchange_businessId_branchId_status_idx" ON "Exchange"("businessId", "branchId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "Exchange_businessId_number_key" ON "Exchange"("businessId", "number");

-- CreateIndex
CREATE UNIQUE INDEX "Exchange_businessId_id_key" ON "Exchange"("businessId", "id");

-- CreateIndex
CREATE INDEX "ExchangeLine_businessId_variantId_idx" ON "ExchangeLine"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "ExchangeLine_businessId_id_key" ON "ExchangeLine"("businessId", "id");

-- CreateIndex
CREATE INDEX "ExchangeReservation_businessId_variantId_status_idx" ON "ExchangeReservation"("businessId", "variantId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "ExchangeReservation_exchangeId_variantId_key" ON "ExchangeReservation"("exchangeId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "ExchangeReservation_businessId_id_key" ON "ExchangeReservation"("businessId", "id");

-- CreateIndex
CREATE INDEX "CollectionFollowUp_businessId_status_dueAt_idx" ON "CollectionFollowUp"("businessId", "status", "dueAt");

-- CreateIndex
CREATE INDEX "CollectionFollowUp_businessId_customerId_idx" ON "CollectionFollowUp"("businessId", "customerId");

-- CreateIndex
CREATE UNIQUE INDEX "CollectionFollowUp_businessId_id_key" ON "CollectionFollowUp"("businessId", "id");

-- CreateIndex
CREATE INDEX "NotificationTemplate_businessId_code_isActive_idx" ON "NotificationTemplate"("businessId", "code", "isActive");

-- CreateIndex
CREATE UNIQUE INDEX "NotificationTemplate_businessId_code_channel_locale_version_key" ON "NotificationTemplate"("businessId", "code", "channel", "locale", "version");

-- CreateIndex
CREATE UNIQUE INDEX "NotificationTemplate_businessId_id_key" ON "NotificationTemplate"("businessId", "id");

-- CreateIndex
CREATE INDEX "Notification_recipientUserId_status_createdAt_idx" ON "Notification"("recipientUserId", "status", "createdAt");

-- CreateIndex
CREATE INDEX "Notification_businessId_category_createdAt_idx" ON "Notification"("businessId", "category", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "Notification_businessId_dedupeKey_key" ON "Notification"("businessId", "dedupeKey");

-- CreateIndex
CREATE UNIQUE INDEX "Notification_businessId_id_key" ON "Notification"("businessId", "id");

-- CreateIndex
CREATE INDEX "NotificationDelivery_businessId_status_lastAttemptAt_idx" ON "NotificationDelivery"("businessId", "status", "lastAttemptAt");

-- CreateIndex
CREATE UNIQUE INDEX "NotificationDelivery_notificationId_channel_key" ON "NotificationDelivery"("notificationId", "channel");

-- CreateIndex
CREATE UNIQUE INDEX "NotificationDelivery_businessId_id_key" ON "NotificationDelivery"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "NotificationPreference_userId_channel_category_key" ON "NotificationPreference"("userId", "channel", "category");

-- CreateIndex
CREATE INDEX "NotificationEscalation_businessId_status_escalatedAt_idx" ON "NotificationEscalation"("businessId", "status", "escalatedAt");

-- CreateIndex
CREATE UNIQUE INDEX "NotificationEscalation_notificationId_level_key" ON "NotificationEscalation"("notificationId", "level");

-- CreateIndex
CREATE UNIQUE INDEX "NotificationEscalation_businessId_id_key" ON "NotificationEscalation"("businessId", "id");

-- CreateIndex
CREATE INDEX "ReportDefinition_businessId_isActive_idx" ON "ReportDefinition"("businessId", "isActive");

-- CreateIndex
CREATE UNIQUE INDEX "ReportDefinition_businessId_code_key" ON "ReportDefinition"("businessId", "code");

-- CreateIndex
CREATE UNIQUE INDEX "ReportDefinition_businessId_id_key" ON "ReportDefinition"("businessId", "id");

-- CreateIndex
CREATE INDEX "ExportJob_businessId_status_requestedAt_idx" ON "ExportJob"("businessId", "status", "requestedAt");

-- CreateIndex
CREATE UNIQUE INDEX "ExportJob_businessId_id_key" ON "ExportJob"("businessId", "id");

-- CreateIndex
CREATE INDEX "SalesDailyFact_businessId_businessDate_idx" ON "SalesDailyFact"("businessId", "businessDate");

-- CreateIndex
CREATE UNIQUE INDEX "SalesDailyFact_branchId_businessDate_key" ON "SalesDailyFact"("branchId", "businessDate");

-- CreateIndex
CREATE UNIQUE INDEX "SalesDailyFact_businessId_id_key" ON "SalesDailyFact"("businessId", "id");

-- CreateIndex
CREATE INDEX "ProductSalesDailyFact_businessId_variantId_businessDate_idx" ON "ProductSalesDailyFact"("businessId", "variantId", "businessDate");

-- CreateIndex
CREATE UNIQUE INDEX "ProductSalesDailyFact_branchId_variantId_businessDate_key" ON "ProductSalesDailyFact"("branchId", "variantId", "businessDate");

-- CreateIndex
CREATE UNIQUE INDEX "ProductSalesDailyFact_businessId_id_key" ON "ProductSalesDailyFact"("businessId", "id");

-- CreateIndex
CREATE INDEX "InventoryDailyFact_businessId_businessDate_idx" ON "InventoryDailyFact"("businessId", "businessDate");

-- CreateIndex
CREATE UNIQUE INDEX "InventoryDailyFact_branchId_variantId_businessDate_key" ON "InventoryDailyFact"("branchId", "variantId", "businessDate");

-- CreateIndex
CREATE UNIQUE INDEX "InventoryDailyFact_businessId_id_key" ON "InventoryDailyFact"("businessId", "id");

-- CreateIndex
CREATE INDEX "StockoutEvent_businessId_branchId_variantId_detectedAt_idx" ON "StockoutEvent"("businessId", "branchId", "variantId", "detectedAt");

-- CreateIndex
CREATE INDEX "StockoutEvent_businessId_endedAt_idx" ON "StockoutEvent"("businessId", "endedAt");

-- CreateIndex
CREATE UNIQUE INDEX "StockoutEvent_businessId_id_key" ON "StockoutEvent"("businessId", "id");

-- CreateIndex
CREATE INDEX "ExpiryRiskFact_businessId_branchId_asOfDate_idx" ON "ExpiryRiskFact"("businessId", "branchId", "asOfDate");

-- CreateIndex
CREATE UNIQUE INDEX "ExpiryRiskFact_businessId_id_key" ON "ExpiryRiskFact"("businessId", "id");

-- CreateIndex
CREATE INDEX "SupplierPerformanceFact_businessId_periodStart_idx" ON "SupplierPerformanceFact"("businessId", "periodStart");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierPerformanceFact_supplierId_periodStart_periodEnd_key" ON "SupplierPerformanceFact"("supplierId", "periodStart", "periodEnd");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierPerformanceFact_businessId_id_key" ON "SupplierPerformanceFact"("businessId", "id");

-- CreateIndex
CREATE INDEX "ForecastModel_status_idx" ON "ForecastModel"("status");

-- CreateIndex
CREATE UNIQUE INDEX "ForecastModel_name_version_key" ON "ForecastModel"("name", "version");

-- CreateIndex
CREATE INDEX "ForecastRun_businessId_status_createdAt_idx" ON "ForecastRun"("businessId", "status", "createdAt");

-- CreateIndex
CREATE INDEX "ForecastRun_businessId_branchId_scope_idx" ON "ForecastRun"("businessId", "branchId", "scope");

-- CreateIndex
CREATE UNIQUE INDEX "ForecastRun_businessId_id_key" ON "ForecastRun"("businessId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "ForecastPoint_forecastRunId_pointDate_key" ON "ForecastPoint"("forecastRunId", "pointDate");

-- CreateIndex
CREATE INDEX "Recommendation_businessId_status_createdAt_idx" ON "Recommendation"("businessId", "status", "createdAt");

-- CreateIndex
CREATE INDEX "Recommendation_businessId_variantId_idx" ON "Recommendation"("businessId", "variantId");

-- CreateIndex
CREATE UNIQUE INDEX "Recommendation_businessId_id_key" ON "Recommendation"("businessId", "id");

-- CreateIndex
CREATE INDEX "FeatureSnapshot_businessId_snapshotDate_idx" ON "FeatureSnapshot"("businessId", "snapshotDate");

-- CreateIndex
CREATE UNIQUE INDEX "FeatureSnapshot_businessId_id_key" ON "FeatureSnapshot"("businessId", "id");

-- CreateIndex
CREATE INDEX "ModelMetric_businessId_modelId_recordedAt_idx" ON "ModelMetric"("businessId", "modelId", "recordedAt");

-- CreateIndex
CREATE UNIQUE INDEX "ModelMetric_businessId_id_key" ON "ModelMetric"("businessId", "id");

-- AddForeignKey
ALTER TABLE "OutboxEvent" ADD CONSTRAINT "OutboxEvent_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IdempotencyRecord" ADD CONSTRAINT "IdempotencyRecord_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserCredential" ADD CONSTRAINT "UserCredential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSession" ADD CONSTRAINT "UserSession_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmailVerificationToken" ADD CONSTRAINT "EmailVerificationToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PasswordResetToken" ADD CONSTRAINT "PasswordResetToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Business" ADD CONSTRAINT "Business_id_ownerMembershipId_fkey" FOREIGN KEY ("id", "ownerMembershipId") REFERENCES "Membership"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Branch" ADD CONSTRAINT "Branch_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Membership" ADD CONSTRAINT "Membership_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Membership" ADD CONSTRAINT "Membership_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Membership" ADD CONSTRAINT "Membership_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Membership" ADD CONSTRAINT "Membership_roleBusinessId_roleId_fkey" FOREIGN KEY ("roleBusinessId", "roleId") REFERENCES "Role"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MembershipBranchAssignment" ADD CONSTRAINT "MembershipBranchAssignment_businessId_membershipId_fkey" FOREIGN KEY ("businessId", "membershipId") REFERENCES "Membership"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MembershipBranchAssignment" ADD CONSTRAINT "MembershipBranchAssignment_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invitation" ADD CONSTRAINT "Invitation_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invitation" ADD CONSTRAINT "Invitation_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invitation" ADD CONSTRAINT "Invitation_roleBusinessId_roleId_fkey" FOREIGN KEY ("roleBusinessId", "roleId") REFERENCES "Role"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invitation" ADD CONSTRAINT "Invitation_businessId_invitedByMembershipId_fkey" FOREIGN KEY ("businessId", "invitedByMembershipId") REFERENCES "Membership"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Role" ADD CONSTRAINT "Role_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RolePermission" ADD CONSTRAINT "RolePermission_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RolePermission" ADD CONSTRAINT "RolePermission_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES "Permission"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeBranchAssignment" ADD CONSTRAINT "EmployeeBranchAssignment_businessId_employeeId_fkey" FOREIGN KEY ("businessId", "employeeId") REFERENCES "Employee"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeBranchAssignment" ADD CONSTRAINT "EmployeeBranchAssignment_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmploymentStatusHistory" ADD CONSTRAINT "EmploymentStatusHistory_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES "Employee"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlanFeature" ADD CONSTRAINT "PlanFeature_planId_fkey" FOREIGN KEY ("planId") REFERENCES "Plan"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlanPrice" ADD CONSTRAINT "PlanPrice_planId_fkey" FOREIGN KEY ("planId") REFERENCES "Plan"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Subscription" ADD CONSTRAINT "Subscription_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Subscription" ADD CONSTRAINT "Subscription_planId_fkey" FOREIGN KEY ("planId") REFERENCES "Plan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubscriptionHistory" ADD CONSTRAINT "SubscriptionHistory_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubscriptionHistory" ADD CONSTRAINT "SubscriptionHistory_businessId_subscriptionId_fkey" FOREIGN KEY ("businessId", "subscriptionId") REFERENCES "Subscription"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubscriptionHistory" ADD CONSTRAINT "SubscriptionHistory_fromPlanId_fkey" FOREIGN KEY ("fromPlanId") REFERENCES "Plan"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubscriptionHistory" ADD CONSTRAINT "SubscriptionHistory_toPlanId_fkey" FOREIGN KEY ("toPlanId") REFERENCES "Plan"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubscriptionInvoice" ADD CONSTRAINT "SubscriptionInvoice_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubscriptionInvoice" ADD CONSTRAINT "SubscriptionInvoice_businessId_subscriptionId_fkey" FOREIGN KEY ("businessId", "subscriptionId") REFERENCES "Subscription"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentAttempt" ADD CONSTRAINT "PaymentAttempt_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentAttempt" ADD CONSTRAINT "PaymentAttempt_businessId_subscriptionId_fkey" FOREIGN KEY ("businessId", "subscriptionId") REFERENCES "Subscription"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentAttempt" ADD CONSTRAINT "PaymentAttempt_businessId_invoiceId_fkey" FOREIGN KEY ("businessId", "invoiceId") REFERENCES "SubscriptionInvoice"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentAttempt" ADD CONSTRAINT "PaymentAttempt_planId_fkey" FOREIGN KEY ("planId") REFERENCES "Plan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentWebhookEvent" ADD CONSTRAINT "PaymentWebhookEvent_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentWebhookEvent" ADD CONSTRAINT "PaymentWebhookEvent_attemptId_fkey" FOREIGN KEY ("attemptId") REFERENCES "PaymentAttempt"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrialGrant" ADD CONSTRAINT "TrialGrant_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UsageCounter" ADD CONSTRAINT "UsageCounter_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentReconciliationTask" ADD CONSTRAINT "PaymentReconciliationTask_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentReconciliationTask" ADD CONSTRAINT "PaymentReconciliationTask_businessId_attemptId_fkey" FOREIGN KEY ("businessId", "attemptId") REFERENCES "PaymentAttempt"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupportCase" ADD CONSTRAINT "SupportCase_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupportCase" ADD CONSTRAINT "SupportCase_openedByUserId_fkey" FOREIGN KEY ("openedByUserId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupportCase" ADD CONSTRAINT "SupportCase_assignedToUserId_fkey" FOREIGN KEY ("assignedToUserId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupportAccessGrant" ADD CONSTRAINT "SupportAccessGrant_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupportAccessGrant" ADD CONSTRAINT "SupportAccessGrant_supportUserId_fkey" FOREIGN KEY ("supportUserId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupportAccessGrant" ADD CONSTRAINT "SupportAccessGrant_grantedByUserId_fkey" FOREIGN KEY ("grantedByUserId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupportAccessGrant" ADD CONSTRAINT "SupportAccessGrant_businessId_caseId_fkey" FOREIGN KEY ("businessId", "caseId") REFERENCES "SupportCase"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AuditEvent" ADD CONSTRAINT "AuditEvent_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AuditEvent" ADD CONSTRAINT "AuditEvent_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AuditEvent" ADD CONSTRAINT "AuditEvent_businessId_actorMembershipId_fkey" FOREIGN KEY ("businessId", "actorMembershipId") REFERENCES "Membership"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BusinessConfiguration" ADD CONSTRAINT "BusinessConfiguration_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BusinessSetting" ADD CONSTRAINT "BusinessSetting_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BranchSetting" ADD CONSTRAINT "BranchSetting_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BranchSetting" ADD CONSTRAINT "BranchSetting_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AttributeDefinition" ADD CONSTRAINT "AttributeDefinition_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AttributeDefinition" ADD CONSTRAINT "AttributeDefinition_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES "Unit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Unit" ADD CONSTRAINT "Unit_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Unit" ADD CONSTRAINT "Unit_baseUnitId_fkey" FOREIGN KEY ("baseUnitId") REFERENCES "Unit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnitConversion" ADD CONSTRAINT "UnitConversion_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnitConversion" ADD CONSTRAINT "UnitConversion_fromUnitId_fkey" FOREIGN KEY ("fromUnitId") REFERENCES "Unit"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnitConversion" ADD CONSTRAINT "UnitConversion_toUnitId_fkey" FOREIGN KEY ("toUnitId") REFERENCES "Unit"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CapabilityFlag" ADD CONSTRAINT "CapabilityFlag_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Brand" ADD CONSTRAINT "Brand_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_businessId_parentId_fkey" FOREIGN KEY ("businessId", "parentId") REFERENCES "Category"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_businessId_brandId_fkey" FOREIGN KEY ("businessId", "brandId") REFERENCES "Brand"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_businessId_categoryId_fkey" FOREIGN KEY ("businessId", "categoryId") REFERENCES "Category"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES "Unit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductVariant" ADD CONSTRAINT "ProductVariant_businessId_productId_fkey" FOREIGN KEY ("businessId", "productId") REFERENCES "Product"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductVariant" ADD CONSTRAINT "ProductVariant_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES "Unit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductAttributeValue" ADD CONSTRAINT "ProductAttributeValue_businessId_productId_fkey" FOREIGN KEY ("businessId", "productId") REFERENCES "Product"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductAttributeValue" ADD CONSTRAINT "ProductAttributeValue_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductAttributeValue" ADD CONSTRAINT "ProductAttributeValue_businessId_attributeDefinitionId_fkey" FOREIGN KEY ("businessId", "attributeDefinitionId") REFERENCES "AttributeDefinition"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Barcode" ADD CONSTRAINT "Barcode_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductMedia" ADD CONSTRAINT "ProductMedia_businessId_productId_fkey" FOREIGN KEY ("businessId", "productId") REFERENCES "Product"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductMedia" ADD CONSTRAINT "ProductMedia_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductMedia" ADD CONSTRAINT "ProductMedia_businessId_fileId_fkey" FOREIGN KEY ("businessId", "fileId") REFERENCES "FileObject"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductImportJob" ADD CONSTRAINT "ProductImportJob_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductImportJob" ADD CONSTRAINT "ProductImportJob_businessId_fileId_fkey" FOREIGN KEY ("businessId", "fileId") REFERENCES "FileObject"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceList" ADD CONSTRAINT "PriceList_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductPrice" ADD CONSTRAINT "ProductPrice_businessId_priceListId_fkey" FOREIGN KEY ("businessId", "priceListId") REFERENCES "PriceList"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductPrice" ADD CONSTRAINT "ProductPrice_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BranchPriceOverride" ADD CONSTRAINT "BranchPriceOverride_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BranchPriceOverride" ADD CONSTRAINT "BranchPriceOverride_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BranchPriceOverride" ADD CONSTRAINT "BranchPriceOverride_businessId_approvedByMembershipId_fkey" FOREIGN KEY ("businessId", "approvedByMembershipId") REFERENCES "Membership"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceChangeHistory" ADD CONSTRAINT "PriceChangeHistory_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceChangeHistory" ADD CONSTRAINT "PriceChangeHistory_businessId_priceListId_fkey" FOREIGN KEY ("businessId", "priceListId") REFERENCES "PriceList"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceChangeHistory" ADD CONSTRAINT "PriceChangeHistory_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Discount" ADD CONSTRAINT "Discount_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Discount" ADD CONSTRAINT "Discount_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FileObject" ADD CONSTRAINT "FileObject_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FileLink" ADD CONSTRAINT "FileLink_fileId_fkey" FOREIGN KEY ("fileId") REFERENCES "FileObject"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FileUploadSession" ADD CONSTRAINT "FileUploadSession_fileId_fkey" FOREIGN KEY ("fileId") REFERENCES "FileObject"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockLocation" ADD CONSTRAINT "StockLocation_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockLocation" ADD CONSTRAINT "StockLocation_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockBalance" ADD CONSTRAINT "StockBalance_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockBalance" ADD CONSTRAINT "StockBalance_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockBalance" ADD CONSTRAINT "StockBalance_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockMovement" ADD CONSTRAINT "StockMovement_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockMovement" ADD CONSTRAINT "StockMovement_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockMovement" ADD CONSTRAINT "StockMovement_businessId_branchId_variantId_batchId_fkey" FOREIGN KEY ("businessId", "branchId", "variantId", "batchId") REFERENCES "InventoryBatch"("businessId", "branchId", "variantId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockMovement" ADD CONSTRAINT "StockMovement_businessId_actorMembershipId_fkey" FOREIGN KEY ("businessId", "actorMembershipId") REFERENCES "Membership"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockMovement" ADD CONSTRAINT "StockMovement_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryBatch" ADD CONSTRAINT "InventoryBatch_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryBatch" ADD CONSTRAINT "InventoryBatch_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryBatch" ADD CONSTRAINT "InventoryBatch_businessId_branchId_locationId_fkey" FOREIGN KEY ("businessId", "branchId", "locationId") REFERENCES "StockLocation"("businessId", "branchId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryBatch" ADD CONSTRAINT "InventoryBatch_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryBatch" ADD CONSTRAINT "InventoryBatch_businessId_branchId_variantId_receiptLineId_fkey" FOREIGN KEY ("businessId", "branchId", "variantId", "receiptLineId") REFERENCES "GoodsReceiptLine"("businessId", "branchId", "variantId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryBatch" ADD CONSTRAINT "InventoryBatch_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BatchMovementAllocation" ADD CONSTRAINT "BatchMovementAllocation_businessId_branchId_variantId_move_fkey" FOREIGN KEY ("businessId", "branchId", "variantId", "movementId") REFERENCES "StockMovement"("businessId", "branchId", "variantId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BatchMovementAllocation" ADD CONSTRAINT "BatchMovementAllocation_businessId_branchId_variantId_batc_fkey" FOREIGN KEY ("businessId", "branchId", "variantId", "batchId") REFERENCES "InventoryBatch"("businessId", "branchId", "variantId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StocktakeSession" ADD CONSTRAINT "StocktakeSession_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StocktakeSession" ADD CONSTRAINT "StocktakeSession_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StocktakeLine" ADD CONSTRAINT "StocktakeLine_businessId_branchId_sessionId_fkey" FOREIGN KEY ("businessId", "branchId", "sessionId") REFERENCES "StocktakeSession"("businessId", "branchId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StocktakeLine" ADD CONSTRAINT "StocktakeLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StocktakeLine" ADD CONSTRAINT "StocktakeLine_businessId_branchId_variantId_batchId_fkey" FOREIGN KEY ("businessId", "branchId", "variantId", "batchId") REFERENCES "InventoryBatch"("businessId", "branchId", "variantId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryAdjustment" ADD CONSTRAINT "InventoryAdjustment_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryAdjustment" ADD CONSTRAINT "InventoryAdjustment_businessId_stocktakeSessionId_fkey" FOREIGN KEY ("businessId", "stocktakeSessionId") REFERENCES "StocktakeSession"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryAdjustment" ADD CONSTRAINT "InventoryAdjustment_businessId_reconciliationExceptionId_fkey" FOREIGN KEY ("businessId", "reconciliationExceptionId") REFERENCES "ReconciliationException"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryAdjustment" ADD CONSTRAINT "InventoryAdjustment_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryAdjustmentLine" ADD CONSTRAINT "InventoryAdjustmentLine_businessId_branchId_adjustmentId_fkey" FOREIGN KEY ("businessId", "branchId", "adjustmentId") REFERENCES "InventoryAdjustment"("businessId", "branchId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryAdjustmentLine" ADD CONSTRAINT "InventoryAdjustmentLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryAdjustmentLine" ADD CONSTRAINT "InventoryAdjustmentLine_businessId_branchId_variantId_batc_fkey" FOREIGN KEY ("businessId", "branchId", "variantId", "batchId") REFERENCES "InventoryBatch"("businessId", "branchId", "variantId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockTransfer" ADD CONSTRAINT "StockTransfer_businessId_fromBranchId_fkey" FOREIGN KEY ("businessId", "fromBranchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockTransfer" ADD CONSTRAINT "StockTransfer_businessId_toBranchId_fkey" FOREIGN KEY ("businessId", "toBranchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockTransfer" ADD CONSTRAINT "StockTransfer_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockTransferLine" ADD CONSTRAINT "StockTransferLine_businessId_transferId_fkey" FOREIGN KEY ("businessId", "transferId") REFERENCES "StockTransfer"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockTransferLine" ADD CONSTRAINT "StockTransferLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransferReceipt" ADD CONSTRAINT "TransferReceipt_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransferReceipt" ADD CONSTRAINT "TransferReceipt_businessId_transferId_branchId_fkey" FOREIGN KEY ("businessId", "transferId", "branchId") REFERENCES "StockTransfer"("businessId", "id", "toBranchId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransferReceiptLine" ADD CONSTRAINT "TransferReceiptLine_businessId_transferId_receiptId_fkey" FOREIGN KEY ("businessId", "transferId", "receiptId") REFERENCES "TransferReceipt"("businessId", "transferId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransferReceiptLine" ADD CONSTRAINT "TransferReceiptLine_businessId_transferId_transferLineId_v_fkey" FOREIGN KEY ("businessId", "transferId", "transferLineId", "variantId") REFERENCES "StockTransferLine"("businessId", "transferId", "id", "variantId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransferReceiptLine" ADD CONSTRAINT "TransferReceiptLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransferReceiptLine" ADD CONSTRAINT "TransferReceiptLine_businessId_branchId_variantId_batchId_fkey" FOREIGN KEY ("businessId", "branchId", "variantId", "batchId") REFERENCES "InventoryBatch"("businessId", "branchId", "variantId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryAlert" ADD CONSTRAINT "InventoryAlert_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryAlert" ADD CONSTRAINT "InventoryAlert_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryAlert" ADD CONSTRAINT "InventoryAlert_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockReservation" ADD CONSTRAINT "StockReservation_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockReservation" ADD CONSTRAINT "StockReservation_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockReservation" ADD CONSTRAINT "StockReservation_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MinStockSetting" ADD CONSTRAINT "MinStockSetting_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MinStockSetting" ADD CONSTRAINT "MinStockSetting_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MinStockSetting" ADD CONSTRAINT "MinStockSetting_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockLossRecord" ADD CONSTRAINT "StockLossRecord_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockLossRecord" ADD CONSTRAINT "StockLossRecord_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockLossRecord" ADD CONSTRAINT "StockLossRecord_businessId_branchId_variantId_batchId_fkey" FOREIGN KEY ("businessId", "branchId", "variantId", "batchId") REFERENCES "InventoryBatch"("businessId", "branchId", "variantId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockLossRecord" ADD CONSTRAINT "StockLossRecord_businessId_branchId_variantId_movementId_fkey" FOREIGN KEY ("businessId", "branchId", "variantId", "movementId") REFERENCES "StockMovement"("businessId", "branchId", "variantId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockLossRecord" ADD CONSTRAINT "StockLossRecord_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryValuationSnapshot" ADD CONSTRAINT "InventoryValuationSnapshot_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryValuationSnapshot" ADD CONSTRAINT "InventoryValuationSnapshot_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryValuationSnapshot" ADD CONSTRAINT "InventoryValuationSnapshot_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Supplier" ADD CONSTRAINT "Supplier_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierContact" ADD CONSTRAINT "SupplierContact_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierContact" ADD CONSTRAINT "SupplierContact_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierDocument" ADD CONSTRAINT "SupplierDocument_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierDocument" ADD CONSTRAINT "SupplierDocument_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierDocument" ADD CONSTRAINT "SupplierDocument_businessId_fileId_fkey" FOREIGN KEY ("businessId", "fileId") REFERENCES "FileObject"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierProduct" ADD CONSTRAINT "SupplierProduct_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierProduct" ADD CONSTRAINT "SupplierProduct_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierProduct" ADD CONSTRAINT "SupplierProduct_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierPriceHistory" ADD CONSTRAINT "SupplierPriceHistory_businessId_supplierProductId_fkey" FOREIGN KEY ("businessId", "supplierProductId") REFERENCES "SupplierProduct"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierPricingAgreement" ADD CONSTRAINT "SupplierPricingAgreement_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierPricingAgreement" ADD CONSTRAINT "SupplierPricingAgreement_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierAgreementLine" ADD CONSTRAINT "SupplierAgreementLine_businessId_agreementId_fkey" FOREIGN KEY ("businessId", "agreementId") REFERENCES "SupplierPricingAgreement"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierAgreementLine" ADD CONSTRAINT "SupplierAgreementLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierRating" ADD CONSTRAINT "SupplierRating_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierRating" ADD CONSTRAINT "SupplierRating_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierDispute" ADD CONSTRAINT "SupplierDispute_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierDispute" ADD CONSTRAINT "SupplierDispute_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierStatement" ADD CONSTRAINT "SupplierStatement_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierStatement" ADD CONSTRAINT "SupplierStatement_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierStatement" ADD CONSTRAINT "SupplierStatement_businessId_fileId_fkey" FOREIGN KEY ("businessId", "fileId") REFERENCES "FileObject"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierPerformanceSnapshot" ADD CONSTRAINT "SupplierPerformanceSnapshot_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierPerformanceSnapshot" ADD CONSTRAINT "SupplierPerformanceSnapshot_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseRequest" ADD CONSTRAINT "PurchaseRequest_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseRequest" ADD CONSTRAINT "PurchaseRequest_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseRequestLine" ADD CONSTRAINT "PurchaseRequestLine_businessId_requestId_fkey" FOREIGN KEY ("businessId", "requestId") REFERENCES "PurchaseRequest"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseRequestLine" ADD CONSTRAINT "PurchaseRequestLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rfq" ADD CONSTRAINT "Rfq_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rfq" ADD CONSTRAINT "Rfq_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rfq" ADD CONSTRAINT "Rfq_businessId_awardedQuotationId_fkey" FOREIGN KEY ("businessId", "awardedQuotationId") REFERENCES "SupplierQuotation"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RfqVersion" ADD CONSTRAINT "RfqVersion_businessId_rfqId_fkey" FOREIGN KEY ("businessId", "rfqId") REFERENCES "Rfq"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RfqLine" ADD CONSTRAINT "RfqLine_businessId_rfqVersionId_fkey" FOREIGN KEY ("businessId", "rfqVersionId") REFERENCES "RfqVersion"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RfqLine" ADD CONSTRAINT "RfqLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierQuotation" ADD CONSTRAINT "SupplierQuotation_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierQuotation" ADD CONSTRAINT "SupplierQuotation_businessId_rfqVersionId_fkey" FOREIGN KEY ("businessId", "rfqVersionId") REFERENCES "RfqVersion"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierQuotation" ADD CONSTRAINT "SupplierQuotation_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuotationLine" ADD CONSTRAINT "QuotationLine_businessId_quotationId_fkey" FOREIGN KEY ("businessId", "quotationId") REFERENCES "SupplierQuotation"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuotationLine" ADD CONSTRAINT "QuotationLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuotationComparison" ADD CONSTRAINT "QuotationComparison_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuotationComparison" ADD CONSTRAINT "QuotationComparison_businessId_rfqVersionId_fkey" FOREIGN KEY ("businessId", "rfqVersionId") REFERENCES "RfqVersion"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuotationComparison" ADD CONSTRAINT "QuotationComparison_businessId_recommendedQuotationId_fkey" FOREIGN KEY ("businessId", "recommendedQuotationId") REFERENCES "SupplierQuotation"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NegotiationRecord" ADD CONSTRAINT "NegotiationRecord_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NegotiationRecord" ADD CONSTRAINT "NegotiationRecord_businessId_rfqVersionId_fkey" FOREIGN KEY ("businessId", "rfqVersionId") REFERENCES "RfqVersion"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NegotiationRecord" ADD CONSTRAINT "NegotiationRecord_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NegotiationRecord" ADD CONSTRAINT "NegotiationRecord_businessId_attachmentFileId_fkey" FOREIGN KEY ("businessId", "attachmentFileId") REFERENCES "FileObject"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseOrder" ADD CONSTRAINT "PurchaseOrder_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseOrder" ADD CONSTRAINT "PurchaseOrder_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseOrder" ADD CONSTRAINT "PurchaseOrder_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseOrderRevision" ADD CONSTRAINT "PurchaseOrderRevision_businessId_purchaseOrderId_fkey" FOREIGN KEY ("businessId", "purchaseOrderId") REFERENCES "PurchaseOrder"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseOrderLine" ADD CONSTRAINT "PurchaseOrderLine_businessId_purchaseOrderId_fkey" FOREIGN KEY ("businessId", "purchaseOrderId") REFERENCES "PurchaseOrder"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseOrderLine" ADD CONSTRAINT "PurchaseOrderLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseOrderApproval" ADD CONSTRAINT "PurchaseOrderApproval_businessId_purchaseOrderId_fkey" FOREIGN KEY ("businessId", "purchaseOrderId") REFERENCES "PurchaseOrder"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierConfirmation" ADD CONSTRAINT "SupplierConfirmation_businessId_purchaseOrderId_fkey" FOREIGN KEY ("businessId", "purchaseOrderId") REFERENCES "PurchaseOrder"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GoodsReceipt" ADD CONSTRAINT "GoodsReceipt_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GoodsReceipt" ADD CONSTRAINT "GoodsReceipt_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GoodsReceipt" ADD CONSTRAINT "GoodsReceipt_businessId_purchaseOrderId_branchId_fkey" FOREIGN KEY ("businessId", "purchaseOrderId", "branchId") REFERENCES "PurchaseOrder"("businessId", "id", "branchId") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "GoodsReceiptLine" ADD CONSTRAINT "GoodsReceiptLine_businessId_purchaseOrderId_branchId_recei_fkey" FOREIGN KEY ("businessId", "purchaseOrderId", "branchId", "receiptId") REFERENCES "GoodsReceipt"("businessId", "purchaseOrderId", "branchId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GoodsReceiptLine" ADD CONSTRAINT "GoodsReceiptLine_businessId_purchaseOrderId_purchaseOrderL_fkey" FOREIGN KEY ("businessId", "purchaseOrderId", "purchaseOrderLineId", "variantId") REFERENCES "PurchaseOrderLine"("businessId", "purchaseOrderId", "id", "variantId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GoodsReceiptLine" ADD CONSTRAINT "GoodsReceiptLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierInvoice" ADD CONSTRAINT "SupplierInvoice_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierInvoice" ADD CONSTRAINT "SupplierInvoice_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierInvoice" ADD CONSTRAINT "SupplierInvoice_businessId_supplierId_purchaseOrderId_fkey" FOREIGN KEY ("businessId", "supplierId", "purchaseOrderId") REFERENCES "PurchaseOrder"("businessId", "supplierId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierInvoiceLine" ADD CONSTRAINT "SupplierInvoiceLine_invoice_fkey" FOREIGN KEY ("businessId", "supplierId", "supplierInvoiceId") REFERENCES "SupplierInvoice"("businessId", "supplierId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierInvoiceLine" ADD CONSTRAINT "SupplierInvoiceLine_po_binding_fkey" FOREIGN KEY ("businessId", "supplierId", "supplierInvoiceId", "purchaseOrderId") REFERENCES "SupplierInvoice"("businessId", "supplierId", "id", "purchaseOrderId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierInvoiceLine" ADD CONSTRAINT "SupplierInvoiceLine_businessId_purchaseOrderId_purchaseOrd_fkey" FOREIGN KEY ("businessId", "purchaseOrderId", "purchaseOrderLineId", "variantId") REFERENCES "PurchaseOrderLine"("businessId", "purchaseOrderId", "id", "variantId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierInvoiceLine" ADD CONSTRAINT "SupplierInvoiceLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierPayment" ADD CONSTRAINT "SupplierPayment_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierPayment" ADD CONSTRAINT "SupplierPayment_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentAllocation" ADD CONSTRAINT "PaymentAllocation_businessId_supplierId_supplierPaymentId_fkey" FOREIGN KEY ("businessId", "supplierId", "supplierPaymentId") REFERENCES "SupplierPayment"("businessId", "supplierId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentAllocation" ADD CONSTRAINT "PaymentAllocation_businessId_supplierId_supplierInvoiceId_fkey" FOREIGN KEY ("businessId", "supplierId", "supplierInvoiceId") REFERENCES "SupplierInvoice"("businessId", "supplierId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_businessId_mergedIntoId_fkey" FOREIGN KEY ("businessId", "mergedIntoId") REFERENCES "Customer"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerContact" ADD CONSTRAINT "CustomerContact_businessId_customerId_fkey" FOREIGN KEY ("businessId", "customerId") REFERENCES "Customer"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerConsent" ADD CONSTRAINT "CustomerConsent_businessId_customerId_fkey" FOREIGN KEY ("businessId", "customerId") REFERENCES "Customer"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerMergeRequest" ADD CONSTRAINT "CustomerMergeRequest_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerMergeRequest" ADD CONSTRAINT "CustomerMergeRequest_businessId_sourceCustomerId_fkey" FOREIGN KEY ("businessId", "sourceCustomerId") REFERENCES "Customer"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerMergeRequest" ADD CONSTRAINT "CustomerMergeRequest_businessId_targetCustomerId_fkey" FOREIGN KEY ("businessId", "targetCustomerId") REFERENCES "Customer"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerBusinessSummary" ADD CONSTRAINT "CustomerBusinessSummary_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerBusinessSummary" ADD CONSTRAINT "CustomerBusinessSummary_businessId_customerId_fkey" FOREIGN KEY ("businessId", "customerId") REFERENCES "Customer"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Device" ADD CONSTRAINT "Device_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Device" ADD CONSTRAINT "Device_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Device" ADD CONSTRAINT "Device_enrolledUserId_fkey" FOREIGN KEY ("enrolledUserId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SyncSession" ADD CONSTRAINT "SyncSession_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SyncSession" ADD CONSTRAINT "SyncSession_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SyncSession" ADD CONSTRAINT "SyncSession_businessId_deviceId_fkey" FOREIGN KEY ("businessId", "deviceId") REFERENCES "Device"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SyncOperation" ADD CONSTRAINT "SyncOperation_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SyncOperation" ADD CONSTRAINT "SyncOperation_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SyncOperation" ADD CONSTRAINT "SyncOperation_businessId_deviceId_fkey" FOREIGN KEY ("businessId", "deviceId") REFERENCES "Device"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SyncOperation" ADD CONSTRAINT "SyncOperation_businessId_syncSessionId_fkey" FOREIGN KEY ("businessId", "syncSessionId") REFERENCES "SyncSession"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SyncOperation" ADD CONSTRAINT "SyncOperation_businessId_saleId_fkey" FOREIGN KEY ("businessId", "saleId") REFERENCES "Sale"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SyncAttempt" ADD CONSTRAINT "SyncAttempt_syncOperationId_fkey" FOREIGN KEY ("syncOperationId") REFERENCES "SyncOperation"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationException" ADD CONSTRAINT "ReconciliationException_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationException" ADD CONSTRAINT "ReconciliationException_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationException" ADD CONSTRAINT "ReconciliationException_businessId_deviceId_fkey" FOREIGN KEY ("businessId", "deviceId") REFERENCES "Device"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationException" ADD CONSTRAINT "ReconciliationException_businessId_syncOperationId_fkey" FOREIGN KEY ("businessId", "syncOperationId") REFERENCES "SyncOperation"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationException" ADD CONSTRAINT "ReconciliationException_businessId_cashierMembershipId_fkey" FOREIGN KEY ("businessId", "cashierMembershipId") REFERENCES "Membership"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationException" ADD CONSTRAINT "ReconciliationException_businessId_assignedToMembershipId_fkey" FOREIGN KEY ("businessId", "assignedToMembershipId") REFERENCES "Membership"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationException" ADD CONSTRAINT "ReconciliationException_businessId_committedSaleId_fkey" FOREIGN KEY ("businessId", "committedSaleId") REFERENCES "Sale"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationException" ADD CONSTRAINT "ReconciliationException_businessId_correctiveStocktakeId_fkey" FOREIGN KEY ("businessId", "correctiveStocktakeId") REFERENCES "StocktakeSession"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationShortfallLine" ADD CONSTRAINT "ReconciliationShortfallLine_businessId_exceptionId_fkey" FOREIGN KEY ("businessId", "exceptionId") REFERENCES "ReconciliationException"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationShortfallLine" ADD CONSTRAINT "ReconciliationShortfallLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationEvent" ADD CONSTRAINT "ReconciliationEvent_businessId_exceptionId_fkey" FOREIGN KEY ("businessId", "exceptionId") REFERENCES "ReconciliationException"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationEvent" ADD CONSTRAINT "ReconciliationEvent_businessId_evidenceFileId_fkey" FOREIGN KEY ("businessId", "evidenceFileId") REFERENCES "FileObject"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReconciliationEvent" ADD CONSTRAINT "ReconciliationEvent_businessId_actorMembershipId_fkey" FOREIGN KEY ("businessId", "actorMembershipId") REFERENCES "Membership"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ConflictRecord" ADD CONSTRAINT "ConflictRecord_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ConflictRecord" ADD CONSTRAINT "ConflictRecord_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ConflictRecord" ADD CONSTRAINT "ConflictRecord_businessId_deviceId_fkey" FOREIGN KEY ("businessId", "deviceId") REFERENCES "Device"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ConflictRecord" ADD CONSTRAINT "ConflictRecord_businessId_syncOperationId_fkey" FOREIGN KEY ("businessId", "syncOperationId") REFERENCES "SyncOperation"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SyncCursor" ADD CONSTRAINT "SyncCursor_deviceId_fkey" FOREIGN KEY ("deviceId") REFERENCES "Device"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeedEvent" ADD CONSTRAINT "FeedEvent_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeedEvent" ADD CONSTRAINT "FeedEvent_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PosTerminal" ADD CONSTRAINT "PosTerminal_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PosTerminal" ADD CONSTRAINT "PosTerminal_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PosTerminal" ADD CONSTRAINT "PosTerminal_businessId_branchId_deviceId_fkey" FOREIGN KEY ("businessId", "branchId", "deviceId") REFERENCES "Device"("businessId", "branchId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CashierShift" ADD CONSTRAINT "CashierShift_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CashierShift" ADD CONSTRAINT "CashierShift_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CashierShift" ADD CONSTRAINT "CashierShift_businessId_branchId_terminalId_fkey" FOREIGN KEY ("businessId", "branchId", "terminalId") REFERENCES "PosTerminal"("businessId", "branchId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CashierShift" ADD CONSTRAINT "CashierShift_businessId_cashierMembershipId_fkey" FOREIGN KEY ("businessId", "cashierMembershipId") REFERENCES "Membership"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShiftCashMovement" ADD CONSTRAINT "ShiftCashMovement_businessId_shiftId_fkey" FOREIGN KEY ("businessId", "shiftId") REFERENCES "CashierShift"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sale" ADD CONSTRAINT "Sale_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sale" ADD CONSTRAINT "Sale_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sale" ADD CONSTRAINT "Sale_businessId_branchId_terminalId_fkey" FOREIGN KEY ("businessId", "branchId", "terminalId") REFERENCES "PosTerminal"("businessId", "branchId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sale" ADD CONSTRAINT "Sale_businessId_branchId_shiftId_fkey" FOREIGN KEY ("businessId", "branchId", "shiftId") REFERENCES "CashierShift"("businessId", "branchId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sale" ADD CONSTRAINT "Sale_businessId_customerId_fkey" FOREIGN KEY ("businessId", "customerId") REFERENCES "Customer"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sale" ADD CONSTRAINT "Sale_businessId_cashierMembershipId_fkey" FOREIGN KEY ("businessId", "cashierMembershipId") REFERENCES "Membership"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sale" ADD CONSTRAINT "Sale_businessId_offlineDeviceId_fkey" FOREIGN KEY ("businessId", "offlineDeviceId") REFERENCES "Device"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleLine" ADD CONSTRAINT "SaleLine_businessId_branchId_saleId_fkey" FOREIGN KEY ("businessId", "branchId", "saleId") REFERENCES "Sale"("businessId", "branchId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleLine" ADD CONSTRAINT "SaleLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleLine" ADD CONSTRAINT "SaleLine_businessId_branchId_variantId_batchId_fkey" FOREIGN KEY ("businessId", "branchId", "variantId", "batchId") REFERENCES "InventoryBatch"("businessId", "branchId", "variantId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SalePayment" ADD CONSTRAINT "SalePayment_businessId_saleId_fkey" FOREIGN KEY ("businessId", "saleId") REFERENCES "Sale"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleDiscount" ADD CONSTRAINT "SaleDiscount_businessId_saleId_fkey" FOREIGN KEY ("businessId", "saleId") REFERENCES "Sale"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleDiscount" ADD CONSTRAINT "SaleDiscount_businessId_discountId_fkey" FOREIGN KEY ("businessId", "discountId") REFERENCES "Discount"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleVoid" ADD CONSTRAINT "SaleVoid_businessId_saleId_fkey" FOREIGN KEY ("businessId", "saleId") REFERENCES "Sale"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Receipt" ADD CONSTRAINT "Receipt_businessId_saleId_fkey" FOREIGN KEY ("businessId", "saleId") REFERENCES "Sale"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Receipt" ADD CONSTRAINT "Receipt_businessId_fileId_fkey" FOREIGN KEY ("businessId", "fileId") REFERENCES "FileObject"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Receipt" ADD CONSTRAINT "Receipt_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReceiptBlock" ADD CONSTRAINT "ReceiptBlock_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReceiptBlock" ADD CONSTRAINT "ReceiptBlock_businessId_deviceId_fkey" FOREIGN KEY ("businessId", "deviceId") REFERENCES "Device"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleCustomerAssociation" ADD CONSTRAINT "SaleCustomerAssociation_businessId_saleId_fkey" FOREIGN KEY ("businessId", "saleId") REFERENCES "Sale"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleCustomerAssociation" ADD CONSTRAINT "SaleCustomerAssociation_businessId_customerId_fkey" FOREIGN KEY ("businessId", "customerId") REFERENCES "Customer"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReturnRequest" ADD CONSTRAINT "ReturnRequest_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReturnRequest" ADD CONSTRAINT "ReturnRequest_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReturnRequest" ADD CONSTRAINT "ReturnRequest_businessId_saleId_fkey" FOREIGN KEY ("businessId", "saleId") REFERENCES "Sale"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReturnLine" ADD CONSTRAINT "ReturnLine_businessId_saleId_returnId_fkey" FOREIGN KEY ("businessId", "saleId", "returnId") REFERENCES "ReturnRequest"("businessId", "saleId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReturnLine" ADD CONSTRAINT "ReturnLine_businessId_saleId_saleLineId_fkey" FOREIGN KEY ("businessId", "saleId", "saleLineId") REFERENCES "SaleLine"("businessId", "saleId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReturnInspection" ADD CONSTRAINT "ReturnInspection_businessId_returnId_fkey" FOREIGN KEY ("businessId", "returnId") REFERENCES "ReturnRequest"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Refund" ADD CONSTRAINT "Refund_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Refund" ADD CONSTRAINT "Refund_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Refund" ADD CONSTRAINT "Refund_businessId_saleId_returnId_fkey" FOREIGN KEY ("businessId", "saleId", "returnId") REFERENCES "ReturnRequest"("businessId", "saleId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Refund" ADD CONSTRAINT "Refund_businessId_saleId_fkey" FOREIGN KEY ("businessId", "saleId") REFERENCES "Sale"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RefundAllocation" ADD CONSTRAINT "RefundAllocation_businessId_saleId_refundId_fkey" FOREIGN KEY ("businessId", "saleId", "refundId") REFERENCES "Refund"("businessId", "saleId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RefundAllocation" ADD CONSTRAINT "RefundAllocation_businessId_saleId_salePaymentId_fkey" FOREIGN KEY ("businessId", "saleId", "salePaymentId") REFERENCES "SalePayment"("businessId", "saleId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exchange" ADD CONSTRAINT "Exchange_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exchange" ADD CONSTRAINT "Exchange_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exchange" ADD CONSTRAINT "Exchange_businessId_saleId_fkey" FOREIGN KEY ("businessId", "saleId") REFERENCES "Sale"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exchange" ADD CONSTRAINT "Exchange_businessId_saleId_returnId_fkey" FOREIGN KEY ("businessId", "saleId", "returnId") REFERENCES "ReturnRequest"("businessId", "saleId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExchangeLine" ADD CONSTRAINT "ExchangeLine_businessId_exchangeId_fkey" FOREIGN KEY ("businessId", "exchangeId") REFERENCES "Exchange"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExchangeLine" ADD CONSTRAINT "ExchangeLine_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExchangeReservation" ADD CONSTRAINT "ExchangeReservation_businessId_exchangeId_fkey" FOREIGN KEY ("businessId", "exchangeId") REFERENCES "Exchange"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExchangeReservation" ADD CONSTRAINT "ExchangeReservation_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CollectionFollowUp" ADD CONSTRAINT "CollectionFollowUp_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CollectionFollowUp" ADD CONSTRAINT "CollectionFollowUp_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CollectionFollowUp" ADD CONSTRAINT "CollectionFollowUp_businessId_customerId_fkey" FOREIGN KEY ("businessId", "customerId") REFERENCES "Customer"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CollectionFollowUp" ADD CONSTRAINT "CollectionFollowUp_businessId_saleId_fkey" FOREIGN KEY ("businessId", "saleId") REFERENCES "Sale"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CollectionFollowUp" ADD CONSTRAINT "CollectionFollowUp_businessId_returnId_fkey" FOREIGN KEY ("businessId", "returnId") REFERENCES "ReturnRequest"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NotificationTemplate" ADD CONSTRAINT "NotificationTemplate_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_recipientUserId_fkey" FOREIGN KEY ("recipientUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_businessId_templateId_fkey" FOREIGN KEY ("businessId", "templateId") REFERENCES "NotificationTemplate"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NotificationDelivery" ADD CONSTRAINT "NotificationDelivery_businessId_notificationId_fkey" FOREIGN KEY ("businessId", "notificationId") REFERENCES "Notification"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NotificationPreference" ADD CONSTRAINT "NotificationPreference_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NotificationEscalation" ADD CONSTRAINT "NotificationEscalation_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NotificationEscalation" ADD CONSTRAINT "NotificationEscalation_businessId_notificationId_fkey" FOREIGN KEY ("businessId", "notificationId") REFERENCES "Notification"("businessId", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReportDefinition" ADD CONSTRAINT "ReportDefinition_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExportJob" ADD CONSTRAINT "ExportJob_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExportJob" ADD CONSTRAINT "ExportJob_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExportJob" ADD CONSTRAINT "ExportJob_businessId_reportDefinitionId_fkey" FOREIGN KEY ("businessId", "reportDefinitionId") REFERENCES "ReportDefinition"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExportJob" ADD CONSTRAINT "ExportJob_businessId_fileId_fkey" FOREIGN KEY ("businessId", "fileId") REFERENCES "FileObject"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SalesDailyFact" ADD CONSTRAINT "SalesDailyFact_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SalesDailyFact" ADD CONSTRAINT "SalesDailyFact_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductSalesDailyFact" ADD CONSTRAINT "ProductSalesDailyFact_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductSalesDailyFact" ADD CONSTRAINT "ProductSalesDailyFact_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductSalesDailyFact" ADD CONSTRAINT "ProductSalesDailyFact_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryDailyFact" ADD CONSTRAINT "InventoryDailyFact_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryDailyFact" ADD CONSTRAINT "InventoryDailyFact_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryDailyFact" ADD CONSTRAINT "InventoryDailyFact_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockoutEvent" ADD CONSTRAINT "StockoutEvent_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockoutEvent" ADD CONSTRAINT "StockoutEvent_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StockoutEvent" ADD CONSTRAINT "StockoutEvent_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExpiryRiskFact" ADD CONSTRAINT "ExpiryRiskFact_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExpiryRiskFact" ADD CONSTRAINT "ExpiryRiskFact_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExpiryRiskFact" ADD CONSTRAINT "ExpiryRiskFact_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExpiryRiskFact" ADD CONSTRAINT "ExpiryRiskFact_businessId_branchId_variantId_batchId_fkey" FOREIGN KEY ("businessId", "branchId", "variantId", "batchId") REFERENCES "InventoryBatch"("businessId", "branchId", "variantId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierPerformanceFact" ADD CONSTRAINT "SupplierPerformanceFact_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierPerformanceFact" ADD CONSTRAINT "SupplierPerformanceFact_businessId_supplierId_fkey" FOREIGN KEY ("businessId", "supplierId") REFERENCES "Supplier"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ForecastRun" ADD CONSTRAINT "ForecastRun_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ForecastRun" ADD CONSTRAINT "ForecastRun_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ForecastRun" ADD CONSTRAINT "ForecastRun_modelId_fkey" FOREIGN KEY ("modelId") REFERENCES "ForecastModel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ForecastPoint" ADD CONSTRAINT "ForecastPoint_forecastRunId_fkey" FOREIGN KEY ("forecastRunId") REFERENCES "ForecastRun"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Recommendation" ADD CONSTRAINT "Recommendation_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Recommendation" ADD CONSTRAINT "Recommendation_businessId_branchId_fkey" FOREIGN KEY ("businessId", "branchId") REFERENCES "Branch"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Recommendation" ADD CONSTRAINT "Recommendation_businessId_forecastRunId_fkey" FOREIGN KEY ("businessId", "forecastRunId") REFERENCES "ForecastRun"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Recommendation" ADD CONSTRAINT "Recommendation_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Recommendation" ADD CONSTRAINT "Recommendation_businessId_reviewedByMembershipId_fkey" FOREIGN KEY ("businessId", "reviewedByMembershipId") REFERENCES "Membership"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatureSnapshot" ADD CONSTRAINT "FeatureSnapshot_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatureSnapshot" ADD CONSTRAINT "FeatureSnapshot_businessId_variantId_fkey" FOREIGN KEY ("businessId", "variantId") REFERENCES "ProductVariant"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModelMetric" ADD CONSTRAINT "ModelMetric_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "Business"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModelMetric" ADD CONSTRAINT "ModelMetric_modelId_fkey" FOREIGN KEY ("modelId") REFERENCES "ForecastModel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModelMetric" ADD CONSTRAINT "ModelMetric_businessId_forecastRunId_fkey" FOREIGN KEY ("businessId", "forecastRunId") REFERENCES "ForecastRun"("businessId", "id") ON DELETE RESTRICT ON UPDATE CASCADE;
-- Transfer receipt line quantity validation.
-- Allows received quantities to remain pending inspection.
ALTER TABLE "TransferReceiptLine"
  ADD CONSTRAINT "transfer_receipt_line_quantities_valid"
  CHECK (
    "quantityReceived" >= 0 AND
    "quantityAccepted" >= 0 AND
    "quantityRejected" >= 0 AND
    "quantityAccepted" + "quantityRejected" <= "quantityReceived"
  );
-- Cumulative stock transfer quantity validation.
ALTER TABLE "StockTransferLine"
  ADD CONSTRAINT "stock_transfer_quantities_valid"
  CHECK (
    "requestedQuantity" > 0 AND
    "dispatchedQuantity" >= 0 AND
    "dispatchedQuantity" <= "requestedQuantity" AND
    "receivedQuantity" >= 0 AND
    "receivedQuantity" <= "dispatchedQuantity" AND
    "acceptedQuantity" >= 0 AND
    "rejectedQuantity" >= 0 AND
    "acceptedQuantity" + "rejectedQuantity" <= "receivedQuantity"
  );
-- ============================================================
-- REMAINING BASELINE CHECK CONSTRAINTS
-- ============================================================

-- Stock and inventory
ALTER TABLE "StockBalance"
  ADD CONSTRAINT "stock_balance_quantities_nonnegative"
  CHECK ("quantityOnHand" >= 0 AND "quantityReserved" >= 0 AND "quantityInTransit" >= 0);

ALTER TABLE "StockBalance"
  ADD CONSTRAINT "stock_balance_reserved_within_on_hand"
  CHECK ("quantityReserved" <= "quantityOnHand");

ALTER TABLE "InventoryBatch"
  ADD CONSTRAINT "inventory_batch_quantities_valid"
  CHECK ("quantityReceived" >= 0 AND "quantityRemaining" >= 0 AND "quantityRemaining" <= "quantityReceived");

ALTER TABLE "InventoryValuationSnapshot"
  ADD CONSTRAINT "inventory_valuation_nonnegative"
  CHECK ("quantity" >= 0 AND "unitCost" >= 0 AND "totalValue" >= 0);

ALTER TABLE "StockLossRecord"
  ADD CONSTRAINT "stock_loss_quantity_positive"
  CHECK ("quantity" > 0);

ALTER TABLE "StocktakeLine"
  ADD CONSTRAINT "stocktake_quantities_nonnegative"
  CHECK ("systemQuantity" >= 0 AND ("countedQuantity" IS NULL OR "countedQuantity" >= 0));

-- Sales, purchasing and money
ALTER TABLE "Sale"
  ADD CONSTRAINT "sale_totals_nonnegative"
  CHECK (
    "subtotal" >= 0 AND "discountTotal" >= 0 AND "total" >= 0 AND
    "paidTotal" >= 0 AND "changeTotal" >= 0
  );

ALTER TABLE "SaleLine"
  ADD CONSTRAINT "sale_line_values_valid"
  CHECK ("quantity" > 0 AND "unitPrice" >= 0 AND "discountAmount" >= 0 AND "lineTotal" >= 0);

ALTER TABLE "SalePayment"
  ADD CONSTRAINT "sale_payment_amount_positive"
  CHECK ("amount" > 0);

ALTER TABLE "Refund"
  ADD CONSTRAINT "refund_amount_positive"
  CHECK ("amount" > 0);

ALTER TABLE "ProductPrice"
  ADD CONSTRAINT "product_price_nonnegative"
  CHECK ("amount" >= 0);

ALTER TABLE "PurchaseOrderLine"
  ADD CONSTRAINT "purchase_order_line_values_valid"
  CHECK ("orderedQuantity" > 0 AND "unitCost" >= 0 AND "lineTotal" >= 0);

ALTER TABLE "GoodsReceiptLine"
  ADD CONSTRAINT "goods_receipt_line_quantities_valid"
  CHECK (
    "receivedQuantity" >= 0 AND "acceptedQuantity" >= 0 AND
    "rejectedQuantity" >= 0 AND "damagedQuantity" >= 0 AND
    "acceptedQuantity" + "rejectedQuantity" + "damagedQuantity" <= "receivedQuantity"
  );

ALTER TABLE "ReturnLine"
  ADD CONSTRAINT "return_line_values_valid"
  CHECK (
    "quantityRequested" > 0 AND
    ("quantityApproved" IS NULL OR "quantityApproved" >= 0) AND
    "restockQuantity" >= 0 AND "unitPrice" >= 0
  );

-- Offline reconciliation
ALTER TABLE "ReconciliationException"
  ADD CONSTRAINT "reconciliation_revalidation_once"
  CHECK ("revalidationCount" BETWEEN 0 AND 1);

-- C-3 integrity resolution
ALTER TABLE "ProductAttributeValue"
  ADD CONSTRAINT "product_attribute_value_exactly_one_owner"
  CHECK (("productId" IS NOT NULL) <> ("variantId" IS NOT NULL));

ALTER TABLE "StockTransfer"
  ADD CONSTRAINT "stock_transfer_distinct_branches"
  CHECK ("fromBranchId" <> "toBranchId");

ALTER TABLE "SupplierInvoiceLine"
  ADD CONSTRAINT "supplier_invoice_line_po_link_complete"
  CHECK (
    ("purchaseOrderId" IS NULL) = ("purchaseOrderLineId" IS NULL) AND
    ("purchaseOrderLineId" IS NULL OR "variantId" IS NOT NULL)
  );

-- ============================================================
-- PARTIAL UNIQUE INDEXES
-- ============================================================

-- One owner per business
CREATE UNIQUE INDEX "membership_one_owner_per_business"
  ON "Membership" ("businessId")
  WHERE "isOwner" = true;

-- One open shift per terminal
CREATE UNIQUE INDEX "cashier_shift_one_open_per_terminal"
  ON "CashierShift" ("businessId", "terminalId")
  WHERE "status" = 'OPEN';

-- Global system role uniqueness
CREATE UNIQUE INDEX "role_system_code_unique"
  ON "Role" ("code")
  WHERE "businessId" IS NULL;

-- Global unit uniqueness
CREATE UNIQUE INDEX "unit_global_code_unique"
  ON "Unit" ("code")
  WHERE "businessId" IS NULL;

-- One unbatched stocktake line per session and variant
CREATE UNIQUE INDEX "stocktake_line_unbatched_unique"
  ON "StocktakeLine" ("sessionId", "variantId")
  WHERE "batchId" IS NULL;

-- Platform-scoped idempotency uniqueness
CREATE UNIQUE INDEX "idempotency_record_platform_unique"
  ON "IdempotencyRecord" ("scope", "key")
  WHERE "businessId" IS NULL;

-- One unbatched goods receipt line per PO line
CREATE UNIQUE INDEX "goods_receipt_line_unbatched_unique"
  ON "GoodsReceiptLine" ("receiptId", "purchaseOrderLineId")
  WHERE "batchNumber" IS NULL;

-- One active branch assignment per membership
CREATE UNIQUE INDEX "membership_branch_assignment_active_unique"
  ON "MembershipBranchAssignment" ("membershipId", "branchId")
  WHERE "revokedAt" IS NULL;