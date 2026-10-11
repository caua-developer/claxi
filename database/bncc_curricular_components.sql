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
