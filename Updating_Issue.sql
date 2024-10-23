1. Issues (Updating Issue column in tickets_update)

-- Temporary table to calculate best issue for each ticket using cosine similarity
CREATE OR REPLACE TABLE `looker-tickets.zendesk.temp_issues` AS
WITH issue_similarity AS (
  SELECT 
    cu.ticket_id,
    ak.Name AS best_issue,
    SUM(cu_emb * ak_emb) / (
      SQRT(SUM(POW(cu_emb, 2))) * SQRT(SUM(POW(ak_emb, 2)))
    ) AS similarity_score
  FROM 
    `looker-tickets.zendesk.AvaKeyWords` ak,
    `looker-tickets.zendesk.conversations_update_deduped` cu,
    UNNEST(cu.embeddings) AS cu_emb WITH OFFSET i
    JOIN UNNEST(ak.Embedding) AS ak_emb WITH OFFSET j
    ON i = j
  WHERE ak.Type = 'Issue'
  GROUP BY cu.ticket_id, ak.Name
)
SELECT
  ticket_id,
  best_issue
FROM
  issue_similarity
WHERE similarity_score = (
  SELECT MAX(similarity_score)
  FROM issue_similarity AS sim
  WHERE sim.ticket_id = issue_similarity.ticket_id
);

-- Update the tickets_update table with the best issue
UPDATE `looker-tickets.zendesk.tickets_update` tu
SET tu.Issue = (
  SELECT best_issue
  FROM `looker-tickets.zendesk.temp_issues` ti
  WHERE ti.ticket_id = tu.Ticket_ID
)
WHERE EXISTS (
  SELECT 1
  FROM `looker-tickets.zendesk.temp_issues` ti
  WHERE ti.ticket_id = tu.Ticket_ID
);





2. Resolutions (Updating Resolution column in tickets_update)

-- Temporary table to calculate best resolution for each ticket using cosine similarity
CREATE OR REPLACE TABLE `looker-tickets.zendesk.temp_resolutions` AS
WITH resolution_similarity AS (
  SELECT 
    cu.ticket_id,
    ak.Name AS best_resolution,
    SUM(cu_emb * ak_emb) / (
      SQRT(SUM(POW(cu_emb, 2))) * SQRT(SUM(POW(ak_emb, 2)))
    ) AS similarity_score
  FROM 
    `looker-tickets.zendesk.AvaKeyWords` ak,
    `looker-tickets.zendesk.conversations_update_deduped` cu,
    UNNEST(cu.embeddings) AS cu_emb WITH OFFSET i
    JOIN UNNEST(ak.Embedding) AS ak_emb WITH OFFSET j
    ON i = j
  WHERE ak.Type = 'Resolution'
  GROUP BY cu.ticket_id, ak.Name
)
SELECT
  ticket_id,
  best_resolution
FROM
  resolution_similarity
WHERE similarity_score = (
  SELECT MAX(similarity_score)
  FROM resolution_similarity AS sim
  WHERE sim.ticket_id = resolution_similarity.ticket_id
);

-- Update the tickets_update table with the best resolution
UPDATE `looker-tickets.zendesk.tickets_update` tu
SET tu.Resolution = (
  SELECT best_resolution
  FROM `looker-tickets.zendesk.temp_resolutions` tr
  WHERE tr.ticket_id = tu.Ticket_ID
)
WHERE EXISTS (
  SELECT 1
  FROM `looker-tickets.zendesk.temp_resolutions` tr
  WHERE tr.ticket_id = tu.Ticket_ID
);

3. Agent Score (Updating Agent_Score in tickets_update)

-- Temporary table for agent scores
CREATE OR REPLACE TABLE `looker-tickets.zendesk.temp_agent_scores` AS
SELECT
  cs.agent_name,
  cs.confidence_score
FROM 
  `looker-tickets.zendesk.confidence_score` cs;

-- Update the tickets_update table with agent scores
UPDATE `looker-tickets.zendesk.tickets_update` tu
SET tu.Agent_Score = (
  SELECT CAST(ts.confidence_score AS INT64)
  FROM `looker-tickets.zendesk.temp_agent_scores` ts
  WHERE ts.agent_name = tu.Agent_Name
)
WHERE EXISTS (
  SELECT 1
  FROM `looker-tickets.zendesk.temp_agent_scores` ts
  WHERE ts.agent_name = tu.Agent_Name
);

