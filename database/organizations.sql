CREATE TABLE
    IF NOT EXISTS organizations (
        id UUID NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        slug TEXT NOT NULL UNIQUE,
        logo TEXT,
        metadata JSONB,
        created_at TIMESTAMPTZ NOT NULL
    );
