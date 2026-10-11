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
