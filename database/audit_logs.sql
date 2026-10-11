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
