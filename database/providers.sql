-- Lookup table for accounts.provider_id values.
CREATE TABLE
    IF NOT EXISTS providers (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    providers (id, description)
VALUES
    ('GOOGLE', 'Google OAuth'),
    ('PASSWORD', 'Senha (local)')
ON CONFLICT (id) DO NOTHING;
