-- Lookup table for credit_transactions.transaction_type values.
CREATE TABLE
    IF NOT EXISTS credit_transaction_types (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    );

INSERT INTO
    credit_transaction_types (id, description)
VALUES
    ('PURCHASE', 'Compra'),
    ('GRANT', 'Concessão'),
    ('CONSUMPTION', 'Consumo'),
    ('REFUND', 'Reembolso'),
    ('ADJUSTMENT', 'Ajuste')
ON CONFLICT (id) DO NOTHING;
