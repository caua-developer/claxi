-- Lookup table for education_stage values used by grades, bncc_curricular_components and bncc_skills.
CREATE TABLE
    IF NOT EXISTS education_stages (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    education_stages (id, description)
VALUES
    ('EARLY_CHILDHOOD', 'Educação Infantil'),
    ('ELEMENTARY', 'Ensino Fundamental - Anos Iniciais'),
    ('MIDDLE_SCHOOL', 'Ensino Fundamental - Anos Finais'),
    ('HIGH_SCHOOL', 'Ensino Médio'),
    ('OTHER', 'Outro')
ON CONFLICT (id) DO NOTHING;
