-- Lookup table for questions.source values.
CREATE TABLE
    IF NOT EXISTS question_sources (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    question_sources (id, description)
VALUES
    ('MANUAL', 'Criada manualmente'),
    ('AI', 'Gerada por IA'),
    ('IMPORT', 'Importada')
ON CONFLICT (id) DO NOTHING;
