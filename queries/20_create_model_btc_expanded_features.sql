CREATE OR REPLACE MODEL `dion-miguel-0001.wc_ds_001.model_sentiment_analysis_btc_expanded`
OPTIONS(
  model_type='BOOSTED_TREE_CLASSIFIER',
  input_label_cols=['Label'],
  data_split_method='RANDOM',
  data_split_eval_fraction=0.2,
  early_stop=TRUE,
  learn_rate=0.1,
  max_tree_depth=6,
  min_split_loss=0.01,
  num_parallel_tree=1
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


-- https://cloud.google.com/bigquery/docs/reference/standard-sql/bigqueryml-syntax-create-boosted-tree
-- Key Options and Hyperparameters:
-- model_type: Specifies the type of model to train, which is BOOSTED_TREE_CLASSIFIER for a gradient boosting model suitable for classification tasks.
-- input_label_cols: Indicates the column(s) that will be used as the label for model training. In your case, it's the Label column that likely contains the sentiment categories.
-- max_tree_depth: Controls the maximum depth of the trees. Deeper trees can capture more complex patterns but might lead to overfitting.
-- learn_rate: Determines the learning rate or the step size for updating predictions in each iteration. A smaller value may require more iterations but can lead to a more accurate model.
-- min_split_loss: The minimum loss reduction required to make a further partition on a leaf node of the tree. It can be used to control over-fitting.
-- max_iterations: Sets the maximum number of iterations for training, essentially controlling the number of trees in the model.
-- early_stop: When set to True, training will stop if the model's performance doesn't improve on the validation set.