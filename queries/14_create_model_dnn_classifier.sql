CREATE OR REPLACE MODEL `dion-miguel-0001.wc_ds_001.model_sentiment_analysis_dnn`
OPTIONS(
  model_type='DNN_CLASSIFIER',
  input_label_cols=['Label'],
  data_split_method='RANDOM',
  data_split_eval_fraction=0.2,
  hidden_units=[64, 32, 16], -- Example architecture, adjust based on your dataset
  learn_rate=0.01,
  max_iterations=100,
  early_stop=TRUE
) AS
SELECT
  Aggregated_Comments AS features,
  Label
FROM
  `dion-miguel-0001.wc_ds_001.conversations`;

-- https://cloud.google.com/bigquery/docs/reference/standard-sql/bigqueryml-syntax-create-dnn-models
-- Key Options for DNN_CLASSIFIER:
-- hidden_units: Specifies the architecture of the neural network in terms of the number of nodes in each hidden layer. The example [64, 32, 16] sets up a network with three hidden layers with 64, 32, and 16 nodes, respectively. Adjust this based on the complexity of your task and the size of your dataset.
-- learn_rate: The learning rate for the optimizer. A smaller learning rate may lead to better training results but will also require more iterations (training time).
-- max_iterations: Specifies the maximum number of training iterations. You might need to increase this for a deep neural network to ensure the model has enough iterations to learn effectively.
-- early_stop: When set to TRUE, training will stop if the model's performance on the evaluation dataset doesn't improve for a series of iterations, helping to prevent overfitting.
-- Considerations:
-- Data Preprocessing: Deep learning models can be particularly sensitive to how input data is prepared. Ensure your text data is appropriately tokenized, and consider using techniques like embedding layers if BigQuery ML's automatic text handling isn't giving optimal results.
-- Model Complexity and Overfitting: Deep neural networks have a higher risk of overfitting, especially with smaller datasets. Use early_stop and evaluate the model carefully to guard against this.
-- Training Time and Resources: DNN models can take longer to train and require more computational resources. Keep an eye on training time and costs in BigQuery.
-- Experimentation: Finding the right network architecture (hidden_units) and learning rate might require some experimentation. Start with simpler architectures and gradually increase complexity as needed based on performance.