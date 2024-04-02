SELECT 
  Sentiment, 
  Sentiment_Assigned,
  Tickets_Rating,
  Model_DS_Type,
  COUNT(IFNULL(Tickets_Rating_Comment, '0')) AS NoCommentCount, 
  COUNT(IF(Tickets_Rating_Comment IS NOT NULL, 1, NULL)) AS YesCommentCount, 
  Count(DISTINCT Tickets_Ticket_ID) AS TicketCount,      
  SUM(Ticket_Comment_Comment_Count) AS CommentCount, 
  AVG(RANDO) AS AvgRANDO, 
  AVG(RANDT) AS AvgRANDT
FROM `dion-miguel-0001.wc_ds_001.tickets`
GROUP BY
  Sentiment, 
  Sentiment_Assigned,
  Tickets_Rating,
  Model_DS_Type
order by 1,4 asc
LIMIT 100;
