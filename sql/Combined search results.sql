CREATE OR REPLACE TABLE `looker-tickets.zendesk.combined_search_results` AS

WITH KeywordSearch AS (
  SELECT DISTINCT nc.Ticket_ID
  FROM `looker-tickets.zendesk.new_comments` nc
  JOIN `looker-tickets.zendesk.tickets_complete` tc ON nc.Ticket_ID = tc.Ticket_ID
  WHERE 
    ((LOWER(nc.Comment_Body) LIKE '%looker%'
    AND LOWER(nc.Comment_Body) LIKE '%oauth%')
    OR 
    (LOWER(nc.Comment_Body) LIKE '%google drive%'
    AND LOWER(nc.Comment_Body) LIKE '%looker%'))
    AND tc.Cloud_Platform = 'Google Cloud'
    AND tc.Created_Date > '2023-10-01'
),
SimilarityResults AS (
  SELECT
    tc.Ticket_ID,
    tc.Created_Date,
    tc.Priority,
    tc.Is_Escalated,
    tc.Is_Autosolved,
    tc.Is_Requester_From_Doit,
    tc.Is_Cloud_Support_Case_Used,
    tc.Cloud_Platform,
    tc.Practice_Area,
    tc.Skill_Group,
    tc.Product,
    tc.Subject,
    tc.Agent_Name,
    tc.Requester_Organization_Name,
    tc.Sentiment_Integer,
    tc.Average_Solve_Time_Hours,
    tc.comment_count,
    tc.conversation_duration_days,
    tc.Best_Matched_Issue,
    tc.Best_Matched_Resolution,
    ssr.similarity_score,
    'Similarity' AS search_method
  FROM
    `looker-tickets.zendesk.tickets_complete` tc
  INNER JOIN
    `looker-tickets.zendesk.similarity_search_results` ssr
  ON
    tc.Ticket_ID = ssr.ticket_id
  WHERE
    tc.Cloud_Platform = 'Google Cloud'
    AND tc.Created_Date > '2023-10-01'
    AND tc.Is_Cloud_Support_Case_Used is TRUE
)
SELECT * FROM SimilarityResults

UNION ALL

SELECT
  tc.Ticket_ID,
  tc.Created_Date,
  tc.Priority,
  tc.Is_Escalated,
  tc.Is_Autosolved,
  tc.Is_Requester_From_Doit,
  tc.Is_Cloud_Support_Case_Used,
  tc.Cloud_Platform,
  tc.Practice_Area,
  tc.Skill_Group,
  tc.Product,
  tc.Subject,
  tc.Agent_Name,
  tc.Requester_Organization_Name,
  tc.Sentiment_Integer,
  tc.Average_Solve_Time_Hours,
  tc.comment_count,
  tc.conversation_duration_days,
  tc.Best_Matched_Issue,
  tc.Best_Matched_Resolution,
  NULL AS similarity_score,
  'Keyword' AS search_method
FROM
  `looker-tickets.zendesk.tickets_complete` tc
INNER JOIN
  KeywordSearch ks
ON
  tc.Ticket_ID = ks.Ticket_ID
ORDER BY
  Ticket_ID ASC
