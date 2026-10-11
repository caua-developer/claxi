-- Lookup table for ai_generation_operations.operation_type values.
CREATE TABLE
    IF NOT EXISTS ai_operation_types (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    ai_operation_types (id, description)
VALUES
    ('QUESTION_GENERATION', 'Geração de questão'),
    ('QUESTION_REGENERATION', 'Regeneração de questão')
ON CONFLICT (id) DO NOTHING;
