CREATE TABLE
    IF NOT EXISTS account (
        id UUID NOT NULL PRIMARY KEY,
        user_id UUID NOT NULL,
        account_id TEXT NOT NULL,
        provider_id TEXT NOT NULL,
        access_token TEXT,
        refresh_token TEXT,
        access_token_expires_at TIMESTAMPTZ,
        refresh_token_expires_at TIMESTAMPTZ,
        scope TEXT,
        id_token TEXT,
        password TEXT,
        created_at TIMESTAMPTZ NOT NULL,
        updated_at TIMESTAMPTZ NOT NULL,
        FOREIGN KEY (user_id) REFERENCES "user" (id) ON DELETE CASCADE
    );

CREATE INDEX IF NOT EXISTS account_user_id_idx ON account (user_id);
