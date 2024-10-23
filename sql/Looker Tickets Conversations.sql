

-- SQL1: Calculate the total byte size of the conversation_text field in the original table
-- SELECT SUM(BYTE_LENGTH(conversation_text)) AS total_conversation_text_bytes
-- FROM `looker-tickets.zendesk.conversations`;
-- 856351803

-- Step 2: Create a New Table with ticket_id, conversation_text, and embedding
-- SELECT 
--   ticket_id,
--   TRIM(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(conversation_text, r'[^\w\s]', ''), r'(https?://[^\s]+|www\.[^\s]+|\S+@\S+\.\S+)', ''), r'[\n\r\s]+', ' ')) AS conversation_text,
--   ARRAY<FLOAT64>[] AS embeddings 
-- FROM
--   `looker-tickets.zendesk.conversations`
-- WHERE
--   ARRAY_LENGTH(embeddings) = 0;

-- SQL3: Calculate the total byte size of the conversation_text field in the new table
-- SELECT SUM(BYTE_LENGTH(conversation_text)) AS total_bytes FROM `looker-tickets.zendesk.conversations_update`;
-- 766015712