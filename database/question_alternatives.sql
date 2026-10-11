CREATE TABLE
    IF NOT EXISTS question_alternatives (
        id UUID NOT NULL PRIMARY KEY,
        question_id UUID NOT NULL,
        label VARCHAR(10) NOT NULL,
        text TEXT NOT NULL,
        is_correct BOOLEAN NOT NULL DEFAULT FALSE,
        order_index INTEGER NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE CASCADE,
        CONSTRAINT uq_question_alternative_label UNIQUE (question_id, label),
        CONSTRAINT uq_question_alternative_order UNIQUE (question_id, order_index),
        CONSTRAINT ck_question_alternative_order CHECK (order_index >= 0)
    );

CREATE INDEX IF NOT EXISTS question_alternatives_question_id_order_index_idx ON question_alternatives (question_id, order_index);
