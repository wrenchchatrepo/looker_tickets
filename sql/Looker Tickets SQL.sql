UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(Comment by [a-zA-Z\s]+:)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)([a-zA-Z]+\s\([a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+\)\s//\sDoiT International\s\(Central Time \(US & Canada\)\))', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(Submission Date: \d{4}-\d{2}-\d{2} Requested by: [a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(Customer Name: [a-zA-Z0-9\s]+ Customer Region: [a-zA-Z\s]+ Customer Country: [a-zA-Z\s]+)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(Customer Segment: [a-zA-Z]+)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(Activity: [a-zA-Z\s]+)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(Technical Domain: [a-zA-Z\s]+)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(Cloud Provider: [a-zA-Z\s]+)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(Customer Type: [a-zA-Z\s]+)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(How would you rate the support you received?)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(Please submit your rating here.*?\[link\])', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(As the next step, I\'ll go ahead and close your ticket for now.)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(If you do not agree or need more assistance.*?reply to the ticket)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(Your time is much appreciated.*?support experience.)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(If you want to have questions answered about our DoiT products.*?DoiT Console Office Hours.*?Sign up HERE!)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;

UPDATE `looker-tickets.zendesk.conversations_update`
SET conversation_text = TRIM(REGEXP_REPLACE(conversation_text, r'(?i)(Zenrouter.*?below the threshold)', ''))
WHERE ARRAY_LENGTH(embeddings) = 0;