-- Lookup table for assessments.type values.
CREATE TABLE
    IF NOT EXISTS assessment_types (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    assessment_types (id, description)
VALUES
    ('TEST', 'Prova'),
    ('EXERCISE_LIST', 'Lista de exercícios'),
    ('SIMULATED_EXAM', 'Simulado')
ON CONFLICT (id) DO NOTHING;
