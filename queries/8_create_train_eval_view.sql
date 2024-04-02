CREATE OR REPLACE VIEW `dion-miguel-0001.wc_ds_001.tickets_sample_TRAIN_EVAL_view`
AS
SELECT *
FROM `dion-miguel-0001.wc_ds_001.tickets`
--WHERE Agent_Users_Name = "Dion Edge" 
WHERE Model_DS_Type IS NOT NULL