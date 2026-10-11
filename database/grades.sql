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
