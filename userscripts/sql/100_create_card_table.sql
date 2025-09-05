-- 100_create_cards_table.sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Define enum for card status (safe for re-execution)
DO $$
BEGIN
IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'card_status') THEN
CREATE TYPE card_status AS ENUM ('in_use', 'replaced', 'lost', 'closed');
END IF;
END
$$;

CREATE TABLE IF NOT EXISTS cards (
id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
name TEXT NOT NULL,
issuer TEXT NOT NULL,
network TEXT NOT NULL,
last4 CHAR(4) NOT NULL,
status card_status NOT NULL,
opened_on DATE,
closed_on DATE,
expires_on DATE NOT NULL,
tags JSONB,
notes TEXT,
created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);