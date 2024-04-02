SELECT
  *
FROM
  ML.EVALUATE(MODEL `dion-miguel-0001.wc_ds_001.model_sentiment_analysis_dnn`);

-- Understanding Key Metrics
-- Accuracy: The proportion of predictions that the model got right.
-- Precision: The ratio of true positive predictions to the total positive predictions. It measures the model's accuracy in classifying a sample as positive.
-- Recall: The ratio of true positive predictions to the total actual positives. It measures the model's ability to detect positive samples.
-- F1 Score: The harmonic mean of precision and recall. It balances both the precision and recall metrics.
-- Area Under the ROC Curve (AUC-ROC): A metric for binary classification models that measures the trade-off between the true positive rate and false positive rate. For multiclass classification, you might see AUC-PR (Precision-Recall Curve) instead.
-- Log Loss: Measures the uncertainty of the probabilities of your model's predictions.

-- [{
--   "precision": "0.10416666666666667",
--   "recall": "0.33333333333333337",
--   "accuracy": "0.3125",
--   "f1_score": "0.15873015873015872",
--   "log_loss": "1.0995275472602697",
--   "roc_auc": "0.0"
-- }]

-- Analysis of Metrics
-- Precision (0.1042): Similar to the previous model, the precision is low, indicating a high number of false positives.
-- Recall (0.3333): The recall is unchanged, suggesting the model identifies only a third of the actual positive cases correctly.
-- Accuracy (0.3125): A slight decrease in accuracy compared to the BOOSTED_TREE_CLASSIFIER. This might indicate the DNN is not capturing the patterns effectively or is overfitting to the training data.
-- F1 Score (0.1587): The F1 score, which balances precision and recall, remains low, reflecting the overall challenge in correctly classifying positive cases.
-- Log Loss (1.0995): This metric indicates the confidence of the predictions. Similar to the previous model, there's room for improvement.
-- ROC AUC (0.0): An AUC of 0.0 again indicates a serious issue. It suggests the model is not learning to discriminate between classes at all.