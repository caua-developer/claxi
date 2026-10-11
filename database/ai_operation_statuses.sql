-- Lookup table for ai_generation_operations.status values.
CREATE TABLE
    IF NOT EXISTS ai_operation_statuses (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    ai_operation_statuses (id, description)
VALUES
    ('PENDING', 'Pendente'),
    ('RUNNING', 'Em execução'),
    ('SUCCEEDED', 'Concluída com sucesso'),
    ('FAILED', 'Falhou'),
    ('CANCELLED', 'Cancelada')
ON CONFLICT (id) DO NOTHING;
