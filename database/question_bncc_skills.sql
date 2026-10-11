-- A question can be associated with multiple BNCC skills, and a skill can
-- classify many questions.
CREATE TABLE
    IF NOT EXISTS question_bncc_skills (
        question_id UUID NOT NULL,
        skill_id UUID NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (question_id, skill_id),
        FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE CASCADE,
        FOREIGN KEY (skill_id) REFERENCES bncc_skills (id) ON DELETE RESTRICT
    );

CREATE INDEX IF NOT EXISTS question_bncc_skills_skill_id_idx ON question_bncc_skills (skill_id);
