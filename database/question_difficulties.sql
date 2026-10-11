-- Lookup table for questions.difficulty values.
CREATE TABLE
    IF NOT EXISTS question_difficulties (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    question_difficulties (id, description)
VALUES
    ('EASY', 'Fácil'),
    ('MEDIUM', 'Médio'),
    ('HARD', 'Difícil') ON CONFLICT (id) DO NOTHING;