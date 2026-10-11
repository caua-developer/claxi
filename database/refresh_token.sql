CREATE TABLE
    IF NOT EXISTS refresh_token (
        id UUID NOT NULL PRIMARY KEY,
        session_id UUID NOT NULL,
        token_hash TEXT NOT NULL UNIQUE,
        revoked_at TIMESTAMPTZ,
        created_at TIMESTAMPTZ NOT NULL,
        expires_at TIMESTAMPTZ NOT NULL,
        FOREIGN KEY (session_id) REFERENCES session (id) ON DELETE CASCADE
    );

CREATE INDEX IF NOT EXISTS refresh_token_session_id_idx ON refresh_token (session_id);
CREATE INDEX IF NOT EXISTS refresh_token_expires_at_idx ON refresh_token (expires_at);
