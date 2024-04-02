SELECT
  AVG(CASE WHEN Label = predicted_Label THEN 1 ELSE 0 END) AS accuracy
FROM
  `dion-miguel-0001.wc_ds_001.conversations_predictions`;

-- [{
--   "accuracy": "0.24096275947386941"
-- }]

-- The accuracy of 0.2409 for your Boosted Trees model on the conversations_predict dataset indicates that the model is performing significantly below perfect accuracy, which is a more realistic outcome compared to previously observed perfect metrics. This suggests that the model may be facing challenges in generalizing from the training data to this new, unseen dataset. 