-- ==============================================================================
-- Claxi — Setup do banco de dados
-- Gerado a partir dos arquivos individuais em database/, na ordem correta de
-- dependencias (FOREIGN KEY). Nao editar diretamente: altere o arquivo da
-- entidade correspondente e regenere este arquivo.
-- ==============================================================================

-- -----------------------------------------------------------------------------
-- users.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS users (
        id UUID NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        email_verified BOOLEAN NOT NULL,
        image TEXT,
        created_at TIMESTAMPTZ NOT NULL,
        updated_at TIMESTAMPTZ NOT NULL
    );

-- -----------------------------------------------------------------------------
-- organizations.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS organizations (
        id UUID NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        slug TEXT NOT NULL UNIQUE,
        logo TEXT,
        metadata JSONB,
        created_at TIMESTAMPTZ NOT NULL
    );


-- -----------------------------------------------------------------------------
-- verifications.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS verifications (
        id UUID NOT NULL PRIMARY KEY,
        identifier TEXT NOT NULL,
        value TEXT NOT NULL,
        expires_at TIMESTAMPTZ NOT NULL,
        created_at TIMESTAMPTZ NOT NULL,
        updated_at TIMESTAMPTZ NOT NULL
    );

CREATE INDEX IF NOT EXISTS verifications_identifier_idx ON verifications (identifier);

-- -----------------------------------------------------------------------------
-- ai_operation_statuses.sql
-- -----------------------------------------------------------------------------
-- Lookup table for ai_generation_operations.status values.
CREATE TABLE
    IF NOT EXISTS ai_operation_statuses (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    ai_operation_statuses (id, description)
VALUES
    ('PENDING', 'Pendente'),
    ('RUNNING', 'Em execução'),
    ('SUCCEEDED', 'Concluída com sucesso'),
    ('FAILED', 'Falhou'),
    ('CANCELLED', 'Cancelada')
ON CONFLICT (id) DO NOTHING;


-- -----------------------------------------------------------------------------
-- ai_operation_types.sql
-- -----------------------------------------------------------------------------
-- Lookup table for ai_generation_operations.operation_type values.
CREATE TABLE
    IF NOT EXISTS ai_operation_types (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    ai_operation_types (id, description)
VALUES
    ('QUESTION_GENERATION', 'Geração de questão'),
    ('QUESTION_REGENERATION', 'Regeneração de questão')
ON CONFLICT (id) DO NOTHING;


-- -----------------------------------------------------------------------------
-- assessment_statuses.sql
-- -----------------------------------------------------------------------------
-- Lookup table for assessments.status values.
CREATE TABLE
    IF NOT EXISTS assessment_statuses (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    assessment_statuses (id, description)
VALUES
    ('DRAFT', 'Rascunho'),
    ('PUBLISHED', 'Publicada'),
    ('ARCHIVED', 'Arquivada')
ON CONFLICT (id) DO NOTHING;


-- -----------------------------------------------------------------------------
-- assessment_types.sql
-- -----------------------------------------------------------------------------
-- Lookup table for assessments.type values.
CREATE TABLE
    IF NOT EXISTS assessment_types (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    assessment_types (id, description)
VALUES
    ('TEST', 'Prova'),
    ('EXERCISE_LIST', 'Lista de exercícios'),
    ('SIMULATED_EXAM', 'Simulado')
ON CONFLICT (id) DO NOTHING;


-- -----------------------------------------------------------------------------
-- credit_transaction_types.sql
-- -----------------------------------------------------------------------------
-- Lookup table for credit_transactions.transaction_type values.
CREATE TABLE
    IF NOT EXISTS credit_transaction_types (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    credit_transaction_types (id, description)
VALUES
    ('PURCHASE', 'Compra'),
    ('GRANT', 'Concessão'),
    ('CONSUMPTION', 'Consumo'),
    ('REFUND', 'Reembolso'),
    ('ADJUSTMENT', 'Ajuste')
ON CONFLICT (id) DO NOTHING;


-- -----------------------------------------------------------------------------
-- education_stages.sql
-- -----------------------------------------------------------------------------
-- Lookup table for education_stage values used by grades, bncc_curricular_components and bncc_skills.
CREATE TABLE
    IF NOT EXISTS education_stages (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    education_stages (id, description)
VALUES
    ('EARLY_CHILDHOOD', 'Educação Infantil'),
    ('ELEMENTARY', 'Ensino Fundamental - Anos Iniciais'),
    ('MIDDLE_SCHOOL', 'Ensino Fundamental - Anos Finais'),
    ('HIGH_SCHOOL', 'Ensino Médio'),
    ('OTHER', 'Outro')
ON CONFLICT (id) DO NOTHING;


-- -----------------------------------------------------------------------------
-- file_purposes.sql
-- -----------------------------------------------------------------------------
-- Lookup table for files.purpose values.
CREATE TABLE
    IF NOT EXISTS file_purposes (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    file_purposes (id, description)
VALUES
    ('PDF_EXPORT', 'Exportação em PDF'),
    ('LOGO', 'Logotipo'),
    ('IMPORT', 'Importação'),
    ('OTHER', 'Outro')
ON CONFLICT (id) DO NOTHING;


-- -----------------------------------------------------------------------------
-- question_difficulties.sql
-- -----------------------------------------------------------------------------
-- Lookup table for questions.difficulty values.
CREATE TABLE
    IF NOT EXISTS question_difficulties (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    question_difficulties (id, description)
VALUES
    ('EASY', 'Fácil'),
    ('MEDIUM', 'Médio'),
    ('HARD', 'Difícil') ON CONFLICT (id) DO NOTHING;

-- -----------------------------------------------------------------------------
-- question_sources.sql
-- -----------------------------------------------------------------------------
-- Lookup table for questions.source values.
CREATE TABLE
    IF NOT EXISTS question_sources (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    question_sources (id, description)
VALUES
    ('MANUAL', 'Criada manualmente'),
    ('AI', 'Gerada por IA'),
    ('IMPORT', 'Importada')
ON CONFLICT (id) DO NOTHING;


-- -----------------------------------------------------------------------------
-- question_statuses.sql
-- -----------------------------------------------------------------------------
-- Lookup table for questions.status values.
CREATE TABLE
    IF NOT EXISTS question_statuses (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    question_statuses (id, description)
VALUES
    ('ACTIVE', 'Ativa'),
    ('ARCHIVED', 'Arquivada')
ON CONFLICT (id) DO NOTHING;


-- -----------------------------------------------------------------------------
-- question_types.sql
-- -----------------------------------------------------------------------------
-- Lookup table for questions.type values.
CREATE TABLE
    IF NOT EXISTS question_types (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    question_types (id, description)
VALUES
    ('MULTIPLE_CHOICE', 'Múltipla escolha'),
    ('TRUE_FALSE', 'Verdadeiro ou falso'),
    ('OPEN_ENDED', 'Dissertativa')
ON CONFLICT (id) DO NOTHING;


-- -----------------------------------------------------------------------------
-- providers.sql
-- -----------------------------------------------------------------------------
-- Lookup table for accounts.provider_id values.
CREATE TABLE
    IF NOT EXISTS providers (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    providers (id, description)
VALUES
    ('GOOGLE', 'Google OAuth'),
    ('PASSWORD', 'Senha (local)')
ON CONFLICT (id) DO NOTHING;


-- -----------------------------------------------------------------------------
-- accounts.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS accounts (
        id UUID NOT NULL PRIMARY KEY,
        user_id UUID NOT NULL,
        account_id TEXT NOT NULL,
        provider_id TEXT NOT NULL,
        access_token TEXT,
        refresh_token TEXT,
        access_token_expires_at TIMESTAMPTZ,
        refresh_token_expires_at TIMESTAMPTZ,
        scope TEXT,
        id_token TEXT,
        password TEXT,
        created_at TIMESTAMPTZ NOT NULL,
        updated_at TIMESTAMPTZ NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (provider_id) REFERENCES providers (id) ON DELETE RESTRICT
    );

CREATE INDEX IF NOT EXISTS accounts_user_id_idx ON accounts (user_id);
CREATE INDEX IF NOT EXISTS accounts_provider_id_idx ON accounts (provider_id);


-- -----------------------------------------------------------------------------
-- sessions.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS sessions (
        id UUID NOT NULL PRIMARY KEY,
        user_id UUID NOT NULL,
        organization_id UUID,
        ip_address TEXT,
        user_agent TEXT,
        last_used_at TIMESTAMPTZ,
        revoked_at TIMESTAMPTZ,
        created_at TIMESTAMPTZ NOT NULL,
        updated_at TIMESTAMPTZ NOT NULL,
        expires_at TIMESTAMPTZ NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE SET NULL
    );

CREATE INDEX IF NOT EXISTS sessions_user_id_idx ON sessions (user_id);
CREATE INDEX IF NOT EXISTS sessions_expires_at_idx ON sessions (expires_at);


-- -----------------------------------------------------------------------------
-- members.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS members (
        id UUID NOT NULL PRIMARY KEY,
        user_id UUID NOT NULL,
        organization_id UUID NOT NULL,
        role TEXT NOT NULL,
        created_at TIMESTAMPTZ NOT NULL,
        updated_at TIMESTAMPTZ NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE
    );


-- -----------------------------------------------------------------------------
-- invitations.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS invitations (
        id UUID NOT NULL PRIMARY KEY,
        email TEXT NOT NULL,
        inviter_id UUID NOT NULL,
        organization_id UUID NOT NULL,
        role TEXT,
        status TEXT NOT NULL,
        created_at TIMESTAMPTZ NOT NULL,
        updated_at TIMESTAMPTZ NOT NULL,
        expires_at TIMESTAMPTZ NOT NULL,
        FOREIGN KEY (inviter_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE
    );


-- -----------------------------------------------------------------------------
-- organization_settings.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS organization_settings (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL,
        setting_key VARCHAR(120) NOT NULL,
        setting_value JSONB NOT NULL,
        updated_by UUID,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE,
        FOREIGN KEY (updated_by) REFERENCES users (id) ON DELETE SET NULL,
        CONSTRAINT uq_organization_settings_org_key UNIQUE (organization_id, setting_key)
    );

CREATE INDEX IF NOT EXISTS organization_settings_organization_id_idx ON organization_settings (organization_id);

-- -----------------------------------------------------------------------------
-- credit_accounts.sql
-- -----------------------------------------------------------------------------
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


-- -----------------------------------------------------------------------------
-- files.sql
-- -----------------------------------------------------------------------------
-- Binary files remain in Cloudflare R2; this table only tracks metadata.
CREATE TABLE
    IF NOT EXISTS files (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL,
        uploaded_by UUID NOT NULL,
        storage_key TEXT NOT NULL UNIQUE,
        filename VARCHAR(255) NOT NULL,
        content_type VARCHAR(160) NOT NULL,
        size_bytes BIGINT NOT NULL,
        purpose TEXT NOT NULL DEFAULT 'OTHER',
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE,
        FOREIGN KEY (uploaded_by) REFERENCES users (id) ON DELETE RESTRICT,
        FOREIGN KEY (purpose) REFERENCES file_purposes (id) ON DELETE RESTRICT,
        CONSTRAINT ck_files_size CHECK (size_bytes >= 0)
    );

CREATE INDEX IF NOT EXISTS files_organization_id_created_at_idx ON files (organization_id, created_at DESC);


-- -----------------------------------------------------------------------------
-- grades.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS grades (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL,
        name VARCHAR(80) NOT NULL,
        order_index INTEGER NOT NULL,
        education_stage TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE,
        FOREIGN KEY (education_stage) REFERENCES education_stages (id) ON DELETE RESTRICT,
        CONSTRAINT uq_grades_organization_name UNIQUE (organization_id, name),
        CONSTRAINT ck_grades_order_index CHECK (order_index >= 0)
    );

CREATE INDEX IF NOT EXISTS grades_organization_id_order_index_idx ON grades (organization_id, order_index);
CREATE INDEX IF NOT EXISTS grades_education_stage_idx ON grades (education_stage);


-- -----------------------------------------------------------------------------
-- subjects.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS subjects (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL,
        name VARCHAR(120) NOT NULL,
        description TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE,
        CONSTRAINT uq_subjects_organization_name UNIQUE (organization_id, name)
    );

CREATE INDEX IF NOT EXISTS subjects_organization_id_idx ON subjects (organization_id);


-- -----------------------------------------------------------------------------
-- bncc_curricular_components.sql
-- -----------------------------------------------------------------------------
-- Platform-wide reference catalog, not tenant-owned.
-- Import official BNCC data through a versioned seed/import process;
-- do not treat codes/descriptions as tenant-editable records.
CREATE TABLE
    IF NOT EXISTS bncc_curricular_components (
        id UUID NOT NULL PRIMARY KEY,
        code VARCHAR(40) NOT NULL UNIQUE,
        name VARCHAR(180) NOT NULL,
        knowledge_area VARCHAR(180),
        education_stage TEXT NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (education_stage) REFERENCES education_stages (id) ON DELETE RESTRICT
    );

CREATE INDEX IF NOT EXISTS bncc_curricular_components_education_stage_idx ON bncc_curricular_components (education_stage);


-- -----------------------------------------------------------------------------
-- assessments.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS assessments (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL,
        created_by UUID NOT NULL,
        title VARCHAR(200) NOT NULL,
        description TEXT,
        type TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'DRAFT',
        instructions TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        archived_at TIMESTAMPTZ,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE,
        FOREIGN KEY (created_by) REFERENCES users (id) ON DELETE RESTRICT,
        FOREIGN KEY (type) REFERENCES assessment_types (id) ON DELETE RESTRICT,
        FOREIGN KEY (status) REFERENCES assessment_statuses (id) ON DELETE RESTRICT
    );

CREATE INDEX IF NOT EXISTS assessments_organization_id_status_updated_at_idx ON assessments (organization_id, status, updated_at DESC);
CREATE INDEX IF NOT EXISTS assessments_created_by_idx ON assessments (created_by);


-- -----------------------------------------------------------------------------
-- audit_logs.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS audit_logs (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID,
        actor_user_id UUID,
        action VARCHAR(120) NOT NULL,
        entity_type VARCHAR(120),
        entity_id UUID,
        ip_address INET,
        user_agent TEXT,
        metadata JSONB NOT NULL DEFAULT '{}'::JSONB,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE SET NULL,
        FOREIGN KEY (actor_user_id) REFERENCES users (id) ON DELETE SET NULL
    );

CREATE INDEX IF NOT EXISTS audit_logs_organization_id_created_at_idx ON audit_logs (organization_id, created_at DESC);
CREATE INDEX IF NOT EXISTS audit_logs_actor_user_id_created_at_idx ON audit_logs (actor_user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS audit_logs_entity_type_entity_id_idx ON audit_logs (entity_type, entity_id);


-- -----------------------------------------------------------------------------
-- refresh_tokens.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS refresh_tokens (
        id UUID NOT NULL PRIMARY KEY,
        session_id UUID NOT NULL,
        token_hash TEXT NOT NULL UNIQUE,
        revoked_at TIMESTAMPTZ,
        created_at TIMESTAMPTZ NOT NULL,
        expires_at TIMESTAMPTZ NOT NULL,
        FOREIGN KEY (session_id) REFERENCES sessions (id) ON DELETE CASCADE
    );

CREATE INDEX IF NOT EXISTS refresh_tokens_session_id_idx ON refresh_tokens (session_id);
CREATE INDEX IF NOT EXISTS refresh_tokens_expires_at_idx ON refresh_tokens (expires_at);


-- -----------------------------------------------------------------------------
-- topics.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS topics (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL,
        subject_id UUID NOT NULL,
        name VARCHAR(160) NOT NULL,
        description TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE,
        FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE RESTRICT,
        CONSTRAINT uq_topics_subject_name UNIQUE (subject_id, name)
    );

CREATE INDEX IF NOT EXISTS topics_organization_id_idx ON topics (organization_id);
CREATE INDEX IF NOT EXISTS topics_subject_id_idx ON topics (subject_id);


-- -----------------------------------------------------------------------------
-- bncc_skills.sql
-- -----------------------------------------------------------------------------
-- Platform-wide reference catalog, not tenant-owned.
-- Import official BNCC data through a versioned seed/import process;
-- do not treat codes/descriptions as tenant-editable records.
CREATE TABLE
    IF NOT EXISTS bncc_skills (
        id UUID NOT NULL PRIMARY KEY,
        code VARCHAR(40) NOT NULL UNIQUE,
        description TEXT NOT NULL,
        education_stage TEXT NOT NULL,
        grade_code VARCHAR(40),
        knowledge_area VARCHAR(180),
        curricular_component_id UUID,
        thematic_unit VARCHAR(180),
        object_of_knowledge TEXT,
        source_version VARCHAR(80) NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (curricular_component_id) REFERENCES bncc_curricular_components (id) ON DELETE RESTRICT,
        FOREIGN KEY (education_stage) REFERENCES education_stages (id) ON DELETE RESTRICT
    );

CREATE INDEX IF NOT EXISTS bncc_skills_curricular_component_id_idx ON bncc_skills (curricular_component_id);
CREATE INDEX IF NOT EXISTS bncc_skills_education_stage_grade_code_idx ON bncc_skills (education_stage, grade_code);
CREATE INDEX IF NOT EXISTS bncc_skills_knowledge_area_idx ON bncc_skills (knowledge_area);


-- -----------------------------------------------------------------------------
-- questions.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS questions (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL,
        subject_id UUID,
        grade_id UUID,
        topic_id UUID,
        type TEXT NOT NULL,
        difficulty TEXT NOT NULL,
        statement TEXT NOT NULL,
        answer TEXT,
        explanation TEXT,
        created_by UUID NOT NULL,
        source TEXT NOT NULL DEFAULT 'MANUAL',
        generation_model VARCHAR(160),
        generation_prompt_version VARCHAR(80),
        status TEXT NOT NULL DEFAULT 'ACTIVE',
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE,
        FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE RESTRICT,
        FOREIGN KEY (grade_id) REFERENCES grades (id) ON DELETE RESTRICT,
        FOREIGN KEY (topic_id) REFERENCES topics (id) ON DELETE SET NULL,
        FOREIGN KEY (created_by) REFERENCES users (id) ON DELETE RESTRICT,
        FOREIGN KEY (type) REFERENCES question_types (id) ON DELETE RESTRICT,
        FOREIGN KEY (difficulty) REFERENCES question_difficulties (id) ON DELETE RESTRICT,
        FOREIGN KEY (source) REFERENCES question_sources (id) ON DELETE RESTRICT,
        FOREIGN KEY (status) REFERENCES question_statuses (id) ON DELETE RESTRICT
    );

CREATE INDEX IF NOT EXISTS questions_organization_id_created_at_idx ON questions (organization_id, created_at DESC);
CREATE INDEX IF NOT EXISTS questions_organization_id_subject_id_grade_id_idx ON questions (organization_id, subject_id, grade_id);
CREATE INDEX IF NOT EXISTS questions_organization_id_type_difficulty_idx ON questions (organization_id, type, difficulty);
CREATE INDEX IF NOT EXISTS questions_created_by_idx ON questions (created_by);


-- -----------------------------------------------------------------------------
-- question_alternatives.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS question_alternatives (
        id UUID NOT NULL PRIMARY KEY,
        question_id UUID NOT NULL,
        label VARCHAR(10) NOT NULL,
        text TEXT NOT NULL,
        is_correct BOOLEAN NOT NULL DEFAULT FALSE,
        order_index INTEGER NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE CASCADE,
        CONSTRAINT uq_question_alternative_label UNIQUE (question_id, label),
        CONSTRAINT uq_question_alternative_order UNIQUE (question_id, order_index),
        CONSTRAINT ck_question_alternative_order CHECK (order_index >= 0)
    );

CREATE INDEX IF NOT EXISTS question_alternatives_question_id_order_index_idx ON question_alternatives (question_id, order_index);


-- -----------------------------------------------------------------------------
-- question_bncc_skills.sql
-- -----------------------------------------------------------------------------
-- A question can be associated with multiple BNCC skills, and a skill can
-- classify many questions.
CREATE TABLE
    IF NOT EXISTS question_bncc_skills (
        question_id UUID NOT NULL,
        skill_id UUID NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (question_id, skill_id),
        FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE CASCADE,
        FOREIGN KEY (skill_id) REFERENCES bncc_skills (id) ON DELETE RESTRICT
    );

CREATE INDEX IF NOT EXISTS question_bncc_skills_skill_id_idx ON question_bncc_skills (skill_id);


-- -----------------------------------------------------------------------------
-- assessment_questions.sql
-- -----------------------------------------------------------------------------
CREATE TABLE
    IF NOT EXISTS assessment_questions (
        id UUID NOT NULL PRIMARY KEY,
        assessment_id UUID NOT NULL,
        question_id UUID,
        order_index INTEGER NOT NULL,
        points NUMERIC(8, 2) NOT NULL DEFAULT 0,
        -- Optional snapshot preserves the content as it appeared when added.
        -- Application code should populate it when snapshot/version semantics are enabled.
        question_snapshot JSONB,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (assessment_id) REFERENCES assessments (id) ON DELETE CASCADE,
        FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE SET NULL,
        CONSTRAINT uq_assessment_question_order UNIQUE (assessment_id, order_index),
        CONSTRAINT ck_assessment_question_order CHECK (order_index >= 0),
        CONSTRAINT ck_assessment_question_points CHECK (points >= 0),
        CONSTRAINT ck_assessment_question_source CHECK (
            question_id IS NOT NULL
            OR question_snapshot IS NOT NULL
        )
    );

CREATE INDEX IF NOT EXISTS assessment_questions_question_id_idx ON assessment_questions (question_id);


-- -----------------------------------------------------------------------------
-- ai_generation_operations.sql
-- -----------------------------------------------------------------------------
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


-- -----------------------------------------------------------------------------
-- credit_transactions.sql
-- -----------------------------------------------------------------------------
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
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE RESTRICT,
        FOREIGN KEY (credit_account_id) REFERENCES credit_accounts (id) ON DELETE RESTRICT,
        FOREIGN KEY (generation_operation_id) REFERENCES ai_generation_operations (id) ON DELETE RESTRICT,
        FOREIGN KEY (created_by) REFERENCES users (id) ON DELETE SET NULL,
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

