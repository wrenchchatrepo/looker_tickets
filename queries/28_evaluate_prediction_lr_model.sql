CREATE OR REPLACE TABLE `dion-miguel-0001.wc_ds_001.conversations_predictions_lr` AS
SELECT
  conversation.*,
  prediction.predicted_Label,
  prediction.predicted_Label_probs
FROM
  `dion-miguel-0001.wc_ds_001.conversations_predict` AS conversation
JOIN
  ML.PREDICT(MODEL `dion-miguel-0001.wc_ds_001.model_sentiment_analysis_lr_expanded`,
            (SELECT * FROM `dion-miguel-0001.wc_ds_001.conversations_predict`)) AS prediction
ON conversation.Ticket_ID = prediction.Ticket_ID;
