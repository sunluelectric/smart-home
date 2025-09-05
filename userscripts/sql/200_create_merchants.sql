-- Create a unified merchants table for all merchant types
-- Includes optional location, categorization, flags, and flexible metadata

CREATE TABLE IF NOT EXISTS merchants (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  name TEXT NOT NULL,                      -- Display name: "Coles", "Amazon"
  canonical_name TEXT,                     -- Optional normalized/merged name
  merchant_type TEXT,                      -- e.g. 'grocery', 'online_shop', 'restaurant'

  location_label TEXT,                     -- Free-form (e.g. 'Macquarie Centre')
  latitude DOUBLE PRECISION,               -- Optional: physical location
  longitude DOUBLE PRECISION,              -- Optional: physical location
  opening_hours JSONB,                     -- Optional: hours for physical stores

  is_digital BOOLEAN,                      -- True if goods/services are typically digital
  is_recurrent BOOLEAN,                    -- True if charges are usually recurring/subscription-based

  tags TEXT[],                             -- Program-friendly labels (e.g. ['australian', 'food'])
  properties JSONB,                        -- Arbitrary structured merchant-specific metadata
  notes TEXT,                              -- Human-facing comments or clarifications

  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Insert default "Others" merchant as a fallback
INSERT INTO merchants (
  id, name, canonical_name, merchant_type, tags, notes
)
VALUES (
  gen_random_uuid(),
  'Others',
  'Others',
  'uncategorized',
  ARRAY['fallback', 'unknown'],
  'Catch-all merchant for unmatched or unresolved transactions'
);
