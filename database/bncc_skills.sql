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
