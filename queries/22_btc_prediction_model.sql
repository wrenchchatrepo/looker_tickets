SELECT
  *,
  predicted_Label,
  predicted_Label_probs
FROM
  ML.PREDICT(MODEL `dion-miguel-0001.wc_ds_001.model_sentiment_analysis_btc_expanded`, 
            (SELECT
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
               Total_Comments
             FROM
               `dion-miguel-0001.wc_ds_001.conversations_predict`));


-- Key Considerations:
-- Feature Matching: Ensure that the features used for prediction in conversations_predict match those used for training the model in terms of naming, order, and preprocessing. Any mismatch could lead to incorrect predictions.
-- Handling Missing Values: If your conversations_predict dataset contains missing values in columns that were present during model training, make sure to handle them appropriately. This might involve imputing missing values based on the strategy used during training or ensuring your model can handle missing values directly.
-- Interpreting Results:
-- predicted_Label: This column will contain the predicted sentiment class for each record in your conversations_predict dataset.
-- predicted_Label_probs: This column shows the probability distribution across all possible classes. It's particularly useful for understanding the model's confidence in its predictions.
-- Performance Monitoring: Keep an eye on how the model performs on this larger dataset. Depending on your use case, you might want to track metrics such as precision and recall for specific classes, especially if your dataset is imbalanced.
-- Batch Prediction: If conversations_predict is significantly large, consider using BigQuery's batch prediction capabilities to manage compute resources more efficiently and potentially reduce costs.