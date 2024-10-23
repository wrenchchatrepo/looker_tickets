  SELECT
  agent_name,
  count(Ticket_ID) as Tickets,
  round(AVG(Sentiment_Integer),1) AS avg_sentiment_integer,
  round(AVG(Average_Solve_Time_Hours),1) AS avg_solve_time_hours,
  round(AVG(Average_FRT_Hours),1) AS avg_frt_hours,
  round(AVG(total_comment_length),1) AS avg_total_comment_length,
  round(AVG(comment_count)) AS avg_comment_count,
  round(AVG(conversation_duration_days),1) AS avg_conversation_duration_days
FROM
  `looker-tickets.zendesk.tickets_update`
WHERE Product = "Looker"
GROUP BY
  agent_name
ORDER BY
  tickets desc;