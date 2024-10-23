-- Step 1: Create the new table from the results of the confidence score calculation
CREATE OR REPLACE TABLE `looker-tickets.zendesk.confidence_score` AS
WITH agent_stats AS (
  SELECT 
    agent_name,
    COUNT(Ticket_ID) AS tickets,  -- Total number of tickets
    ROUND(AVG(Sentiment_Integer), 1) AS avg_sentiment_integer,  -- Avg sentiment score
    STDDEV(Sentiment_Integer) AS stddev_sentiment  -- Variability in sentiment score
  FROM `looker-tickets.zendesk.tickets_update`
  GROUP BY agent_name
),

-- Step 2: Calculate Confidence Score for each agent with a logarithmic scale for tickets
confidence_calc AS (
  SELECT
    agent_name,
    tickets,
    avg_sentiment_integer,
    stddev_sentiment,
    -- Confidence score formula: more tickets + less variability -> higher confidence
    CASE 
      WHEN stddev_sentiment IS NULL THEN 0  -- Handle cases with no standard deviation
      ELSE ROUND(LOG(tickets) / (1 + stddev_sentiment), 2)  -- Adjusted confidence score
    END AS confidence_score  -- Higher tickets and lower stddev lead to higher confidence
  FROM agent_stats
)

-- Step 3: Select final output for the new table
SELECT 
  agent_name,
  tickets,
  avg_sentiment_integer,
  confidence_score
FROM confidence_calc
ORDER BY confidence_score DESC, tickets DESC;