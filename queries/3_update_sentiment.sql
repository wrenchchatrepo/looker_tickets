UPDATE
  `dion-miguel-0001.wc_ds_001.tickets`
SET
  Sentiment =
  CASE
    WHEN Tickets_Rating = 'good' AND Tickets_Rating_Comment IS NOT NULL THEN 2
    WHEN Tickets_Rating = 'good' AND Tickets_Rating_Comment IS NULL THEN 1
    WHEN Tickets_Rating = 'bad' THEN 0
END
WHERE Tickets_Rating IN ('good','bad');