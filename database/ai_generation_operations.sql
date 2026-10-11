CREATE TABLE
    IF NOT EXISTS ai_generation_operations (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL,
        requested_by UUID NOT NULL,
        question_id UUID,
        operation_type TEXT NOT NULL DEFAULT 'QUESTION_GENERATION',
        provider VARCHAR(100) NOT NULL,
        model VARCHAR(160) NOT NULL,
        prompt_version VARCHAR(80) NOT NULL,
        status TEXT NOT NULL DEFAULT 'PENDING',
        input_tokens INTEGER,
        output_tokens INTEGER,
        credits_charged INTEGER NOT NULL DEFAULT 0,
        estimated_cost NUMERIC(14, 6),
        actual_cost NUMERIC(14, 6),
        latency_ms BIGINT,
        idempotency_key VARCHAR(160),
        error_code VARCHAR(100),
        error_message TEXT,
        metadata JSONB NOT NULL DEFAULT '{}'::JSONB,
        started_at TIMESTAMPTZ,
        completed_at TIMESTAMPTZ,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE RESTRICT,
        FOREIGN KEY (requested_by) REFERENCES users (id) ON DELETE RESTRICT,
        FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE SET NULL,
        FOREIGN KEY (operation_type) REFERENCES ai_operation_types (id) ON DELETE RESTRICT,
        FOREIGN KEY (status) REFERENCES ai_operation_statuses (id) ON DELETE RESTRICT,
        CONSTRAINT ck_ai_input_tokens CHECK (input_tokens IS NULL OR input_tokens >= 0),
        CONSTRAINT ck_ai_output_tokens CHECK (output_tokens IS NULL OR output_tokens >= 0),
        CONSTRAINT ck_ai_credits_charged CHECK (credits_charged >= 0),
        CONSTRAINT ck_ai_estimated_cost CHECK (estimated_cost IS NULL OR estimated_cost >= 0),
        CONSTRAINT ck_ai_actual_cost CHECK (actual_cost IS NULL OR actual_cost >= 0),
        CONSTRAINT ck_ai_latency CHECK (latency_ms IS NULL OR latency_ms >= 0)
    );

CREATE INDEX IF NOT EXISTS ai_generation_operations_organization_id_created_at_idx ON ai_generation_operations (organization_id, created_at DESC);
CREATE INDEX IF NOT EXISTS ai_generation_operations_status_created_at_idx ON ai_generation_operations (status, created_at);
CREATE INDEX IF NOT EXISTS ai_generation_operations_question_id_idx ON ai_generation_operations (question_id);
CREATE UNIQUE INDEX IF NOT EXISTS ai_generation_operations_organization_id_idempotency_key_idx
    ON ai_generation_operations (organization_id, idempotency_key)
    WHERE idempotency_key IS NOT NULL;
