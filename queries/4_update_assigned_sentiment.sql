UPDATE
  `dion-miguel-0001.wc_ds_001.tickets`
SET
  Sentiment_Assigned = CASE
    WHEN Sentiment = 2 THEN 'Positive'
    WHEN Sentiment = 1 THEN 'Neutral'
    WHEN Sentiment = 0 THEN 'Negative'
    ELSE 'Unassigned'  -- Handles NULL and any unexpected Sentiment values
  END
WHERE
  Sentiment IN (0, 1, 2); -- Optional, depending on your needs
