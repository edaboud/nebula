BEGIN;

ALTER TABLE crawls ADD COLUMN network_id TEXT;

-- Existing cloud-infra deployments only crawled Ethereum execution before
-- this column existed. Future crawls set the value from the --network flag.
UPDATE crawls SET network_id = 'ETHEREUM_EXECUTION';

ALTER TABLE crawls ALTER COLUMN network_id SET NOT NULL;

CREATE INDEX idx_crawls_network_id_started_at ON crawls (network_id, started_at);

COMMENT ON COLUMN crawls.network_id IS 'The Nebula network identifier passed via the crawl --network flag.';

COMMIT;
