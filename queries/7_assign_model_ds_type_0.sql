UPDATE `dion-miguel-0001.wc_ds_001.tickets` AS t
SET Model_DS_Type = 
  CASE 
    WHEN row_number <= 182 THEN 'Train'
    WHEN row_number <= 182 + 45 THEN 'Eval'
    ELSE Model_DS_Type
  END
FROM (
  SELECT 
    Tickets_Ticket_ID,
    ROW_NUMBER() OVER (ORDER BY rand_num) AS row_number
  FROM (
    SELECT 
      Tickets_Ticket_ID,
      RAND() AS rand_num
    FROM `dion-miguel-0001.wc_ds_001.tickets`
    --WHERE Sentiment = 0
    --WHERE Sentiment = 1
    WHERE Sentiment = 2
    GROUP BY Tickets_Ticket_ID
  ) AS temp
) AS temp2
WHERE t.Tickets_Ticket_ID = temp2.Tickets_Ticket_ID;
