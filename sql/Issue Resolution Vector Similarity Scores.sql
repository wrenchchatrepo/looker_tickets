WITH ranked_scores AS (
  SELECT
    ticket_id,
    Type,
    Name,
    similarity,
    ROW_NUMBER() OVER (PARTITION BY ticket_id, Type ORDER BY similarity DESC) AS rank
  FROM `looker-tickets.zendesk.vector_similarity_scores`
),
top_scores AS (
  SELECT
    ticket_id,
    MAX(CASE WHEN Type = 'Issue' THEN Name END) AS Matched_Issue,
    MAX(CASE WHEN Type = 'Issue' THEN similarity END) AS Issue_Similarity,
    MAX(CASE WHEN Type = 'Resolution' THEN Name END) AS Matched_Resolution,
    MAX(CASE WHEN Type = 'Resolution' THEN similarity END) AS Resolution_Similarity
  FROM ranked_scores
  WHERE rank = 1
  GROUP BY ticket_id
)
SELECT
  ts.ticket_id AS Ticket_ID,
  ts.Matched_Issue,
  ts.Matched_Resolution,
  ts.Issue_Similarity,
  ts.Resolution_Similarity
FROM top_scores ts
ORDER BY ts.ticket_id;

UPDATE `looker-tickets.zendesk.tickets_with_best_matches` tum
SET
  tum.Best_Issue = ts.Matched_Issue,
  tum.Best_Resolution = ts.Matched_Resolution,
  tum.Issue_Similarity = ts.Issue_Similarity,
  tum.Resolution_Similarity = ts.Resolution_Similarity
FROM (
  WITH ranked_scores AS (
    SELECT
      ticket_id,
      Type,
      Name,
      similarity,
      ROW_NUMBER() OVER (PARTITION BY ticket_id, Type ORDER BY similarity DESC) AS rank
    FROM `looker-tickets.zendesk.vector_similarity_scores`
  )
  SELECT
    ticket_id,
    MAX(CASE WHEN Type = 'Issue' THEN Name END) AS Matched_Issue,
    MAX(CASE WHEN Type = 'Issue' THEN similarity END) AS Issue_Similarity,
    MAX(CASE WHEN Type = 'Resolution' THEN Name END) AS Matched_Resolution,
    MAX(CASE WHEN Type = 'Resolution' THEN similarity END) AS Resolution_Similarity
  FROM ranked_scores
  WHERE rank = 1
  GROUP BY ticket_id
) ts
WHERE tum.Ticket_ID = ts.ticket_id;

WITH ranked_scores AS (
  SELECT
    ticket_id,
    Type,
    Name,
    similarity,
    ROW_NUMBER() OVER (PARTITION BY ticket_id, Type ORDER BY similarity DESC) AS rank
  FROM `looker-tickets.zendesk.vector_similarity_scores`
),
top_scores AS (
  SELECT
    ticket_id,
    Type,
    Name
  FROM ranked_scores
  WHERE rank = 1
)
SELECT
  Type,
  Name,
  COUNT(DISTINCT ticket_id) AS ticket_count
FROM top_scores
GROUP BY Type, Name
ORDER BY Type, ticket_count DESC, Name;