CREATE OR REPLACE MODEL `looker-tickets.zendesk.csat_boosted_tree_classifier`
OPTIONS(
  model_type = 'boosted_tree_classifier',
  input_label_cols = ['csat_category'], -- Target CSAT category column
  max_iterations = 50 -- Adjust for performance
) AS
SELECT
  -- Features as per your list
  Priority,
  Is_Escalated,
  Is_FRT_Slo_Breach,
  Is_Autosolved,
  Is_Cloud_Support_Case_Used,
  Cloud_Platform,
  Product,
  Agent_Time_Zone,
  Requester_Time_Zone,
  Requester_Region,
  Average_Solve_Time_Hours,
  Average_Customer_Mrr,
  
  -- Use Sentiment_Integer as the target label (csat_category)
  CAST(Sentiment_Integer AS INT64) AS csat_category
FROM
  `looker-tickets.zendesk.new_tickets`
WHERE
  Sentiment_Integer IS NOT NULL;