CREATE TABLE
    IF NOT EXISTS session (
        id UUID NOT NULL PRIMARY KEY,
        user_id UUID NOT NULL,
        organization_id UUID,
        ip_address TEXT,
        user_agent TEXT,
        last_used_at TIMESTAMPTZ,
        revoked_at TIMESTAMPTZ,
        created_at TIMESTAMPTZ NOT NULL,
        updated_at TIMESTAMPTZ NOT NULL,
        expires_at TIMESTAMPTZ NOT NULL,
        FOREIGN KEY (user_id) REFERENCES "user" (id) ON DELETE CASCADE,
        FOREIGN KEY (organization_id) REFERENCES organization (id) ON DELETE SET NULL
    );

CREATE INDEX IF NOT EXISTS session_user_id_idx ON session (user_id);
CREATE INDEX IF NOT EXISTS session_expires_at_idx ON session (expires_at);
