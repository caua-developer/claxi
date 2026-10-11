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
