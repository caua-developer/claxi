CREATE TABLE
    IF NOT EXISTS tenant_settings (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL,
        setting_key VARCHAR(120) NOT NULL,
        setting_value JSONB NOT NULL,
        updated_by UUID,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organization (id) ON DELETE CASCADE,
        FOREIGN KEY (updated_by) REFERENCES "user" (id) ON DELETE SET NULL,
        CONSTRAINT uq_tenant_settings_org_key UNIQUE (organization_id, setting_key)
    );

CREATE INDEX IF NOT EXISTS tenant_settings_organization_id_idx ON tenant_settings (organization_id);
