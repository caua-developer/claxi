CREATE TABLE
    IF NOT EXISTS credit_accounts (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL UNIQUE,
        balance BIGINT NOT NULL DEFAULT 0,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE RESTRICT,
        CONSTRAINT ck_credit_accounts_balance CHECK (balance >= 0)
    );
