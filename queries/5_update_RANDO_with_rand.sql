  -- UPDATE `dion-miguel-0001.wc_ds_001.tickets`
  -- SET RANDO = RAND()
  -- WHERE TRUE;
  
UPDATE `dion-miguel-0001.wc_ds_001.tickets` AS t
SET t.RANDT = subquery.random_value
FROM (
  SELECT Tickets_Ticket_ID, RAND() AS random_value
  FROM `dion-miguel-0001.wc_ds_001.tickets`
  GROUP BY Tickets_Ticket_ID
) AS subquery
WHERE t.Tickets_Ticket_ID = subquery.Tickets_Ticket_ID
AND t.RANDT IS NULL; -- Or any other condition you might have to identify the rows to update

