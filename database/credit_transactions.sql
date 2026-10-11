CREATE TABLE
    IF NOT EXISTS credit_transactions (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL,
        credit_account_id UUID NOT NULL,
        generation_operation_id UUID,
        transaction_type TEXT NOT NULL,
        amount BIGINT NOT NULL,
        balance_after BIGINT NOT NULL,
        idempotency_key VARCHAR(160),
        description TEXT,
        created_by UUID,
        metadata JSONB NOT NULL DEFAULT '{}'::JSONB,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organization (id) ON DELETE RESTRICT,
        FOREIGN KEY (credit_account_id) REFERENCES credit_accounts (id) ON DELETE RESTRICT,
        FOREIGN KEY (generation_operation_id) REFERENCES ai_generation_operations (id) ON DELETE RESTRICT,
        FOREIGN KEY (created_by) REFERENCES "user" (id) ON DELETE SET NULL,
        FOREIGN KEY (transaction_type) REFERENCES credit_transaction_types (id) ON DELETE RESTRICT,
        CONSTRAINT ck_credit_transaction_amount CHECK (
            (transaction_type = 'CONSUMPTION' AND amount < 0)
            OR (transaction_type IN ('PURCHASE', 'GRANT', 'REFUND') AND amount > 0)
            OR (transaction_type = 'ADJUSTMENT' AND amount <> 0)
        ),
        CONSTRAINT ck_credit_transaction_balance CHECK (balance_after >= 0)
    );

CREATE INDEX IF NOT EXISTS credit_transactions_organization_id_created_at_idx ON credit_transactions (organization_id, created_at DESC);
CREATE INDEX IF NOT EXISTS credit_transactions_credit_account_id_created_at_idx ON credit_transactions (credit_account_id, created_at DESC);
CREATE INDEX IF NOT EXISTS credit_transactions_generation_operation_id_idx ON credit_transactions (generation_operation_id);
CREATE UNIQUE INDEX IF NOT EXISTS credit_transactions_organization_id_idempotency_key_idx
    ON credit_transactions (organization_id, idempotency_key)
    WHERE idempotency_key IS NOT NULL;
