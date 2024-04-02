CREATE OR REPLACE MODEL `dion-miguel-0001.wc_ds_001.model_sentiment_analysis_rf`
OPTIONS(
  MODEL_TYPE='RANDOM_FOREST_CLASSIFIER',
  INPUT_LABEL_COLS=['Label'],
  DATA_SPLIT_METHOD='RANDOM',
  DATA_SPLIT_EVAL_FRACTION=0.2,
  NUM_PARALLEL_TREE=100, -- Specifies the number of trees in the forest.
  MAX_TREE_DEPTH=10, -- Controls the depth of each tree.
  MIN_SPLIT_LOSS=0.01, -- Minimum loss reduction required to make a further partition on a leaf node.
  EARLY_STOP=TRUE,
  SUBSAMPLE=0.8 -- The subsample ratio of the training instances.
) AS
SELECT
  Aggregated_Comments AS features,
  Label
FROM
  `dion-miguel-0001.wc_ds_001.conversations`;


-- https://cloud.google.com/bigquery/docs/reference/standard-sql/bigqueryml-syntax-create-random-forest
-- Key Options for RANDOM_FOREST_CLASSIFIER:
-- num_trees: This specifies the number of trees in the forest. A higher number of trees can lead to better performance but also increases computation time.
-- max_tree_depth: Controls how deep each tree can grow. Deeper trees can capture more complex patterns but might lead to overfitting.
-- min_examples_per_leaf: Setting this helps prevent a tree from growing too complex by specifying the minimum number of samples required to be at a leaf node.
-- early_stop: When set to TRUE, training will stop if the model's performance on the evaluation dataset doesn't improve for a series of iterations. This helps to prevent overfitting.
-- Explanation of Additional Options:
-- NUM_PARALLEL_TREE: Sets the number of parallel trees constructed during each iteration, which is directly tied to the model's complexity and performance. The default value is 100, indicating a robust forest, but you can adjust this number based on your dataset size and complexity.
-- SUBSAMPLE: This parameter specifies the subsample ratio of the training instances used for constructing each tree. Setting this value less than 1.0 can prevent overfitting by training each tree on a random subset of the data.
-- Considerations:
-- Random Forest models can handle a mix of numerical and categorical data well, but for text data (like your Aggregated_Comments), ensure it's suitably vectorized or transformed into a format the model can work with effectively.
-- Feature Importance: One of the advantages of using Random Forest models is that you can gain insights into which features (words or tokens in the case of text data) are most important for making predictions. This can be valuable for understanding your model and making improvements.
-- Model Evaluation: After training, use ML.EVALUATE to assess your model's performance. Given the previous challenges with precision, recall, and ROC AUC, it will be crucial to see if the Random Forest model offers improvements in these areas.
-- Hyperparameter Tuning: While Random Forest models are generally less sensitive to hyperparameter changes than deep learning models, experimenting with num_trees, max_tree_depth, and min_examples_per_leaf can help you find an optimal balance between model complexity and generalization ability.
