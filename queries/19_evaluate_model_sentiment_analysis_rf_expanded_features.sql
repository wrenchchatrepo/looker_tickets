SELECT
  *
FROM
  ML.EVALUATE(MODEL `dion-miguel-0001.wc_ds_001.model_sentiment_analysis_rf_expanded`);

-- Understanding Key Metrics
-- Accuracy: The proportion of predictions that the model got right.
-- Precision: The ratio of true positive predictions to the total positive predictions. It measures the model's accuracy in classifying a sample as positive.
-- Recall: The ratio of true positive predictions to the total actual positives. It measures the model's ability to detect positive samples.
-- F1 Score: The harmonic mean of precision and recall. It balances both the precision and recall metrics.
-- Area Under the ROC Curve (AUC-ROC): A metric for binary classification models that measures the trade-off between the true positive rate and false positive rate. For multiclass classification, you might see AUC-PR (Precision-Recall Curve) instead.
-- Log Loss: Measures the uncertainty of the probabilities of your model's predictions.

-- [{
--   "precision": "1.0",
--   "recall": "1.0",
--   "accuracy": "1.0",
--   "f1_score": "1.0",
--   "log_loss": "0.19729428923517872",
--   "roc_auc": "1.0"
-- }]

-- Overfitting is a common concern when a model shows exceptionally high performance on its training data or a specific subset of the data. It may not generalize well to unseen data. It's essential to validate these results against an independent test set that the model hasn't encountered during its training phase.
-- Data Leakage
-- Data Leakage occurs when information from outside the training dataset is inadvertently used to create the model, leading to overly optimistic performance metrics. This could happen if the labels are somehow included in the feature set or if there's a feature that directly correlates with the outcome.
-- Evaluation Dataset
-- Ensure the evaluation dataset is correctly separated from the training dataset and that the split reflects a realistic scenario of how the model will be applied in production. This includes using a data_split_method that accurately partitions your data without mixing training and evaluation data.
-- Model and Data Validation
-- Validate Model with New Data: To ensure the model's robustness, test it with a completely new dataset that was not part of the initial training or evaluation sets.
-- Review the Feature Set and Data Preprocessing Steps: Double-check the features used to train the model and the preprocessing steps applied to the data to ensure there's no inadvertent data leakage.
-- Cross-validation: Consider using cross-validation techniques to assess the model's performance across different subsets of your data to ensure the model's stability and performance consistency.
-- Considerations for Deployment
-- If after thorough validation, the model genuinely achieves such high performance, document the development process, feature importance, and any special considerations in data preparation for future reference and model maintenance.
-- Before deploying the model into a production environment, consider setting up monitoring for model performance and drift over time to ensure it continues to perform as expected with new data.