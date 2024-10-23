SELECT
  Best_Matched_Issue,
  Best_Matched_Resolution,
  avg(Best_Issue_Similarity) as avg_Best_Issue_Similarity,
  avg(Best_Resolution_Similarity) as avg_Best_Resolution_Similarity,
  COUNT(*) AS Ticket_Count
FROM
  `looker-tickets.zendesk.tickets_complete`
GROUP BY
  1,
  2;