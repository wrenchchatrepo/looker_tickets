SELECT
  AVG(CASE WHEN Label = predicted_Label THEN 1 ELSE 0 END) AS accuracy
FROM
  `dion-miguel-0001.wc_ds_001.conversations_predictions_lr`;

-- [{
--   "accuracy": "0.24098095220768889"
-- }]

-- The accuracy of the logistic regression model (model_sentiment_analysis_lr_expanded) on the conversations_predict dataset, being approximately 0.241, suggests that the model's performance on this new, unseen data is considerably below optimal. This level of accuracy indicates that the model correctly predicts the label for roughly 24% of the instances in the dataset, which is relatively low, especially in comparison to the near-perfect performance metrics observed in previous evaluations on different data. 