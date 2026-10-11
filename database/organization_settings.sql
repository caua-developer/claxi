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