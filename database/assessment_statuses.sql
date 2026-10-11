-- Lookup table for assessments.status values.
CREATE TABLE
    IF NOT EXISTS assessment_statuses (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    assessment_statuses (id, description)
VALUES
    ('DRAFT', 'Rascunho'),
    ('PUBLISHED', 'Publicada'),
    ('ARCHIVED', 'Arquivada')
ON CONFLICT (id) DO NOTHING;
