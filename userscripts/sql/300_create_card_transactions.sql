-- 300_create_card_transactions_table.sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


CREATE TABLE IF NOT EXISTS card_transactions (
id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
card_id UUID NOT NULL REFERENCES cards(id),
merchant_id UUID NOT NULL REFERENCES merchants(id),
date DATE NOT NULL,
amount NUMERIC(10, 2) NOT NULL,
currency CHAR(3) NOT NULL DEFAULT 'AUD',
raw_entity TEXT NOT NULL,
tags JSONB,
notes TEXT,
statement_id TEXT,
imported_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);