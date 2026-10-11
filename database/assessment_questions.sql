CREATE TABLE
    IF NOT EXISTS assessment_questions (
        id UUID NOT NULL PRIMARY KEY,
        assessment_id UUID NOT NULL,
        question_id UUID,
        order_index INTEGER NOT NULL,
        points NUMERIC(8, 2) NOT NULL DEFAULT 0,
        -- Optional snapshot preserves the content as it appeared when added.
        -- Application code should populate it when snapshot/version semantics are enabled.
        question_snapshot JSONB,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (assessment_id) REFERENCES assessments (id) ON DELETE CASCADE,
        FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE SET NULL,
        CONSTRAINT uq_assessment_question_order UNIQUE (assessment_id, order_index),
        CONSTRAINT ck_assessment_question_order CHECK (order_index >= 0),
        CONSTRAINT ck_assessment_question_points CHECK (points >= 0),
        CONSTRAINT ck_assessment_question_source CHECK (
            question_id IS NOT NULL
            OR question_snapshot IS NOT NULL
        )
    );

CREATE INDEX IF NOT EXISTS assessment_questions_question_id_idx ON assessment_questions (question_id);
