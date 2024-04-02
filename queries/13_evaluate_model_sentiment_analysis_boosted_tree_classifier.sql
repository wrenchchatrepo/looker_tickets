SELECT
  *
FROM
  ML.EVALUATE(MODEL `dion-miguel-0001.wc_ds_001.model_sentiment_analysis`);

-- Understanding Key Metrics
-- Accuracy: The proportion of predictions that the model got right.
-- Precision: The ratio of true positive predictions to the total positive predictions. It measures the model's accuracy in classifying a sample as positive.
-- Recall: The ratio of true positive predictions to the total actual positives. It measures the model's ability to detect positive samples.
-- F1 Score: The harmonic mean of precision and recall. It balances both the precision and recall metrics.
-- Area Under the ROC Curve (AUC-ROC): A metric for binary classification models that measures the trade-off between the true positive rate and false positive rate. For multiclass classification, you might see AUC-PR (Precision-Recall Curve) instead.
-- Log Loss: Measures the uncertainty of the probabilities of your model's predictions.


-- [{
--   "precision": "0.10874704491725769",
--   "recall": "0.33333333333333331",
--   "accuracy": "0.32624113475177308",
--   "f1_score": "0.16399286987522282",
--   "log_loss": "1.0991256531689291",
--   "roc_auc": "0.0"
-- }]

-- Understanding the Metrics:
-- Precision (0.1087): Low precision indicates that, of all the instances your model predicted to be positive (or a specific class), only about 10.87% were actually positive. This suggests the model generates many false positives.
-- Recall (0.3333): This suggests that the model is able to correctly identify 33.33% of all actual positive cases. While not exceedingly low, there's significant room for improvement in capturing more true positives.
-- Accuracy (0.3262): An accuracy of about 32.62% shows that the model correctly predicts the sentiment for roughly one-third of the comments. Considering most sentiment analysis tasks aim for higher accuracy, this indicates the model is struggling.
-- F1 Score (0.1640): The F1 score combines precision and recall into a single metric, with a high score indicating both high precision and high recall. A low F1 score here reflects the model's challenges with both precision and recall.
-- Log Loss (1.0991): This measures the uncertainty of your model's predictions. Lower values are better, and while this isn't exceedingly high, improvements can still be made.
-- ROC AUC (0.0): An AUC of 0 suggests a problem. It could be an issue with the data, labels, or how the model is applied. ROC AUC values range from 0 to 1, with 0.5 indicating no discriminative power (equivalent to random guessing), and 1 indicating perfect prediction. A value of 0 is highly unusual and suggests a critical look at the model setup and data.
-- Steps for Improvement:
-- Data Quality and Balance: Ensure your dataset is of high quality, correctly labeled, and balanced among classes. Imbalanced data can significantly impact model performance, especially for metrics like precision and recall.
-- Feature Engineering: Consider revising how you're preparing your text data. More informative features or different text preprocessing techniques (like tokenization, stemming, or using n-grams) might capture the nuances of language better.
-- Model Complexity: The BOOSTED_TREE_CLASSIFIER might not be the best fit for your data. Consider experimenting with other model types, like DNN_CLASSIFIER for potentially capturing complex patterns in text data.
-- Hyperparameter Tuning: Adjusting the model's hyperparameters can significantly impact performance. Consider experimenting with different settings for learn_rate, max_tree_depth, min_split_loss, and max_iterations.
-- Cross-validation: Instead of a single train-test split, consider using cross-validation to ensure your model's performance is consistent across different subsets of your data.
-- Evaluation Strategy: Double-check your evaluation methodology. Ensure the dataset used for evaluation is representative and has not been seen by the model during training.
-- ROC AUC of 0.0: This metric, in particular, needs attention. It suggests there might be a fundamental issue with how the model is predicting or with the data itself. Verify that the positive and negative classes are correctly labeled and that the model isn't defaulting to predict only one class.