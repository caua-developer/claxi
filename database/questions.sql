CREATE TABLE
    IF NOT EXISTS questions (
        id UUID NOT NULL PRIMARY KEY,
        organization_id UUID NOT NULL,
        subject_id UUID,
        grade_id UUID,
        topic_id UUID,
        type TEXT NOT NULL,
        difficulty TEXT NOT NULL,
        statement TEXT NOT NULL,
        answer TEXT,
        explanation TEXT,
        created_by UUID NOT NULL,
        source TEXT NOT NULL DEFAULT 'MANUAL',
        generation_model VARCHAR(160),
        generation_prompt_version VARCHAR(80),
        status TEXT NOT NULL DEFAULT 'ACTIVE',
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (organization_id) REFERENCES organization (id) ON DELETE CASCADE,
        FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE RESTRICT,
        FOREIGN KEY (grade_id) REFERENCES grades (id) ON DELETE RESTRICT,
        FOREIGN KEY (topic_id) REFERENCES topics (id) ON DELETE SET NULL,
        FOREIGN KEY (created_by) REFERENCES "user" (id) ON DELETE RESTRICT,
        FOREIGN KEY (type) REFERENCES question_types (id) ON DELETE RESTRICT,
        FOREIGN KEY (difficulty) REFERENCES question_difficulties (id) ON DELETE RESTRICT,
        FOREIGN KEY (source) REFERENCES question_sources (id) ON DELETE RESTRICT,
        FOREIGN KEY (status) REFERENCES question_statuses (id) ON DELETE RESTRICT
    );

CREATE INDEX IF NOT EXISTS questions_organization_id_created_at_idx ON questions (organization_id, created_at DESC);
CREATE INDEX IF NOT EXISTS questions_organization_id_subject_id_grade_id_idx ON questions (organization_id, subject_id, grade_id);
CREATE INDEX IF NOT EXISTS questions_organization_id_type_difficulty_idx ON questions (organization_id, type, difficulty);
CREATE INDEX IF NOT EXISTS questions_created_by_idx ON questions (created_by);
