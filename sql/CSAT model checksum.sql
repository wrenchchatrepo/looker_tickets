SELECT
  Rating,
  avg(Rating_Comment_Length) as Comment_Length, 
  Sentiment_Integer, 
  sum(Count) as Tickets
FROM
  `looker-tickets.zendesk.new_tickets`
GROUP BY 1,3;

SELECT
  (SUM(CASE WHEN Sentiment_Integer = 4 THEN Count ELSE 0 END) + 
   SUM(CASE WHEN Sentiment_Integer = 3 THEN Count ELSE 0 END)) / 
  (SUM(Count) - SUM(CASE WHEN Sentiment_Integer = 2 THEN Count ELSE 0 END)) AS ratio
FROM
  `looker-tickets.zendesk.new_tickets`;