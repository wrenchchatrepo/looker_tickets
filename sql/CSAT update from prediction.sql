UPDATE `looker-tickets.zendesk.new_tickets` AS t
SET t.Sentiment_Integer = p.predicted_csat_category
FROM (
  SELECT
    ticket_id,
    predicted_csat_category
  FROM
    ML.PREDICT(
      MODEL `looker-tickets.zendesk.csat_boosted_tree_classifier`,
      (
        SELECT
          ticket_id,
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
          Average_Customer_Mrr
        FROM
          `looker-tickets.zendesk.new_tickets`
        WHERE
          Sentiment_Integer IS NULL
      )
    )
) AS p
WHERE t.ticket_id = p.ticket_id;