-- Lookup table for questions.status values.
CREATE TABLE
    IF NOT EXISTS question_statuses (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    question_statuses (id, description)
VALUES
    ('ACTIVE', 'Ativa'),
    ('ARCHIVED', 'Arquivada')
ON CONFLICT (id) DO NOTHING;
