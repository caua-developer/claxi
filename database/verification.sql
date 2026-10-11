CREATE TABLE
    IF NOT EXISTS verification (
        id UUID NOT NULL PRIMARY KEY,
        identifier TEXT NOT NULL,
        value TEXT NOT NULL,
        expires_at TIMESTAMPTZ NOT NULL,
        created_at TIMESTAMPTZ NOT NULL,
        updated_at TIMESTAMPTZ NOT NULL
    );

CREATE INDEX IF NOT EXISTS verification_identifier_idx ON verification (identifier);
