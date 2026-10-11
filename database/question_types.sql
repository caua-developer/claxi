-- Lookup table for questions.type values.
CREATE TABLE
    IF NOT EXISTS question_types (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    question_types (id, description)
VALUES
    ('MULTIPLE_CHOICE', 'Múltipla escolha'),
    ('TRUE_FALSE', 'Verdadeiro ou falso'),
    ('OPEN_ENDED', 'Dissertativa')
ON CONFLICT (id) DO NOTHING;
