-- Combined update using CASE with a WHERE clause
UPDATE `looker-tickets.zendesk.tickets`
SET 
  `Sentiment Heuristic` = CASE
    WHEN `Sentiment Heuristic` = "0 - no rating" THEN "no rating"
    ELSE `Sentiment Heuristic`
  END,
  `Sentiment Integer` = CASE
    WHEN `Sentiment Integer` = 1 THEN 0
    WHEN `Sentiment Integer` = 2 THEN 1
    WHEN `Sentiment Integer` = 3 THEN 2
    WHEN `Sentiment Integer` = 5 THEN 4
    ELSE `Sentiment Integer`
  END
WHERE 
  `Sentiment Heuristic` = "0 - no rating"
  OR `Sentiment Integer` IN (1, 2, 3, 5);