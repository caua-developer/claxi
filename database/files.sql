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
