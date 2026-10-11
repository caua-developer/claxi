-- Lookup table for files.purpose values.
CREATE TABLE
    IF NOT EXISTS file_purposes (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    file_purposes (id, description)
VALUES
    ('PDF_EXPORT', 'Exportação em PDF'),
    ('LOGO', 'Logotipo'),
    ('IMPORT', 'Importação'),
    ('OTHER', 'Outro')
ON CONFLICT (id) DO NOTHING;
