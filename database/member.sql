CREATE TABLE
    IF NOT EXISTS member (
        id UUID NOT NULL PRIMARY KEY,
        user_id UUID NOT NULL,
        organization_id UUID NOT NULL,
        role TEXT NOT NULL,
        created_at TIMESTAMPTZ NOT NULL,
        updated_at TIMESTAMPTZ NOT NULL,
        FOREIGN KEY (user_id) REFERENCES "user" (id) ON DELETE CASCADE,
        FOREIGN KEY (organization_id) REFERENCES organization (id) ON DELETE CASCADE
    );
