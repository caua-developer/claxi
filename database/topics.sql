CREATE TABLE
    IF NOT EXISTS topics (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL,
        subject_id UUID NOT NULL,
        name VARCHAR(160) NOT NULL,
        description TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organization (id) ON DELETE CASCADE,
        FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE RESTRICT,
        CONSTRAINT uq_topics_subject_name UNIQUE (subject_id, name)
    );

CREATE INDEX IF NOT EXISTS topics_organization_id_idx ON topics (organization_id);
CREATE INDEX IF NOT EXISTS topics_subject_id_idx ON topics (subject_id);
