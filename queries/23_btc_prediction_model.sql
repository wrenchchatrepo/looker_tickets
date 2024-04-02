CREATE OR REPLACE TABLE `dion-miguel-0001.wc_ds_001.conversations_predictions` AS
SELECT
  original.*,
  prediction.predicted_Label AS predicted_label,
  prediction.predicted_Label_probs
FROM
  `dion-miguel-0001.wc_ds_001.conversations_predict` AS original
JOIN
  ML.PREDICT(MODEL `dion-miguel-0001.wc_ds_001.model_sentiment_analysis_btc_expanded`, 
            (SELECT * FROM `dion-miguel-0001.wc_ds_001.conversations_predict`)) AS prediction
ON original.Ticket_ID = prediction.Ticket_ID;
