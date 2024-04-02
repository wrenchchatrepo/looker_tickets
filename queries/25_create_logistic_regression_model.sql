CREATE OR REPLACE MODEL `dion-miguel-0001.wc_ds_001.model_sentiment_analysis_lr_expanded`
OPTIONS(
  model_type='LOGISTIC_REG',
  input_label_cols=['Label'],
  data_split_method='RANDOM',
  data_split_eval_fraction=0.2,
  early_stop=TRUE,
  l1_reg=1, -- L1 regularization can be adjusted to manage model complexity
  l2_reg=1  -- L2 regularization can be adjusted to manage model complexity
) AS
SELECT
  Aggregated_Comments,
  Rating,
  Rating_Comment,
  Rating_Is_Bad_Count,
  Rating_Is_Good_Count,
  Rating_Is_Not_Offered_Count,
  Subject,
  Product,
  Priority,
  Agent_Name,
  Agent_Region,
  Customer_Name,
  Requester_Region,
  Was_Ticket_Autosolved,
  Is_Escalated,
  Average_First_Response_Time_Hours,
  Average_Customer_Mrr,
  Total_Comments,
  Label
FROM
  `dion-miguel-0001.wc_ds_001.conversations`;


-- https://cloud.google.com/bigquery/docs/reference/standard-sql/bigqueryml-syntax-create-glm
-- Considerations for Logistic Regression:
-- Regularization: The l1_reg and l2_reg options apply L1 and L2 regularization, respectively. Regularization can help prevent overfitting by penalizing large coefficients. Adjust these values based on your model's performance and complexity.
-- Feature Preprocessing: Logistic regression benefits from feature scaling and normalization, especially when combining different types of data (numerical and categorical). Consider preprocessing steps to standardize your features.
-- Categorical Features: BigQuery ML automatically handles categorical features using one-hot encoding. However, for features with a large number of categories, consider feature engineering to reduce dimensionality.
-- Model Evaluation: After training, evaluate the model's performance using ML.EVALUATE and other relevant metrics specific to your problem. For binary classification tasks, metrics like precision, recall, AUC-ROC, and F1 score are particularly useful.
