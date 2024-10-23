SELECT
  CORR(Sentiment_Integer, Average_Solve_Time_Hours) AS corr_solve_time_cs,
  CORR(Sentiment_Integer, Average_FRT_Hours) AS corr_frt_cs,
  CORR(Sentiment_Integer, total_comment_length) AS corr_comment_length_cs,
  CORR(Sentiment_Integer, comment_count) AS corr_comment_count_cs,
  CORR(Sentiment_Integer, conversation_duration_days) AS corr_conversation_duration_cs
FROM
  `looker-tickets.zendesk.tickets_update`
WHERE Product = "Looker";