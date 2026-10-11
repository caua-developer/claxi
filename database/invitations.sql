CREATE TABLE
    IF NOT EXISTS invitations (
        id UUID NOT NULL PRIMARY KEY,
        email TEXT NOT NULL,
        inviter_id UUID NOT NULL,
        organization_id UUID NOT NULL,
        role TEXT,
        status TEXT NOT NULL,
        created_at TIMESTAMPTZ NOT NULL,
        updated_at TIMESTAMPTZ NOT NULL,
        expires_at TIMESTAMPTZ NOT NULL,
        FOREIGN KEY (inviter_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE
    );
